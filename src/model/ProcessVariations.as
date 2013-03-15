package model {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ProcessVariations extends EventDispatcher {
		
		//properties
		private var url:URLRequest;
		private var urlLoader:URLLoader;
		
		public var data:Array;
		
		public function ProcessVariations() {
			
			//---------get list info.
			url = new URLRequest("http://labs.fluxo.art.br/mtv/witnessVariantsJSON.php");
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
			
		}
		
		private function onComplete(e:Event):void {
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
			
			url = null;
			urlLoader = null;
			variation = null;
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
}