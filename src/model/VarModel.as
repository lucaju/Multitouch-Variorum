package model {
	
	public class VarModel {
		
		//properties
		private var _id:int;
		private var _line:int;
		private var _lineEnd:int;
		private var _xmlTarget:String;
		private var _source:String;
		private var _variant:String;
		private var _type:String;
		private var _editions:Array;
		
		
		public function VarModel(id_:int) {
			//------init
			_id = id_;
		}
		
		
		//---------GETTERS // SETTERS
		
		public function get id():int {
			return _id;
		}

		public function get line():int {
			return _line;
		}
		
		public function set line(value:int):void {
			_line = value;
		}

		public function get lineEnd():int {
			return _lineEnd;
		}
		
		public function set lineEnd(value:int):void {
			_lineEnd = value;
		}

		public function get xmlTarget():String {
			return _xmlTarget;
		}

		public function set xmlTarget(value:String):void {
			_xmlTarget = value;
		}

		public function get source():String {
			return _source;
		}
		
		public function set source(value:String):void {
			_source = value;
		}

		public function get variant():String {
			return _variant;
		}
		
		public function set variant(value:String):void {
			_variant = value;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function set type(value:String):void {
			_type = value;
		}

		public function get editions():Array {
			return _editions;
		}

		public function set editions(value:Array):void {
			_editions = value;
		}

		
	}
}