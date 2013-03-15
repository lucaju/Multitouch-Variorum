package model {
	
	public class CommentModel {
		
		//properties
		private var _id:int;
		private var _lineStart:int;
		private var _lineEnd:int;
		private var _source:String;
		private var _author:String;
		private var _citation:String;
		private var _referenceStart:int;
		private var _referenceEnd:int;
		private var _text:String;
		
		
		public function CommentModel(id_:int) {
			//------init
			_id = id_;
		}
		
		
		//---------GETTERS // SETTERS
		
		public function get id():int {
			return _id;
		}

		public function get lineStart():int {
			return _lineStart;
		}
		
		public function set lineStart(value:int):void {
			_lineStart = value;
		}

		public function get lineEnd():int {
			return _lineEnd;
		}
		
		public function set lineEnd(value:int):void {
			_lineEnd = value;
		}
		
		public function get source():String {
			return _source;
		}
		
		public function set source(value:String):void {
			_source = value;
		}

		public function get author():String {
			return _author;
		}

		public function set author(value:String):void {
			_author = value;
		}

		public function get citation():String {
			return _citation;
		}
		
		public function set citation(value:String):void {
			_citation = value;
		}

		public function get referenceStart():int {
			return _referenceStart;
		}

		public function set referenceStart(value:int):void {
			_referenceStart = value;
		}

		public function get referenceEnd():int {
			return _referenceEnd;
		}

		public function set referenceEnd(value:int):void {
			_referenceEnd = value;
		}

		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			_text = value;
		}
		
		
	}
}