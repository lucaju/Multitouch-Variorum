package models.edition {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id						:int;
		protected var _title					:String;
		protected var _author					:String;
		protected var _abbreviation				:String;
		protected var _date						:Number;
		protected var _numVariations			:Number = - 1;
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function EditionModel(id_:int) {
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
		public function get date():Number {
			return _date;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set date(value:Number):void {
			_date = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get numVariations():Number {
			return _numVariations;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set numVariations(value:Number):void {
			_numVariations = value;
		}

	}
}