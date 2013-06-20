package model {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EdModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id						:int;
		protected var _title					:String;
		protected var _author					:String;
		protected var _abbreviation				:String;
		protected var _date						:String;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function EdModel(id_:int) {
			//------init
			_id = id_;
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get id():int {
			return _id;
		}
		
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
		public function get author():String {
			return _author;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set author(value:String):void {
			_author = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get abbreviation():String {
			return _abbreviation;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set abbreviation(value:String):void {
			_abbreviation = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get date():String {
			return _date;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set date(value:String):void {
			_date = value;
		}
	}
}