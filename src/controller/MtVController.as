package controller {
	
	//imports
	//import events.OrlandoEvent;
	
	import models.MtVInterfaceModel;
	import models.baseText.BaseTextModel;
	import models.comment.CommentsModel;
	import models.edition.EditionModel;
	import models.edition.EditionsModel;
	import models.reader.ReadersModel;
	import models.variable.VariablesModel;
	
	import mvc.AbstractController;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class MtVController extends AbstractController {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var mtVInterfaceModel						:MtVInterfaceModel;
		protected var baseTextModel							:BaseTextModel;
		protected var editionsModel							:EditionsModel;
		protected var variablesModel						:VariablesModel;
		protected var commentsModel							:CommentsModel;
		protected var readersModel							:ReadersModel;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param list
		 * 
		 */
		public function MtVController(list:Array) {
			
			super(list);
			
			mtVInterfaceModel 	= MtVInterfaceModel(getModel("mtv"));
			baseTextModel 		= BaseTextModel(getModel("baseText"));
			editionsModel 		= EditionsModel(getModel("editions"));
			variablesModel 		= VariablesModel(getModel("variables"));
			commentsModel 		= CommentsModel(getModel("commentaries"));
			readersModel 		= ReadersModel(getModel("readers"));

		}
		
		
		//****************** READER ****************** ****************** ******************
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function addReader(editionID:int):int {
			return readersModel.addReader(editionID);
		}
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function removeReader(readerID:int):Boolean {
			return readersModel.removeReader(readerID);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function numReaders():int {
			return readersModel.numReaders();
		}
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function editionID(editionID:int):Boolean {
			return readersModel.hasReaderByEdition(editionID);
		}
		
		/**
		 * 
		 * @param readerID
		 * @param variations
		 * @return 
		 * 
		 */
		public function setVariationToReader(readerID:int, variations:Array):Boolean {
			return readersModel.setVariationToReader(readerID, variations);
		}
		
		
		/**
		 * 
		 * @param readerID
		 * @return 
		 * 
		 */
		public function getReaderVariations(readerID:int):Array {
			return readersModel.getReaderVariations(readerID);
		}
		
		/**
		 * 
		 * @param readerID
		 * @param variableID
		 * @param variationText
		 * @return 
		 * 
		 */
		public function checkReaderVariationSelection(readerID:int, variableID:int):Object {
			return readersModel.checkReaderVariationSelection(readerID, variableID);
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
			return readersModel.setReaderVariation(readerID, variableID,variationUID,variationText);
		}

		
		//****************** BASE TEXT ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function loadBaseText():XML {
			if (!baseTextModel.hasTextBase()) {
				baseTextModel.load();
				return null;
			} else {
				return baseTextModel.getBaseText();
			}
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function loadEditionText(value:int):void {
			baseTextModel.loadEdition(value);
		}
		
		//****************** EDITION PANEL ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get hasEditions():Boolean {
			return editionsModel.hasEditions;
		}
		
		/**
		 * 
		 * 
		 */
		public function loadEditions():void {
			if (!editionsModel.hasEditions) editionsModel.load();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getEditions():Array {
			if (editionsModel.hasEditions) return editionsModel.getEdtions();
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getEdition(value:int):EditionModel {
			if (editionsModel.hasEditions) return editionsModel.getEdtion(value);
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getAuthorFromEditionID(value:int):String {
			if (editionsModel.hasEditions) return editionsModel.getAuthorFromEditionID(value);
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getYearFromEditionID(value:int):Number {
			if (editionsModel.hasEditions) return editionsModel.getYearFromEditionID(value);
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @param type
		 * @return 
		 * 
		 */
		public function getEditionInfo(value:int, type:String):* {
			
			if (editionsModel.hasEditions) {
				
				switch (type.toLowerCase()) {
					case "abbreviation":
						return editionsModel.getAbbreviationFromEditionID(value);
						break;
					
					case "author":
						return editionsModel.getAuthorFromEditionID(value);
						break;
					
					case "title":
						return editionsModel.getTitleFromEditionID(value);
						break;
					
					case "year":
						return editionsModel.getYearFromEditionID(value);
						break;
					
					case "numvariations":
						var numVariations:Number = editionsModel.getNumVariationsFromEditionID(value);
						if (numVariations == -1) numVariations = getNumVariationsByEdition(numVariations);
						return numVariations;
						break;
				}
				
			}
			
			return null;

		}
		
		//****************** VARIABLES ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get hasVariables():Boolean {
			return variablesModel.hasVariables;
		}
		
		/**
		 * 
		 * 
		 */
		public function loadVariables():void {
			if (!variablesModel.hasVariables) variablesModel.load();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getNumVariables():int {
			if (variablesModel.hasVariables) return variablesModel.getNumVariables();
			return null;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVariables():Array {
			if (variablesModel.hasVariables) return variablesModel.getVariables();
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariableLine(value:int):int {
			if (variablesModel.hasVariables) return variablesModel.getLineFromVariableID(value);
			return null;
		}
		
		
		/**
		 * 
		 * @param value
		 * @param type
		 * @return 
		 * 
		 */
		public function getVariableInfo(value:int, type:String):* {
			
			if (variablesModel.hasVariables) {
				
				switch (type.toLowerCase()) {
					case "line":
						return variablesModel.getLineFromVariableID(value);
						break;
					
					case "source":
						return variablesModel.getSourceFromVariableID(value);
						break;
					
					case "variations":
						return variablesModel.getNumVariationsByEdition(value);
						break;
				}
				
			}
			
			return null;
			
		}
		
		
		//****************** VARIATIONS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getNumVariationsByEdition(value:int):int {
			if (variablesModel.hasVariables) {
				
				//get data
				var numVariations:Number = variablesModel.getNumVariationsByEdition(value);
				
				//save to edition
				var edition:EditionModel = this.getEdition(value);
				edition.numVariations = numVariations;
				
				//return value
				return numVariations
			}
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariationsByEditionID(value:int):Array {
			if (variablesModel.hasVariables) {
				return variablesModel.getVariationsByEditionID(value);
			}
			return null;
		}
		
		
		/**
		 * 
		 * @param variableID
		 * @param variationID
		 * @param type
		 * @return 
		 * 
		 */
		public function getVariationInfo(variableID, variationID:int, type:String):* {
			
			if (variablesModel.hasVariables) {
				
				switch (type.toLowerCase()) {
					case "uid":
						return variablesModel.getUIDFromVariationID(variableID,variationID);
						break;
					
					case "variant":
						return variablesModel.getVariantFromVariationID(variableID,variationID);
						break;
					
					case "type":
						return variablesModel.getTypeFromVariationID(variableID,variationID);
						break;
					
					case "editions":
						return variablesModel.getEditionsFromVariationID(variableID,variationID);
						break;
				}
				
			}
			
			return null;
				
		}
		
		
		
		//****************** COMMENTS PANEL ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get hascomments():Boolean {
			return commentsModel.hasComments;
		}
		
		/**
		 * 
		 * 
		 */
		public function loadComments():void {
			if (!commentsModel.hasComments) commentsModel.load();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getNumComments():int {
			if (commentsModel.hasComments) return commentsModel.getTotal();
			return null;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getComments():Array {
			if (commentsModel.hasComments) return commentsModel.getComments();
			return null;
		}
		
		
		/**
		 * 
		 * @param id
		 * @param type
		 * @return 
		 * 
		 */
		public function getCommentInfo(id:int, type:String):* {
			
			if (commentsModel.hasComments) {
				
				switch (type.toLowerCase()) {
					case "linestart":
						return commentsModel.getLineStartFromCommentID(id);
						break;
					
					case "source":
						return commentsModel.getSourceFromCommentID(id);
						break;
					
					case "author":
						return commentsModel.getAuthorFromCommentID(id);
						break;
					
					case "text":
						return commentsModel.getTextFromCommentID(id);
						break;
				}
				
			}
			
			return null;
			
		}
		
		
		//****************** READER CONTROL ****************** ****************** ******************
		
	}
}