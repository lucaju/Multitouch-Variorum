package model {
	
	//imports
	import events.MtVEvent;
	
	import flash.events.Event;
	
	import mvc.Observable;
	
	public class EditionsModel extends Observable {
		
		//properties
		private var editions:Array;
		
		public function EditionsModel() {
			
			super();
			
			this.name = "editions";
		}
		
		public function hasEditions():Boolean {
			return editions ? true : false;
		}
		
		public function load():void {
			var pE:ProcessEditions = new ProcessEditions();
			pE.addEventListener(Event.COMPLETE, processComplete);
			pE = null;
		}
		
		private function processComplete(e:Event):void {
			editions = e.target.data;
			
			var obj:Object = {editions:editions}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,obj));
		
		}
		
		public function getEdtions():Array {
			return editions.concat();
		}
		
		public function getEdtion(value:int):EdModel {
			
			var ed:EdModel;
			
			for each (var edition:EdModel in editions) {
				if (edition.id == value) {
					ed = edition;
					break;
				}
			}
			return ed;
		}
		
	}
}