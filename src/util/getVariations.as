package util {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class getVariations {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var url					:URLRequest;
		protected var loader				:URLLoader;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function getVariations() {
			
			url = new URLRequest("http://labs.fluxo.art.br/mtv/witnessVariants.php?w=11");
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.load(url);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onComplete(e:Event):void {
			var xml:XML = XML(e.target.data);
			//trace (xml);
			//new EventDispatcher(New Event
		}
		
	}
}