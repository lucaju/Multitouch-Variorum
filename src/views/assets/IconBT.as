package views.assets {
	
	//imports
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class IconBT extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _icon				:Sprite;
		protected var _w				:Number = 20;
		protected var _h				:Number = 20;
		
		//****************** Properties ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function IconBT() {

		}
		
		
		//****************** Initialize ****************** ****************** ******************
		
		public function init(iconFile:String):void {
			
			
			//1. Background
			var background:Sprite = new Sprite();
			background.graphics.beginFill(0x000000,0);
			background.graphics.drawRect(0,0,w,h);
			background.graphics.endFill();
			
			this.addChild(background);
			
			//2. Icon
			
			icon = new Sprite();
			
			var url:URLRequest = new URLRequest(iconFile);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoaderComplete);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadProgress);
			loader.load(url);
			
			icon.addChild(loader);
			
			this.addChild(icon);
			
			url = null;
			loader = null;
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param ProgressEvent
		 * 
		 */
		protected function onLoadProgress(event:Event):void {
		}	
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function iconLoaderComplete(event:Event):void {
			
			//centralize
			event.target.content.x = (this.width/2) - (event.target.content.width/2);
			event.target.content.y = (this.height/2) - (event.target.content.height/2);

		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		public function get icon():Sprite {
			return _icon;
		}
		
		public function set icon(value:Sprite):void {
			_icon = value;
		}
		
		public function get h():Number {
			return _h;
		}

		public function set h(value:Number):void {
			_h = value;
		}

		public function get w():Number {
			return _w;
		}

		public function set w(value:Number):void {
			_w = value;
		}


	}
}