package util {
	
	//imports
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class LoadFile extends Sprite{
		
		public const IMAGE:String = "image";
		public const DATA:String = "data";
		
		//properties
		private var urlRequest:URLRequest;
		private var urlLoader:URLLoader;
		
		
		public function LoadFile() {
	
		}
		
		public function load(file:String):void {
			
			urlRequest = new URLRequest(file);
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
			urlLoader.load(urlRequest);
		}
		
		private function loadComplete(e:Event):* {
			return e.target.data;
		}
	}
}