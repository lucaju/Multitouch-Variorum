package model {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ProcessVariations extends EventDispatcher {
		
		//****************** Properties ****************** ****************** ******************
		
		public var data					:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ProcessVariations() {
			
			//---------get list info.
			var url:URLRequest = new URLRequest("http://labs.fluxo.art.br/mtv/witnessVariantsJSON.php");
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onComplete(e:Event):void {
			var variations:Object = JSON.parse(e.target.data);
				
			//init
			data = new Array();
			var variation:VarModel;
			
			for each (var VAR:Object in variations) {
				
				variation = new VarModel(VAR.id);
				variation.line = VAR.line;
				variation.lineEnd = VAR.line_end;
				variation.xmlTarget = VAR.xml_target;
				variation.source = VAR.source;
				variation.variant = VAR.variant;
				variation.type = VAR.type;
				variation.editions = VAR.editions;
				
				data.push(variation);
				
			}
			
			variation = null;
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
}