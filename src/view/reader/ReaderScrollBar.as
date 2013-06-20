package view.reader {
	
	//imports
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import view.ReaderPanel;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderScrollBar extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var scrollThumb			:Sprite;
		
		protected var _target				:ReaderPanel;
		protected var _track				:MiniReaderViz;
		
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
			scrollThumb.graphics.beginFill(0x000000,.4);
			scrollThumb.graphics.drawRoundRect(0,0,track.width,track.height/rate,10);
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
		public function get target():ReaderPanel {
			return _target;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set target(value:ReaderPanel):void {
			_target = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get track():MiniReaderViz {
			return _track;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set track(value:MiniReaderViz):void {
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
			target.getScrollReader(scrollThumb.y * rate);
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