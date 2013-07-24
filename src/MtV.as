package {
	
	//imports
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import controller.MtVController;
	
	import models.MtVInterfaceModel;
	import models.baseText.BaseTextModel;
	import models.comment.CommentsModel;
	import models.edition.EditionsModel;
	import models.reader.ReadersModel;
	import models.variable.VariablesModel;
	
	import settings.Settings;
	
	import util.Global;
	
	import views.MtVView;
	
	[SWF(width="1250", height="850", backgroundColor="#ffffff", frameRate="30")]
	//[SWF(width="1920", height="1080", backgroundColor="#ffffff", frameRate="30")]
	//[SWF(width="1920", height="1030", backgroundColor="#ffffff", frameRate="30")]
	
	public class MtV extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		protected var mtVInterfaceModel				:MtVInterfaceModel; 		//Model
		protected var baseTextModel					:BaseTextModel;				//Model
		protected var editionsModel					:EditionsModel;				//Model
		protected var variatonsModel				:VariablesModel;			//Model
		protected var commentsModel					:CommentsModel;				//Model
		protected var readersModel					:ReadersModel;				//Model
		
		protected var mtvController					:MtVController;				//Controller
		
		protected var mtvView						:MtVView;					//View
		
		protected var configure						:Settings;					//Settings
		
		//****************** Constructor ****************** ****************** ******************
		
		public function MtV() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//settings
			setting();
			
			//global
			Global.globalWidth = stage.stageWidth;
			Global.globalHeight = stage.stageHeight;
			
			//Starting models
			mtVInterfaceModel = new MtVInterfaceModel();
			baseTextModel = new BaseTextModel();
			editionsModel = new EditionsModel();
			variatonsModel = new VariablesModel();
			commentsModel = new CommentsModel();
			readersModel = new ReadersModel();
			
			//starting controler
			mtvController = new MtVController([mtVInterfaceModel,baseTextModel,editionsModel,variatonsModel,commentsModel,readersModel]);
			
			//Starting View
			mtvView = new MtVView(mtvController);
			addChild(mtvView);
			mtvView.initialize();
			
			//trace (DeviceInfo.os())
			
			if (Settings.platformTarget == "mobile") mtvView.scaleX = mtvView.scaleY = 2;
			
			//debug stat
			//addChild(new Stats());
			
		}
		
		//****************** PRIVATE METHODS ****************** ****************** ****************** 
		
		/**
		 * 
		 * 
		 */
		private function setting():void {
			configure = new Settings();
			//default values
			Settings.platformTarget = "air";
			Settings.debug = false;
			Settings.menuType = "circular";
		}
		
	}
}