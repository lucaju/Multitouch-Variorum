package util {
	
	//imports
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class LoadFile extends Sprite{
		
		//****************** Properties ****************** ****************** ******************
		
		public const IMAGE						:String = "image";
		public const DATA						:String = "data";
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function LoadFile() {
	
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * @return 
		 * 
		 */
		private function loadComplete(e:Event):* {
			return e.target.data;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param file
		 * 
		 */
		public function load(file:String):void {
			var urlRequest:URLRequest = new URLRequest(file);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
			urlLoader.load(urlRequest);
		}
		
	}
}