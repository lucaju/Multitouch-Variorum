package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	
	import model.BaseTextModel;
	
	import mvc.IController;
	
	import view.reader.MiniReaderViz;
	import view.reader.Reader;
	import view.reader.ReaderMenu;
	
	public class ReaderPanel extends AbstractPanel {
		
		//properties
		private var w:int = 275;
		private var h:int = 538;
		private var _editionID:int;
		
		private var infoBox:InfoBox
		private var menu:ReaderMenu;
		private var reader:Reader;
		private var miniReaderViz:MiniReaderViz;												//Navvigation Panel
		
		
		public function ReaderPanel(c:IController, editionID_:int = 0) {
			super(c);
			
			//super.init("Reader")
	
			editionID = editionID_;		
			this.name = "Reader " + editionID_;
				
			//get model through controlles
			var m:BaseTextModel = BaseTextModel(MtVController(this.getController()).getModel("baseText"));
			
			//--------- Load base text or edition text
			if (editionID == 0) {
				MtVController(this.getController()).loadBaseText();
			} else {
				MtVController(this.getController()).loadEditionText(editionID);
			}
				
			super.addPreloader();
			
			//add listeners
			m.addEventListener(MtVEvent.COMPLETE, _complete);	
			m = null;
			
			this.addEventListener(TransformGestureEvent.GESTURE_ROTATE, _rotate);
			this.addEventListener(MouseEvent.ROLL_OVER, _rollOver)
			this.addEventListener(MouseEvent.ROLL_OUT, _rollOut)
			
		}
		
		public function get editionID():int {
			return _editionID;
		}
		
		public function set editionID(value:int):void {
			_editionID = value;
		}
		
		override protected function _complete(e:MtVEvent):void {
			
			
			
			if (e.parameters.editionID == editionID) {
				//remove preloader
				super.removePreloader();	
				
				
				//get data
				var baseTextXML:XML = e.parameters.text;
				
				//add reader
				reader = new Reader();
				this.addChild(reader);
				reader.init(baseTextXML);
				reader.addEventListener(Event.SCROLL, readerScrolling);
				

				//add things
				this.showWindow();
				addEditionInfo();
				addMenu();
				
				//position
				super.window.y = infoBox.height + 2;
				reader.y = infoBox.height + 2;
				menu.x = this.width - menu.width - 4;
				
				
				//dispatch event
				this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE));
				
				showNav(true);
				
				infoBox.buttonMode = true;
				infoBox.addEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
				infoBox.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			}
			
			
		}
		
		private function _startDrag(e:MouseEvent):void {
			this.startDrag();
		}
		
		private function _stopDrag(e:MouseEvent):void {
			this.stopDrag();
		}
		
		private function readerScrolling(e:Event):void {
			miniReaderViz.updateScrollPosition(reader.scrollPosition)	
		}
		
		public function getScrollReader(value:Number):void {
			reader.scrollPosition = Math.round(value);
		}
		
		public function getReaderHeight():Number {
			return reader.getFlowHeight();;
		}
		
		private function addEditionInfo():void {
			infoBox = new InfoBox(this.getController(), true, editionID);
			this.addChild(infoBox);
		}
		
		private function addMenu():void {
			menu = new ReaderMenu(this);
			//menu.scaleX = menu.scaleY = .8;
			this.addChildAt(menu,0);
		}
		
		public function showNav(value:Boolean):void {
			
			if (value) {
				miniReaderViz = new MiniReaderViz(this);
				miniReaderViz.hMax = this.height;
				
				this.addChildAt(miniReaderViz,0);
				
				miniReaderViz.initialize();
				miniReaderViz.x = this.width - 8;
				miniReaderViz.y = reader.y + 2;
				TweenMax.from(miniReaderViz,1,{x:miniReaderViz.x - miniReaderViz.width - 10});
				
			} else {
				TweenMax.to(miniReaderViz,1,{x:miniReaderViz.x - miniReaderViz.width - 10, onComplete:removeChild, onCompleteParams:[miniReaderViz]});
			}
	
		}
		
		private function killChild(obj:DisplayObject):void {
			this.removeChild(obj);
		}
		
		public function showVariants(value:Boolean):void {
			reader.showVariations(value);	
		}
		
		public function showLineNumber(value:Boolean):void {
			reader.showLineNumbers(value);	
		}
		
		override public function setDimensions(valueW:Number, valueH:Number):void {
			w = valueW;
			h = valueH;
		}
		
		public function getPlainTextLength():int {
			return reader.getPlainText().length;
		}
		
		public function getNotes():Array {
			return reader.getVarPositions();
		}
		
		private function _rotate(e:TransformGestureEvent):void {
			this.rotation += e.rotation;
		}
		
		private function _rollOver(e:MouseEvent):void {
			TweenMax.to(menu, .5, {autoAlpha:1, y:0});
		}
		
		private function _rollOut(e:MouseEvent):void {
			TweenMax.to(menu, .5, {autoAlpha:0, y:menu.height + 10});
		}
	}
}