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
	
	import settings.Settings;
	
	import util.DeviceInfo;
	import util.Global;
	
	import view.MtVView;
	
	[SWF(width="1250", height="850", backgroundColor="#ffffff", frameRate="30")]
	//[SWF(width="1920", height="1080", backgroundColor="#ffffff", frameRate="30")]
	//[SWF(width="1920", height="1030", backgroundColor="#ffffff", frameRate="30")]
	
	public class MtV extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		protected var mtVInterfaceModel				:MtVInterfaceModel; 		//Model
		protected var baseTextModel					:BaseTextModel;				//Model
		protected var editionsModel					:EditionsModel;				//Model
		protected var variatonsModel				:VariationsModel;			//Model
		protected var commentsModel					:CommentsModel;				//Model
		
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
			variatonsModel = new VariationsModel();
			commentsModel = new CommentsModel();
			
			//starting controler
			mtvController = new MtVController([mtVInterfaceModel,baseTextModel,editionsModel,variatonsModel,commentsModel]);
			
			//Starting View
			mtvView = new MtVView(mtvController);
			addChild(mtvView);
			mtvView.initialize();
			
			trace (DeviceInfo.os())
			
			if (Settings.platformTarget == "mobile") {
				mtvView.scaleX = mtvView.scaleY = 2;
			}
			
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
		}
		
	}
}