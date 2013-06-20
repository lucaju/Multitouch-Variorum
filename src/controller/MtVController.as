package controller {
	
	//imports
	//import events.OrlandoEvent;
	
	import model.BaseTextModel;
	import model.CommentsModel;
	import model.EditionsModel;
	import model.MtVInterfaceModel;
	import model.VariationsModel;
	
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
		protected var variationsModel						:VariationsModel;
		protected var commentsModel							:CommentsModel;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param list
		 * 
		 */
		public function MtVController(list:Array) {
			
			super(list);
			
			mtVInterfaceModel 	= MtVInterfaceModel(getModel("MtV"));
			baseTextModel 		= BaseTextModel(getModel("baseText"));
			editionsModel 		= EditionsModel(getModel("editions"));
			variationsModel 	= VariationsModel(getModel("variations"));
			commentsModel 		= CommentsModel(getModel("comments"));

		}
		
		
		//****************** BASE TEXT ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function loadBaseText():void {
			if (!baseTextModel.hasTextBase()) baseTextModel.load();
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
		 * 
		 */
		public function loadEditions():void {
			if (!editionsModel.hasEditions()) editionsModel.load();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getEditions():Array {
			return editionsModel.getEdtions();
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getEdition(value:int):Object {
			return editionsModel.getEdtion(value);
		}
		
		
		//****************** VARIATION PANEL ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function loadVariations():void {
			if (!variationsModel.hasVariations()) variationsModel.load();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getVariationsByEdition():Array {
			var vars:Array;
			if (variationsModel.hasVariations()) return variationsModel.getVariation();
			return null;
		}
		
		
		//****************** COMMENTS PANEL ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function loadComments():void {
			if (!commentsModel.hasComments()) commentsModel.load();
		}
		
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */
		/*
		public function getEdition(id:int = 0):* {
			if (!mtVModel.hasEditions()) mtVModel.loadEditions();
			return mtVModel.getEdtion(id);
		}
		*/
		
		
		//****************** READER CONTROL ****************** ****************** ******************
		
	}
}