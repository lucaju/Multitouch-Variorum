package view.reader {
	
	//imports
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import flashx.textLayout.tlf_internal;
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.SubParagraphGroupElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.events.TextLayoutEvent;
	
	import view.reader.variantFloatBox.VariantFloatBox;
	
	//namespace
	use namespace tlf_internal;

	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Reader extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var readerFlow				:TextFlow;
		protected var container					:Sprite;
		protected var containerController		:ContainerController;
		
		protected var border					:Shape;
		
		protected var w							:int = 375;
		protected var h							:int = 450;
			
		protected var marginW					:uint = 10;
		protected var marginH					:uint = 3;
		
		protected var variantFloatBox			:VariantFloatBox;	
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function Reader():void {
			
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function init(data:XML):void {
			
			// --- Textflow
			// To built one you have 2 options
			// 1. import the text to a textFlow. It can be Plain text, XML (or HTML), Text Layout schema
			// Here, I worked with xml. But it dosn't like tags that have just text and no childrens. I had to inject child tags into tags without notespan
			// 2. it is possible to create a loop and build one element (div, paragraph, span, link) at a time. I found that way more compicated and time consuming for this project.
			
			//defining the container for the text flow
			container = new Sprite();
			container.x = marginW;
			container.y = marginH;
			this.addChild(container);
			
			
			//get and convert text
			readerFlow = TextConverter.importToFlow(data,TextConverter.TEXT_LAYOUT_FORMAT);

			containerController = new ContainerController(container, w - (2*marginW), h - (2*marginH))			
				
			readerFlow.flowComposer.addController(containerController); // make it mini - change the width to 20
			readerFlow.hostFormat = TextReaderStyle.getStyle("body");
			readerFlow.flowComposer.updateAllControllers();
			
			// -------select and change the stlyle in tag throught the flow
			
			
			//lines
			//trace (getTextAsXML())
			
			
			//Styleze
			
			//1. General
			readerFlow.hostFormat = TextReaderStyle.getStyle("DefaultParagraph");
			
			//2. <div>
			//var div:FlowElement = readerFlow.getElementByID("playtext");
			//div.format = TextReaderStyle.getStyle("DefaultParagraph");
			
			//3. <p>
			var paragraphs:Array = readerFlow.getElementsByTypeName("p");
			
			for each (var p:FlowElement in paragraphs) {
				p.id = p.getStyle("line");
				
				p.format = TextReaderStyle.getStyle("paragraph");
				//p.tabStops = "s50 s120 e720";
			}
			
			//4. <g>
			
			var groups:Array = readerFlow.getElementsByTypeName("g");
			
			for each (var g:SubParagraphGroupElement in groups) {
				
				var gStylename:String = g.styleName;
				
				//change parent paragraph
				if (g.styleName == "Act Intro") {
					var pParent:ParagraphElement = g.getParagraph();
					pParent.format = TextReaderStyle.getStyle("Act Intro Paragraph");
					
				}
				
				//style
				g.format = TextReaderStyle.getStyle(g.styleName);
				g.styleName = gStylename;
				
			}
			
			//5. <span>
			var spans:Array = readerFlow.getElementsByTypeName("span");
			
			for each (var span:SpanElement in spans) {
				
				var spanStyleName:String = span.styleName;
				
				//styling lines
				switch (span.styleName) {
				
				case "LineNumber":
					
					//creating tab space
					span.text = "\t" + span.text + "\t";
					
					//style
					span.format = TextReaderStyle.getStyle("LineNumber");
					
					//recovering
					span.styleName = spanStyleName;
					
					break;
				
				}
				
				
				
			}
			
			//stylize line number
			showLineNumbers();
			
			//stylize variation
			showVariations();
			
				
			//!!!!!!!!!!!!!!!selectable
			readerFlow.interactionManager = new SelectionManager();
			//readerFlow.interactionManager = new EditManager();

			
			
			// !!!!!!!!!!!!!!! always remember to update controler after any change
			readerFlow.flowComposer.updateAllControllers();
				
			readerFlow.addEventListener(TextLayoutEvent.SCROLL, _onReaderScroll);
			
			//trace (getTextAsXML())
			
			
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set scrollPosition(value:int):void {
			containerController.verticalScrollPosition = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get scrollPosition():int {
			return containerController.verticalScrollPosition;
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _onReaderScroll(e:TextLayoutEvent):void {
			this.dispatchEvent(new Event(Event.SCROLL));
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param show
		 * @param split
		 * 
		 */
		public function showLineNumbers(show:Boolean = true, split:uint = 5):void {
			var spans:Array = readerFlow.getElementsByStyleName("LineNumber");
			
			for each (var span:SpanElement in spans) {
				
				var spanStyleName:String = span.styleName;
				
				if (show) { 
				
					//hide line number
					var linNum:int = new int(span.text);
					if (linNum % split != 0 && linNum != 1) {
						span.format = TextReaderStyle.getStyle("LineNumberHide");
					} else {
						span.format = TextReaderStyle.getStyle("LineNumberShow");
					}
					
				} else {
					
					span.format = TextReaderStyle.getStyle("LineNumberHide");
				}
				
				//recovering
				span.styleName = spanStyleName;
				
			}
			
			readerFlow.flowComposer.updateAllControllers();
		}
		
		/**
		 * 
		 * @param show
		 * 
		 */
		public function showVariations(show:Boolean = true):void {
			
			//stage.addEventListener(FlowElementMouseEvent.MOUSE_UP,mouseUp);
			
			var spans:Array = readerFlow.getElementsByStyleName("Variation");
			
			for each (var span:SpanElement in spans) {
				
				var spanStyleName:String = span.styleName;
				
				if (show) {
					span.format = TextReaderStyle.getStyle("Variation_Highlight");
					
					var mirror:IEventDispatcher = span.getEventMirror();
					mirror.addEventListener(FlowElementMouseEvent.MOUSE_DOWN,mouseDown);
					mirror.addEventListener(FlowElementMouseEvent.MOUSE_UP,mouseUp);
					
				} else {
					span.format = TextReaderStyle.getStyle("Variation");
				}
				
				//recovering
				span.styleName = spanStyleName;
			}
			
			readerFlow.flowComposer.updateAllControllers();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVarPositions():Array {
			
			var pos:Object;
			var varPos:Array = new Array();
			
			var spans:Array = readerFlow.getElementsByStyleName("Variation");
			
			for each (var span:SpanElement in spans) {
				pos = new Object();
				
				pos.start = span.getAbsoluteStart();
				pos.end = span.getAbsoluteStart() + span.getText().length;
				varPos.push(pos);
			}
			
			return varPos;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getFlowHeight():Number {
			return containerController.getContentBounds().height;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getPlainText():String {
			var outString:String = TextConverter.export(readerFlow,TextConverter.PLAIN_TEXT_FORMAT, ConversionType.STRING_TYPE) as String;
			return outString;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getTextAsXML():XML {
			var outXML:XML = TextConverter.export(readerFlow,TextConverter.TEXT_LAYOUT_FORMAT, ConversionType.XML_TYPE) as XML;
			return outXML;
		}
		
		public function mouseDown(e:FlowElementMouseEvent):void {
			var span:SpanElement = e.flowElement as SpanElement;
			span.format = TextReaderStyle.getStyle("Variation_Selected");
			readerFlow.flowComposer.updateAllControllers();
			
			containerController
			
			var mirror:IEventDispatcher = span.getEventMirror();
			mirror.addEventListener(FlowElementMouseEvent.MOUSE_MOVE,mouseMove);
			
			readerFlow.interactionManager = null;
			
			/*
			
			variantFloatBox = new VariantFloatBox();
			
			var variantFloatBoxPos:Point = new Point(e.originalEvent.localX, e.originalEvent.localX);
			var outerPoint:Point = this.parent.localToGlobal(variantFloatBoxPos)
			
			//variantFloatBox.x = outerPoint.x - this.parent.parent.x + (this.width/2);
			variantFloatBox.x = e.originalEvent.stageX;
			variantFloatBox.y = e.originalEvent.stageY;
			
			this.parent.parent.addChild(variantFloatBox);
			
			//info
			var str:String = span.text;
			
			variantFloatBox.initialize({title:str});
			
			*/
			//trace (e.toString());
			//trace (e.originalEvent.toString());
		}
		
		//****************** PUBLIC EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		public function mouseUp(e:FlowElementMouseEvent):void {
			
			var span:SpanElement = e.flowElement as SpanElement;
			span.format = TextReaderStyle.getStyle("Variation_Highlight");
			readerFlow.flowComposer.updateAllControllers();
			
			var mirror:IEventDispatcher = span.getEventMirror();
			mirror.removeEventListener(FlowElementMouseEvent.MOUSE_MOVE,mouseMove);
			
			readerFlow.interactionManager = new SelectionManager();
			
			/*
			if (variantFloatBox) {
				this.parent.parent.removeChild(variantFloatBox);
				variantFloatBox = null;
			}
			*/
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		public function mouseMove(e:FlowElementMouseEvent):void {
			trace (">>>>>>>>>>>>>>>>")
		}
		
	}
}