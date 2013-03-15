package model {
	
	//imports
	import events.MtVEvent;
	
	import flash.events.Event;
	
	import mvc.Observable;
	
	public class BaseTextModel extends Observable {
		
		//properties
		private var baseTextXML:XML;
		private var editionsCollection:Array;
		
		public function BaseTextModel() {
			
			super();
			
			this.name = "baseText";
		}
		
		public function hasTextBase():Boolean {
			return baseTextXML ? true : false;
		}
		
		public function load():void {
			var pTB:ProcessTextBase = new ProcessTextBase();
			pTB.addEventListener(Event.COMPLETE, _processComplete);
			pTB = null;
		}
		
		public function loadEdition(value:int):void {
			var pTB:ProcessTextBase = new ProcessTextBase(value);
			pTB.addEventListener(Event.COMPLETE, _editionProcessComplete);
			pTB = null;
		}
		
		private function _editionProcessComplete(e:Event):void {
			
			if (!editionsCollection) {
				editionsCollection = new Array();
			}
			
			var data:Object = new Object();
			data.text = e.target.data;
			data.editionID = e.target.editionID;
			
			editionsCollection.push(data);
			
			
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,data));
		}
		
		private function _processComplete(e:Event):void {
			
			baseTextXML = e.target.data;
			
			var data:Object = new Object();
			data.text = e.target.data;
			data.editionID = e.target.editionID;
			
			
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,data));
		}
		
	}
}