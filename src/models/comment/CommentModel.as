package models.comment {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class CommentModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id							:int;
		protected var _lineStart					:int;
		protected var _lineEnd						:int;
		protected var _source						:String;
		protected var _author						:String;
		protected var _citation						:String;
		protected var _referenceStart				:int;
		protected var _referenceEnd					:int;
		protected var _text							:String;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function CommentModel(id_:int) {
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
		public function get lineStart():int {
			return _lineStart;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set lineStart(value:int):void {
			_lineStart = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get lineEnd():int {
			return _lineEnd;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set lineEnd(value:int):void {
			_lineEnd = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get source():String {
			return _source;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set source(value:String):void {
			_source = value;
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
		public function get citation():String {
			return _citation;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set citation(value:String):void {
			_citation = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get referenceStart():int {
			return _referenceStart;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set referenceStart(value:int):void {
			_referenceStart = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get referenceEnd():int {
			return _referenceEnd;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set referenceEnd(value:int):void {
			_referenceEnd = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get text():String {
			return _text;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set text(value:String):void {
			_text = value;
		}
		
	}
}