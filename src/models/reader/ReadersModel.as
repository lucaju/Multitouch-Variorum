package models.reader {
	
	//imports
	import events.MtVEvent;
	
	import mvc.Observable;
	
	import views.readerWindow.panels.variationPanel.Variation;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReadersModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var collection				:Array;
		protected var readerCont				:int = 1;
		
		
		//****************** Constuctor ****************** ****************** ******************
		
		public function ReadersModel() {	
			super();
			this.name = "readers";
			collection = new Array();
		}
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		
		//****************** GENERAL INFORMATION ****************** 
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function addReader(editionID:int):int {
			var reader:ReaderModel = new ReaderModel(readerCont,editionID);
			collection.push(reader);
			readerCont++;
			return reader.id;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function removeReader(readerID:int):Boolean {
			var reader:ReaderModel = getReaderByID(readerID);
			if (reader) {
				collection.splice(collection.indexOf(reader),1);
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function numReaders():int {
			return collection.length;
		}
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function hasReaderByEdition(editionID:int):Boolean {
			for each(var reader:ReaderModel in collection) {
				if 	(reader.editionID == editionID) return true;
			}
			return false;
		}
		
		
		//****************** SPECIFIC INFORMATION ****************** 
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function getReaderByID(readerID:int):ReaderModel {
			for each(var reader:ReaderModel in collection) {
				if 	(reader.id == readerID) return reader
			}
			return null;
		}
	
		/**
		 * 
		 * @param readerID
		 * @param variations
		 * @return 
		 * 
		 */
		public function setVariationToReader(readerID:int, variations:Array):Boolean {
			var reader:ReaderModel = getReaderByID(readerID);
			return reader.loadVariationCollection(variations);
		}
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function getReaderVariations(readerID:int):Array {
			var reader:ReaderModel = getReaderByID(readerID);
			
			var readerVariations:Array = reader.variationCollection;
			
			var params:Object = {readerID: readerID, readerVariations:readerVariations};
			this.dispatchEvent(new MtVEvent(MtVEvent.UPDATE, null, params));
			
			return readerVariations;
		}
		
		/**
		 * 
		 * @param readerID
		 * @param variableID
		 * @return 
		 * 
		 */
		public function checkReaderVariationSelection(readerID:int, variableID:int):Object {
			var checked:Boolean = false;
			var variationUID:int = 0;
			var text:String = "";
			
			var reader:ReaderModel = getReaderByID(readerID);
			var variationChecked:VariationVariableModel =  reader.checkVariationSelection(variableID);
			
			if (variationChecked) {
				checked = true;
				variationUID = variationChecked.variationUID;
				text = variationChecked.variationText;
			}
			
			//result
			var readerVariationSelectionChecked:Object = new Object();
			readerVariationSelectionChecked.readerID = readerID;
			readerVariationSelectionChecked.variableID = variableID;
			readerVariationSelectionChecked.variationUID = variationUID;
			readerVariationSelectionChecked.checked = checked;
			readerVariationSelectionChecked.text = text;
			
			this.dispatchEvent(new MtVEvent(MtVEvent.UPDATE, "checkReaderVariationSelection", readerVariationSelectionChecked));
			
			return readerVariationSelectionChecked;
		}
		
		/**
		 * 
		 * @param readerID
		 * @param variableID
		 * @param variationUID
		 * @param variationText
		 * @return 
		 * 
		 */
		public function setReaderVariation(readerID:int, variableID:int, variationUID:int, variationText:String):Boolean {
			var reader:ReaderModel = getReaderByID(readerID);
			return reader.setVariableVariation(variableID,variationUID,variationText);
		}
		
	}
}