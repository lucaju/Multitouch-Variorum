package models.reader {
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderModel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id						:int;
		protected var _editionID				:int;
		protected var _variationCollection		:Array;
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function ReaderModel(id_:int, editionID_) {
			_id = id_;
			_editionID = editionID_;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		public function loadVariationCollection(valueArray:Array):Boolean {
			if (_variationCollection) {
				return false;
			} else {
				_variationCollection = valueArray;
				return true;
			}
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
		
		public function get editionID():int {
			return _editionID;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get variationCollection():Array {
			return _variationCollection;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVariationVariableByVariableID(value:int):VariationVariableModel {
			for each (var variationVariable:VariationVariableModel in variationCollection) {
				if (variationVariable.variableID == value) return variationVariable;
			}
			return null;
		}
		
		/**
		 * 
		 * @param variableID
		 * @param variationText
		 * @return 
		 * 
		 */
		public function checkVariationSelection(variableID:int):VariationVariableModel {
			var variationVariable:VariationVariableModel = getVariationVariableByVariableID(variableID);
			if (variationVariable) return variationVariable;
			return null
		}
		
		
		/**
		 * 
		 * @param variableID
		 * @param variationUID
		 * @param variationText
		 * @return 
		 * 
		 */
		public function setVariableVariation(variableID:int, variationUID:int, variationText:String):Boolean {
			
			var update:Boolean = false;
			
			//test if there is any variation for this variable
			var variationVariable:VariationVariableModel = getVariationVariableByVariableID(variationUID);
			
			if (variationVariable) {
				update = this.changeVariationVariable(variationVariable, variationUID, variationText);
			} else {
				update = this.addVariationVariable(variableID, variationUID, variationText)
			}
			
			return update;
		}
		
		/**
		 * 
		 * @param variableID
		 * @param variationUID
		 * @param variationText
		 * @return 
		 * 
		 */
		public function addVariationVariable(variableID:int, variationUID:int, variationText:String):Boolean {
			var variationVariable:VariationVariableModel = new VariationVariableModel(variableID, variationUID, variationText);
			return true;
		}
		
		public function changeVariationVariable(variationVariable:VariationVariableModel, variationUID:int, variationText:String):Boolean {
			variationVariable.update(variationUID, variationText);
			return true;
		}
		
	}
}