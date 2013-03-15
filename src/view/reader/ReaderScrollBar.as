package view.reader {
	
	//imports
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import view.ReaderPanel;
	
	public class ReaderScrollBar extends Sprite {
		
		//properties
		private var scrollThumb:Sprite;
		
		private var _target:ReaderPanel;
		private var _track:MiniReaderViz;
		
		private var rate:Number;
		
		
		public function ReaderScrollBar() {
			
			super();
			
		}
		
		public function get target():ReaderPanel {
			return _target;
		}
		
		public function set target(value:ReaderPanel):void {
			_target = value;
		}
		
		public function get track():MiniReaderViz {
			return _track;
		}
		
		public function set track(value:MiniReaderViz):void {
			_track = value;
		}
		
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

		private function _startDrag(e:MouseEvent):void {
			
			var limit:Rectangle = new Rectangle(0,0,0,track.height-scrollThumb.height + 7);
			scrollThumb.startDrag(false,limit);
			
			scrollThumb.removeEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			
			scrollThumb.addEventListener(Event.ENTER_FRAME, _update);
			scrollThumb.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			scrollThumb.addEventListener(MouseEvent.MOUSE_OUT, _stopDrag);
		}
		
		private function _update(e:Event):void {
			target.getScrollReader(scrollThumb.y * rate);
		}
		
		private function _stopDrag(e:MouseEvent):void {
			scrollThumb.stopDrag();
			
			scrollThumb.addEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			
			scrollThumb.removeEventListener(Event.ENTER_FRAME, _update);
			scrollThumb.removeEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			scrollThumb.removeEventListener(MouseEvent.MOUSE_OUT, _stopDrag);
		}
		
		public function update(value:int):void {
			scrollThumb.y = value/rate;
		}

	}
}