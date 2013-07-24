package models.variable {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class VariationModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id							:int;
		protected var _uid							:int;
		protected var _variant						:String;
		protected var _type							:String;
		protected var _editions						:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function VariationModel(id_:int) {
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
		public function get uid():int {
			return _uid;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set uid(value:int):void {
			_uid = value;
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