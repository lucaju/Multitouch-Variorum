package models.edition {
	
	//imports
	import flash.events.Event;
	
	import events.MtVEvent;
	
	import mvc.Observable;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionsModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var collection				:Array;
		
		
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
			collection = e.target.data;
			
			var obj:Object = {editions:collection}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE, null, obj));	
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		
		//****************** PROCCESS ****************** 
		
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pE:ProcessEditions = new ProcessEditions();
			pE.addEventListener(Event.COMPLETE, processComplete);
			pE = null;
		}
		
		//****************** GENERAL INFORMATION ****************** 
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get hasEditions():Boolean {
			return collection ? true : false;
		}
			
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getEdtions():Array {
			return collection.concat();
		}
		
		
		//****************** SPECIFIC INFORMATION ****************** 
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getEdtion(value:int):EditionModel {
			for each (var edition:EditionModel in collection) {
				if (edition.id == value) return edition;
			}
			return null;;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getAbbreviationFromEditionID(value:int):String {
			var edition:EditionModel = getEdtion(value);
			return edition.abbreviation;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getAuthorFromEditionID(value:int):String {
			var edition:EditionModel = getEdtion(value);
			return edition.author;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getTitleFromEditionID(value:int):String {
			var edition:EditionModel = getEdtion(value);
			return edition.title;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getYearFromEditionID(value:int):Number {
			var edition:EditionModel = getEdtion(value);
			return edition.date;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getNumVariationsFromEditionID(value:int):Number {
			var edition:EditionModel = getEdtion(value);
			return edition.numVariations;
		}
		
	}
}