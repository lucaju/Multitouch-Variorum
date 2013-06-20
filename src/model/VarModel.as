package model {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class VarModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id							:int;
		protected var _line							:int;
		protected var _lineEnd						:int;
		protected var _xmlTarget					:String;
		protected var _source						:String;
		protected var _variant						:String;
		protected var _type							:String;
		protected var _editions						:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function VarModel(id_:int) {
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
		public function get line():int {
			return _line;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set line(value:int):void {
			_line = value;
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
		public function get xmlTarget():String {
			return _xmlTarget;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set xmlTarget(value:String):void {
			_xmlTarget = value;
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
		public function get variant():String {
			return _variant;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set variant(value:String):void {
			_variant = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get type():String {
			return _type;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set type(value:String):void {
			_type = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get editions():Array {
			return _editions;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set editions(value:Array):void {
			_editions = value;
		}
		
	}
}