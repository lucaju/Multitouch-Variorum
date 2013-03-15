package model {
	
	public class EdModel {
		
		//properties
		private var _id:int;
		private var _title:String;
		private var _author:String;
		private var _abbreviation:String;
		private var _date:String;
		
		
		public function EdModel(id_:int) {
			//------init
			_id = id_;
		}
		
		
		//---------GETTERS // SETTERS
		
		public function get id():int {
			return _id;
		}
		
		public function get title():String {
			return _title;
		}
		
		public function set title(value:String):void {
			_title = value;
		}
		
		public function get author():String {
			return _author;
		}
		
		public function set author(value:String):void {
			_author = value;
		}
		
		public function get abbreviation():String {
			return _abbreviation;
		}
		
		public function set abbreviation(value:String):void {
			_abbreviation = value;
		}
		
		public function get date():String {
			return _date;
		}
		
		public function set date(value:String):void {
			_date = value;
		}
	}
}