package model {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ProcessEditions extends EventDispatcher {
		
		//properties
		private var url:URLRequest;
		private var urlLoader:URLLoader;
		
		public var data:Array;
		
		public function ProcessEditions() {
			
			//---------get list info.
			url = new URLRequest("http://labs.fluxo.art.br/mtv/getWitnessesJSON.php");
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
			
		}
		
		private function onComplete(e:Event):void {
			
			
			var editions:Object = JSON.parse(e.target.data);
				
			//init
			data = new Array();
			var edition:EdModel;
			
			
			for each (var ed:Object in editions) {
				
				edition = new EdModel(ed.id);
				edition.title = ed.title;
				edition.author = ed.author;
				edition.abbreviation = ed.abbreviation;
				edition.date = ed.date;
				
				data.push(edition);
				
			}
			
			url = null;
			urlLoader = null;
			edition = null;
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
}