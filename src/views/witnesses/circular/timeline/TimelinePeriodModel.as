package views.witnesses.circular.timeline {
	
	//imports
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class TimelinePeriodModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _title						:String;
		protected var _collection					:Array; 
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function TimelinePeriodModel() {
			_collection = new Array();
		}
		
		//****************** PUBLIC METHODS ****************** ****************** ******************

		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function addYear(value:int):uint {
			return collection.push(value);
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get title():String {
			return _title;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set title(value:String):void {
			_title = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get collection():Array {
			return _collection;
		}


	}
}