package model {
	
	//imports
	import events.MtVEvent;
	import flash.events.Event;
	import mvc.Observable;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionsModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var editions				:Array;
		
		
		//****************** Constuctor ****************** ****************** ******************
		
		public function EditionsModel() {	
			super();
			this.name = "editions";
		}
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function processComplete(e:Event):void {
			editions = e.target.data;
			
			var obj:Object = {editions:editions}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,obj));	
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function hasEditions():Boolean {
			return editions ? true : false;
		}
		
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pE:ProcessEditions = new ProcessEditions();
			pE.addEventListener(Event.COMPLETE, processComplete);
			pE = null;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getEdtions():Array {
			return editions.concat();
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
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