package views.readerWindow.panels.variationPanel {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import models.reader.ReadersModel;
	import models.variable.VariationModel;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	import views.readerWindow.panels.PanelEvent;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Variable extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _target						:Variables;
		
		protected var _maxWidth						:Number = 233;
		protected var _usableWidth					:Number = 200;
		
		protected var _id							:int;
		
		protected var sourceTF						:TLFTextField;
		
		protected var _variationColletion			:Array;
		protected var variationContainer			:Sprite;
		
		protected var sepLine						:Sprite;
		protected var currentVariationSelected		:Variation;
		
		
		//****************** Contructor ****************** ****************** ******************		
		
		/**
		 * 
		 * @param c
		 * @param id_
		 * 
		 */
		public function Variable(c:IController, id_:int) {
			super(c);
			_id = id_;
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init(sourceText:String = "", lineNumber:int = 0):void {
			
			//0. initials
			
			if (target) {
				usableWidth = maxWidth - target.columnWidth;
			}
			
			//1. styles
			
			//1.1 line Number
			var labelLineStyle:TextLayoutFormat = new TextLayoutFormat();
			labelLineStyle.color = 0x666666;
			labelLineStyle.fontFamily = "Constantia, Helvetica, Arial, _sans";
			labelLineStyle.fontSize = 14;
			labelLineStyle.textAlign = "center";
			labelLineStyle.lineHeight = 12;
			
			var lineStyle:TextLayoutFormat = new TextLayoutFormat();
			lineStyle.copy(labelLineStyle);
			lineStyle.fontSize = 16;
			
			//1.2 Source
			var sourceStyle:TextLayoutFormat = new TextLayoutFormat();
			sourceStyle.color = 0x333333;
			sourceStyle.fontFamily = "Constantia, Helvetica, Arial, _sans";
			sourceStyle.fontSize = 18;
			
			//2. Line number
			var lineNumberTF:TLFTextField = new TLFTextField();
			lineNumberTF.selectable = false;
			lineNumberTF.wordWrap = true;
			lineNumberTF.multiline = true;
			
			lineNumberTF.y = -target.columnWidth/3;
			lineNumberTF.width = target ? target.columnWidth :30;
			lineNumberTF.height = 50;
			
			var paragraph:ParagraphElement = new ParagraphElement();
			paragraph.format = labelLineStyle;
			
			var labelLineNumberSpan:SpanElement = new SpanElement;
			labelLineNumberSpan.text = "line\n";
			
			var lineNumberSpan:SpanElement = new SpanElement;
			lineNumberSpan.text = lineNumber.toString();
			lineNumberSpan.format = lineStyle;
			
			paragraph.addChild(labelLineNumberSpan);
			paragraph.addChild(lineNumberSpan);
			
			var lineNumberTFlow:TextFlow = lineNumberTF.textFlow;
			lineNumberTFlow.hostFormat = labelLineStyle;
			lineNumberTFlow.addChild(paragraph);
			lineNumberTFlow.flowComposer.updateAllControllers();
			
			this.addChild(lineNumberTF);
			
			
			//3. Source
			sourceTF = new TLFTextField();
			sourceTF.autoSize = "left";
			sourceTF.selectable = false;
			sourceTF.wordWrap = true;
			sourceTF.multiline = true;
			
			var padding:int = 10;
			
			sourceTF.x = target ? target.columnWidth + padding : 40;
			sourceTF.y = padding;
			
			sourceTF.width = usableWidth - (2 * padding);
			
			if (sourceText == "") sourceText = " ";
			sourceTF.htmlText = sourceText;
			
			var sourceTFlow:TextFlow = sourceTF.textFlow;
			sourceTFlow.hostFormat = sourceStyle;
			sourceTFlow.flowComposer.updateAllControllers();

			this.addChild(sourceTF);
			
			
			//4. separete Line
			sepLine = new Sprite();
			sepLine.graphics.lineStyle(1,0x999999,.3);
			sepLine.graphics.beginFill(0xFFFFFF,0);
			sepLine.graphics.lineTo(maxWidth,0);
			sepLine.graphics.endFill();
			
			this.addChildAt(sepLine,0);
			
			lineNumberTF.addEventListener(MouseEvent.CLICK, scrollText);
			sourceTF.addEventListener(MouseEvent.CLICK, scrollText);
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		public function loadVariations(data:Array):void {

			
			_variationColletion = new Array();
			
			variationContainer = new Sprite();
			variationContainer.x = 30;
			variationContainer.y = sourceTF.y + sourceTF.height + 5;
			this.addChild(variationContainer);
			
			//loop
			var variation:Variation;
			var posY:Number = 0;
			
			for each (var variationModel:VariationModel in data) {
		
				variation = new Variation(this, variationModel.id, variationModel.uid);
				
				variation.y = posY;
				variationContainer.addChild(variation);
				
				variation.init(variationModel.variant,variationModel.type,variationModel.editions.length);
				
				_variationColletion.push(variation);
				
				posY += variation.height + 5;
				
			}
			
			
			//check log
			this.checkVariationSelection();
			
			variationContainer.addEventListener(PanelEvent.CELL_EXPANDED, expandSize);
			variationContainer.addEventListener(MouseEvent.CLICK, selectVariation);
			
		}
		
		/**
		 * 
		 * 
		 */
		public function resetVariations():void {
			_variationColletion = null;
			this.removeChild(variationContainer);
		}
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function expandSize(event:PanelEvent):void {
			
			//1. Stop propagation
			event.stopImmediatePropagation();
			
			//2. save variables
			var variationID:int = event.targetID;
			var variation:Variation = getVariationByID(variationID);
			
			//3. Get variation expanded area
			if (event.phase == "expanding") {
				var mtvController:MtVController = MtVController(this.getController())
				var variationEditions:Array = variation.edition;
				var auhtorsArray:Array = new Array();
				var author:String;
				
				for each (var ed:int in variationEditions) {
					author = mtvController.getAuthorFromEditionID(ed);
					author += " (" + mtvController.getYearFromEditionID(ed) + ")";
					auhtorsArray.push(author);
					author = "";
				}
				
				//send
				variation.setAuthors(auhtorsArray);
				
				//clean
				author = null;
				auhtorsArray = null; 
				variationEditions = null;
				mtvController = null;
			}
			
			//4. Animation
			var i:int = variationID;
			var posY:Number = variation.y;
			
			//new height
			var prevY:Array = new Array();
			for (i; i < variationColletion.length; i++) {
				prevY[i] = variationColletion[i].y
				variationColletion[i].y = posY;
				posY += variationColletion[i].height + 5;
			}
			
			//dispatch event
			this.dispatchEvent(new PanelEvent(PanelEvent.CELL_EXPANDED,event.phase, this.id));
			
			//animation
			i = event.targetID;
			for (i; i < variationColletion.length; i++) {
				TweenMax.from(variationColletion[i],.5,{y:prevY[i]});
			}
		
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function selectVariation(event:MouseEvent):void {
			
			if (event.target is Variation) {
						
				//set vars
				var variationUID:int;
				var variationText:String;
				var target:Variation = Variation(event.target);
				
				// deselect variations
				if (currentVariationSelected) currentVariationSelected.select(false);
				
				
				if (currentVariationSelected != target) {		//if it is a different variation
					target.select(true);
					currentVariationSelected = target;
					
					variationUID = target.uid;
					variationText = target.variant;
					if (target.type == "insert") variationText = variationText + " ";
					if (target.type == "remove")  variationText = "_";							//XML doesn't like empty tags
					
				} else {										//else put the source back
					currentVariationSelected = null;
					variationUID = 0;
					variationText = sourceTF.text;
				}
				
				
				//information to send
				var params:Object = {variationUID: variationUID, variationText:variationText};
				this.dispatchEvent(new PanelEvent(PanelEvent.CELL_SELECTED, "changeVariable", this.id, params));	
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function scrollText(event:MouseEvent):void {
			var params:Object = {eventSource:"variable"};
			this.dispatchEvent(new PanelEvent(PanelEvent.CELL_SELECTED, "scrollReader", this.id, params));
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function variationChecked(event:MtVEvent):void {
			
			var readerID:int = event.parameters.readerID;
			
			if (readerID == target.readerID) {
			
				var variableID:int = event.parameters.variableID;

				if (variableID == this.id) {
					
					event.target.removeEventListener(MtVEvent.UPDATE, variationChecked);
					event.stopImmediatePropagation();
					
					var variationUID:int = event.parameters.variationUID;
					var checked:Boolean = event.parameters.checked;
					
					if (checked) {

						var variation:Variation = this.getVariationByUID(variationUID);
						if (!variation.selected) variation.select(true);
						if (currentVariationSelected != variation) currentVariationSelected = variation;

					}
					
				}
				
			}
			
			
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param variant
		 * 
		 */
		protected function checkVariationSelection():void {
			
			var m:ReadersModel = ReadersModel(MtVController(this.getController()).getModel("readers"));
			m.addEventListener(MtVEvent.UPDATE, variationChecked);
			
			MtVController(this.getController()).checkReaderVariationSelection(target.readerID, this.id);
			
			m = null;
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get id():int {
			return _id;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get target():Variables {
			return _target;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set target(value:Variables):void {
			_target = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxWidth():Number {
			return _maxWidth;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxWidth(value:Number):void {
			_maxWidth = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get usableWidth():Number {
			return _usableWidth;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set usableWidth(value:Number):void {
			_usableWidth = value;
		}
		
		//****************** VARIABLE ******************
	
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get line():int {
			return MtVController(this.getController()).getVariableInfo(id, "line");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get source():String {
			return MtVController(this.getController()).getVariableInfo(id, "source");
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get variationColletion():Array {
			return _variationColletion;
		}
		
		//****************** VARIATION ******************

		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariationByID(value:int):Variation {
			if (variationColletion) {
				for each (var variation:Variation in variationColletion) {
					if (variation.id == value) return variation
				}
			}
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariationByUID(value:int):Variation {
			if (variationColletion) {
				for each (var variation:Variation in variationColletion) {
					if (variation.uid == value){
						return variation;
					}
				}
			}
			return null;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVariationText(value:int):String {
			return MtVController(this.getController()).getVariationInfo(this.id, value, "variant");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVariationType(value:int):String {
			return MtVController(this.getController()).getVariationInfo(this.id, value, "type");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVariationEditions(value:int):Array {
			return MtVController(this.getController()).getVariationInfo(this.id, value, "editions");
		}

		
	}
}