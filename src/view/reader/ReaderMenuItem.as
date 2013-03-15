package view.reader {
	
	//imports
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class ReaderMenuItem extends Sprite {
		
		//properties
		private var _type:String;
		private var _size:int;
		private var icon:Sprite;
		private var _toggle:Boolean;
		
		public function ReaderMenuItem(type_:String, toggle_:Boolean = false, size_:int = 16) {
			super();
			
			this.buttonMode = true;
			
			_type = type_
			size = size_;
			
			var file:String = "images/" + type_ + "_icon_" + size + ".png";
			
			icon = new Sprite();
			this.addChild(icon);
			
			var url:URLRequest = new URLRequest(file);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _complete);
			loader.load(url);
			
			toggle = toggle_;
		}
		
		private function _complete(e:Event):void {
			icon.addChild(e.currentTarget.content);
		}

		public function get size():int {
			return _size;
		}

		public function set size(value:int):void {
			_size = value;
		}

		public function get toggle():Boolean {
			return _toggle;
		}

		public function set toggle(value:Boolean):void {
			_toggle = value;
			
			if (toggle) {
				icon.alpha = .8;
			} else {
				icon.alpha = .4;
			}
		}

		public function get type():String {
			return _type;
		}


	}
}