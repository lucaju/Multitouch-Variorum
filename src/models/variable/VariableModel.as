package models.variable {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class VariableModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id							:int;
		protected var _line							:int;
		protected var _lineEnd						:int;
		protected var _variableID					:int;
		protected var _xmlTarget					:String;
		protected var _source						:String;
		protected var _variations					:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function VariableModel(id_:int) {
			//------init
			_id = id_;
			_variations = new Array();
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		public function addVariation(_id, _variant, _type, _editions):void {
			var variaton:VariationModel = new VariationModel(_variations.length);
			variaton.uid = _id;
			variaton.variant = _variant;
			variaton.type = _type;
			variaton.editions = _editions;
			
			_variations.push(variaton);
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
		public function get variableID():int {
			return _variableID;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set variableID(value:int):void {
			_variableID = value;
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
		public function get variations():Array {
			return _variations.concat();;
		}

	}
}