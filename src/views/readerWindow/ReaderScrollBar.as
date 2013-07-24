package views.readerWindow {
	
	//imports
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderScrollBar extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var scrollThumb			:Sprite;
		
		protected var _target				:ReaderWindow;
		protected var _track				:ReaderViz;
		
		protected var rate					:Number;
		
		
		//****************** Properties ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ReaderScrollBar() {
			super();
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function initialize():void {
			
			//get reader and track height
			var h:Number = target.getReaderHeight();
			var hMax:Number = track.height;
			
			//make proportion
			rate = h/hMax;
			
			//draw scrollThumb
			scrollThumb = new Sprite();
			scrollThumb.graphics.beginFill(0xFFFFFF,.5);
			scrollThumb.graphics.drawRoundRect(0,0,track.width,track.height/rate,6);
			scrollThumb.graphics.endFill();
			
			scrollThumb.blendMode = "overlay";
			
			this.addChild(scrollThumb);
			
			scrollThumb.addEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			
			//recalculate rate
			rate = h/(hMax+scrollThumb.height);
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get target():ReaderWindow {
			return _target;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set target(value:ReaderWindow):void {
			_target = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get track():ReaderViz {
			return _track;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set track(value:ReaderViz):void {
			_track = value;
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************

		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _startDrag(e:MouseEvent):void {
			
			var limit:Rectangle = new Rectangle(0,0,0,track.height-scrollThumb.height + 7);
			scrollThumb.startDrag(false,limit);
			
			scrollThumb.removeEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			
			scrollThumb.addEventListener(Event.ENTER_FRAME, _update);
			scrollThumb.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			scrollThumb.addEventListener(MouseEvent.MOUSE_OUT, _stopDrag);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _update(e:Event):void {
			target.setScrollReader(scrollThumb.y * rate);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _stopDrag(e:MouseEvent):void {
			scrollThumb.stopDrag();
			
			scrollThumb.addEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			
			scrollThumb.removeEventListener(Event.ENTER_FRAME, _update);
			scrollThumb.removeEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			scrollThumb.removeEventListener(MouseEvent.MOUSE_OUT, _stopDrag);
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		public function update(value:int):void {
			scrollThumb.y = value/rate;
		}

	}
}