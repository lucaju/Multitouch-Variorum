package models.variable {
	
	//imports
	import flash.events.Event;
	
	import events.MtVEvent;
	
	import models.reader.VariationVariableModel;
	
	import mvc.Observable;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class VariablesModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var colletion				:Array;
		
		
		//****************** Constuctor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function VariablesModel() {	
			super();
			this.name = "variables";
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function processComplete(e:Event):void {
			colletion = e.target.data;
			
			var obj:Object = {data:colletion}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE, null, obj));	
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		//****************** PROCCESS ****************** 
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pV:ProcessVariations = new ProcessVariations();
			pV.addEventListener(Event.COMPLETE, processComplete);
			pV = null;
		}
		
		//****************** GENERAL INFORMATION ****************** 
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get hasVariables():Boolean {
			return colletion ? true : false;
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getNumVariables():int {
			return colletion.length;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariables():Array {
			return colletion.concat();
		}
		
		//****************** VARIABLE SPECIFIC INFORMATION ****************** 
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariable(value:int):VariableModel {
			for each (var VAR:VariableModel in colletion) {
				if (VAR.variableID == value) {
					return VAR;
				}
			}
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getLineFromVariableID(value:int):int {
			var variable:VariableModel = getVariable(value);
			return variable.line;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getSourceFromVariableID(value:int):String {
			var variable:VariableModel = getVariable(value);
			return variable.source;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getNumVariationsByEdition(value:int):int {
			
			var count:int = 0;
			
			for each (var variable:VariableModel in colletion) {
				
				for each (var variation:VariationModel in variable.variations) {
					
					for each (var edition:int in variation.editions) {
						
						if (edition == value) {
							count++;
							break;
						}
						
					}
					
				}
				
			}
			
			return count;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariationsByEditionID(value:int):Array {
			
			var variationsEdition:Array = new Array();
			var variationVariable:VariationVariableModel;
			
			for each (var variable:VariableModel in colletion) {
				
				for each (var variation:VariationModel in variable.variations) {
					
					for each (var edition:int in variation.editions) {
						
						if (edition == value) {
							variationVariable = new VariationVariableModel(variable.variableID, variation.uid, variation.variant);
							variationsEdition.push(variationVariable);
							break;
						}
						
					}
					
				}
				
			}
			
			return variationsEdition;
		}
		
		
		//****************** VARIATION SPECIFIC INFORMATION ******************
		
		public function getVariation(variableID:int,variationID:int):VariationModel {
			var variable:VariableModel = getVariable(variableID);
			for each (var variation:VariationModel in variable.variations) {
				if (variation.id == variationID) return variation;
			}
			return null;
		}
		
		/**
		 * 
		 * @param variableID
		 * @param variationID
		 * @return 
		 * 
		 */
		public function getUIDFromVariationID(variableID:int,variationID:int):int {
			var variation:VariationModel = getVariation(variableID,variationID);
			return variation.uid;
		}
		
		/**
		 * 
		 * @param variableID
		 * @param variationID
		 * @return 
		 * 
		 */
		public function getVariantFromVariationID(variableID:int,variationID:int):String {
			var variation:VariationModel = getVariation(variableID,variationID);
			return variation.variant;
		}
		
		/**
		 * 
		 * @param variableID
		 * @param variationID
		 * @return 
		 * 
		 */
		public function getTypeFromVariationID(variableID:int,variationID:int):String {
			var variation:VariationModel = getVariation(variableID,variationID);
			return variation.type;
		}
		
		/**
		 * 
		 * @param variableID
		 * @param variationID
		 * @return 
		 * 
		 */
		public function getEditionsFromVariationID(variableID:int,variationID:int):Array {
			var variation:VariationModel = getVariation(variableID,variationID);
			return variation.editions;
		}
		
		
	}
}