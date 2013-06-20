package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	
	import model.BaseTextModel;
	
	import mvc.IController;
	
	import view.reader.MiniReaderViz;
	import view.reader.Reader;
	import view.reader.ReaderMenu;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderPanel extends AbstractPanel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var w						:int = 275;
		protected var h						:int = 538;
		protected var _editionID			:int;
		
		protected var infoBox				:InfoBox
		protected var menu					:ReaderMenu;
		protected var reader				:Reader;
		protected var miniReaderViz			:MiniReaderViz;						//Navvigation Panel
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * @param editionID_
		 * 
		 */
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
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get editionID():int {
			return _editionID;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set editionID(value:int):void {
			_editionID = value;
		}
		
		/**
		 * 
		 * @param valueW
		 * @param valueH
		 * 
		 */
		override public function setDimensions(valueW:Number, valueH:Number):void {
			w = valueW;
			h = valueH;
		}
		
		
		//****************** PRIVATE METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param obj
		 * 
		 */
		private function killChild(obj:DisplayObject):void {
			this.removeChild(obj);
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		protected function addEditionInfo():void {
			infoBox = new InfoBox(this.getController(), true, editionID);
			this.addChild(infoBox);
		}
		
		protected function addMenu():void {
			menu = new ReaderMenu(this);
			//menu.scaleX = menu.scaleY = .8;
			this.addChildAt(menu,0);
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
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
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function readerScrolling(e:Event):void {
			miniReaderViz.updateScrollPosition(reader.scrollPosition)	
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _rotate(e:TransformGestureEvent):void {
			this.rotation += e.rotation;
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _startDrag(e:MouseEvent):void {
			this.startDrag();
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _stopDrag(e:MouseEvent):void {
			this.stopDrag();
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _rollOver(e:MouseEvent):void {
			TweenMax.to(menu, .5, {autoAlpha:1, y:0});
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _rollOut(e:MouseEvent):void {
			TweenMax.to(menu, .5, {autoAlpha:0, y:menu.height + 10});
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function getScrollReader(value:Number):void {
			reader.scrollPosition = Math.round(value);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getReaderHeight():Number {
			return reader.getFlowHeight();;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
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
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function showVariants(value:Boolean):void {
			reader.showVariations(value);	
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function showLineNumber(value:Boolean):void {
			reader.showLineNumbers(value);	
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getPlainTextLength():int {
			return reader.getPlainText().length;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getNotes():Array {
			return reader.getVarPositions();
		}
		
	}
}