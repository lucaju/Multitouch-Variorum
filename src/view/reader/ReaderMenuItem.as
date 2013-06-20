package view.reader {
	
	//imports
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderMenuItem extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _type			:String;
		protected var _size			:int;
		protected var icon			:Sprite;
		protected var _toggle		:Boolean;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param type_
		 * @param toggle_
		 * @param size_
		 * 
		 */
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
		
		
		//****************** PROTECTD EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _complete(e:Event):void {
			icon.addChild(e.currentTarget.content);
		}

		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get size():int {
			return _size;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set size(value:int):void {
			_size = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get toggle():Boolean {
			return _toggle;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set toggle(value:Boolean):void {
			_toggle = value;
			
			if (toggle) {
				icon.alpha = .8;
			} else {
				icon.alpha = .4;
			}
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get type():String {
			return _type;
		}


	}
}