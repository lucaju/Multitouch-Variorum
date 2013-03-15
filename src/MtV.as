package {
	
	//imports
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import controller.MtVController;
	
	import model.BaseTextModel;
	import model.CommentsModel;
	import model.EditionsModel;
	import model.MtVInterfaceModel;
	import model.VariationsModel;
	
	import util.DeviceInfo;
	import util.Global;
	
	import view.MtVView;
	
	[SWF(width="1250", height="850", backgroundColor="#ffffff", frameRate="30")]
	//[SWF(width="1920", height="1080", backgroundColor="#ffffff", frameRate="30")]
	//[SWF(width="1920", height="1030", backgroundColor="#ffffff", frameRate="30")]
	
	
	public class MtV extends Sprite {
		
		//properties
		private var mtVInterfaceModel:MtVInterfaceModel;	//Model
		private var baseTextModel:BaseTextModel;			//Model
		private var editionsModel:EditionsModel;			//Model
		private var variatonsModel:VariationsModel;			//Model
		private var commentsModel:CommentsModel;			//Model
		
		private var mtvController:MtVController;			//Controller
		
		private var mtvView:MtVView;						//View
		
		public function MtV() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//global
			Global.globalWidth = stage.stageWidth;
			Global.globalHeight = stage.stageHeight;
			
			//Starting models
			mtVInterfaceModel = new MtVInterfaceModel();
			baseTextModel = new BaseTextModel();
			editionsModel = new EditionsModel();
			variatonsModel = new VariationsModel();
			commentsModel = new CommentsModel();
			
			//starting controler
			mtvController = new MtVController([mtVInterfaceModel,baseTextModel,editionsModel,variatonsModel,commentsModel]);
			
			//Starting View
			mtvView = new MtVView(mtvController);
			addChild(mtvView);
			mtvView.initialize();
			
			trace (DeviceInfo.os())
			
			if (DeviceInfo.os() != "Mac") {
				mtvView.scaleX = mtvView.scaleY = 2;
			}
			
			//debug stat
			//addChild(new Stats());
			
		}
		
	}
}