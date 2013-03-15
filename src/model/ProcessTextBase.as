package model {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flashx.textLayout.elements.TextFlow;
	
	public class ProcessTextBase extends EventDispatcher {
		
		private var url:URLRequest;
		private var urlLoader:URLLoader;
		
		public var data:XML;
		public var editionID:int;
		private var textFlow:TextFlow;
		private var _plainTex:String;
		
		//constructor
		public function ProcessTextBase(_editionID:int = 0) {
			
			editionID = _editionID;
			
			//---------get textbase
			//url = new URLRequest("http://labs.fluxo.art.br/mtv/getPlayTextXML.php");
			url = new URLRequest("http://labs.fluxo.art.br/mtv/getPlayTextWithVariationsXML.php?e="+editionID);
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
			
			
			XML.ignoreWhitespace = false;
			
		}
		
		private function onComplete(e:Event):void {
			
			//complete
			data = XML(e.target.data);
			this.dispatchEvent(new Event(Event.COMPLETE));
			
			//trace (data)

		}

	}
}