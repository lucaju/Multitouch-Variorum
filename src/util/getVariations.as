package util {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	//imports
	
	public class getVariations {
		
		//private
		private var url:URLRequest;
		private var loader:URLLoader;
		
		public function getVariations() {
			
			url = new URLRequest("http://labs.fluxo.art.br/mtv/witnessVariants.php?w=11");
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.load(url);
			
		}
		
		private function onComplete(e:Event):void {
			var xml:XML = XML(e.target.data);
			//trace (xml);
			
		//	new EventDispatcher(New Event
			
		}
		
	}
}