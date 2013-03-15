package controller {
	
	//imports
	//import events.OrlandoEvent;
	
	import model.BaseTextModel;
	import model.CommentsModel;
	import model.EditionsModel;
	import model.MtVInterfaceModel;
	import model.VariationsModel;
	
	import mvc.AbstractController;
	
	public class MtVController extends AbstractController {
		
		//properties
		private var mtVInterfaceModel:MtVInterfaceModel;
		private var baseTextModel:BaseTextModel;
		private var editionsModel:EditionsModel;
		private var variationsModel:VariationsModel;
		private var commentsModel:CommentsModel;
		
		
		public function MtVController(list:Array) {
			
			super(list);
			
			mtVInterfaceModel = MtVInterfaceModel(getModel("MtV"));
			baseTextModel = BaseTextModel(getModel("baseText"));
			editionsModel = EditionsModel(getModel("editions"));
			variationsModel = VariationsModel(getModel("variations"));
			commentsModel = CommentsModel(getModel("comments"));
			
			
		}
		
		// --------- Base Text
		
		public function loadBaseText():void {
			if (!baseTextModel.hasTextBase()) {
				baseTextModel.load();
			}
		}
		
		public function loadEditionText(value:int):void {
			baseTextModel.loadEdition(value);
		}
		
		// --------- Edition Panel
		
		public function loadEditions():void {
			if (!editionsModel.hasEditions()) {
				editionsModel.load();
			}
		}
		
		public function getEditions():Array {
			return editionsModel.getEdtions();
		}
		
		public function getEdition(value:int):Object {
			return editionsModel.getEdtion(value);
		}
		
		
		// --------- Variations Panel
		
		public function loadVariations():void {
			if (!variationsModel.hasVariations()) {
				variationsModel.load();
			}
		}
		
		public function getVariationsByEdition():Array {
			var vars:Array;
			
			if (variationsModel.hasVariations()) {
				return variationsModel.getVariation();
			}
			
			return null;
			
		}
		
		
		// --------- Comments Panel
		
		public function loadComments():void {
			if (!commentsModel.hasComments()) {
				commentsModel.load();
			}
		}
		
		/*
		public function getEdition(id:int = 0):* {
			if (!mtVModel.hasEditions()) {
				mtVModel.loadEditions();
			}
			
			return mtVModel.getEdtion(id);
		}
		*/
		
		
		//---------- READER CONTROLS
		
	}
}