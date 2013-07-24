package models.reader {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class VariationVariableModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _variableID					:int;
		protected var _variationUID					:int;
		protected var _variationText				:String;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function VariationVariableModel(variableID_:int, variationUID_:int, variationText_) {
			_variableID = variableID_;
			_variationUID = variationUID_;
			_variationText = variationText_;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************

		public function update(variationUID_:int, variationText_:String = ""):Boolean {
			_variationUID = variationUID_;
			if (variationText_ != "") _variationText = variationText_;
			return true;
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

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
		 * @return 
		 * 
		 */
		public function get variationUID():int {
			return _variationUID;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get variationText():String {
			return _variationText;
		}


	}
}