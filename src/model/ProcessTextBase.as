package model {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	//import flashx.textLayout.elements.TextFlow;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ProcessTextBase extends EventDispatcher {
		
		//****************** Properties ****************** ****************** ******************
		
		public var data					:XML;
		public var editionID			:int;
		
		//protected var textFlow			:TextFlow;
		//protected var _plainTex			:String;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param _editionID
		 * 
		 */
		public function ProcessTextBase(_editionID:int = 0) {
			
			editionID = _editionID;
			
			//---------get textbase
			var url:URLRequest = new URLRequest();
			//url = new URLRequest("http://labs.fluxo.art.br/mtv/getPlayTextXML.php");
			url = new URLRequest("http://labs.fluxo.art.br/mtv/getPlayTextWithVariationsXML.php?e="+editionID);
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
			
			XML.ignoreWhitespace = false;
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onComplete(e:Event):void {
			data = XML(e.target.data);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

	}
}