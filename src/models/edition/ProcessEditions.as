package models.edition {
	
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
	public class ProcessEditions extends EventDispatcher {
		
		//****************** Properties ****************** ****************** ******************
	
		public var data:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ProcessEditions() {
			
			//---------get list info.
			var url:URLRequest = new URLRequest("http://labs.fluxo.art.br/mtv/getWitnessesJSON.php");
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
			
			var editions:Object = JSON.parse(e.target.data);
				
			//init
			data = new Array();
			var edition:EditionModel;
			
			for each (var ed:Object in editions) {
				
				edition = new EditionModel(ed.id);
				edition.title = ed.title;
				edition.author = ed.author;
				edition.abbreviation = ed.abbreviation;
				edition.date = ed.date;
				
				data.push(edition);
				
			}
			
			edition = null;
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
}