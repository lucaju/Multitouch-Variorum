package views {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.TweenProxy;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	import settings.Settings;
	
	import views.readerWindow.ReaderWindow;
	import views.readerWindow.panels.AbstractPanel;
	import views.witnesses.AbstractEditionPreview;
	import views.witnesses.AbstractEditionsMenu;
	import views.witnesses.EditionPreviewFactory;
	import views.witnesses.EditionsMenuFactory;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class MtVView extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		static public var MTVController				:MtVController					//controller
		
		protected var initialSize					:Point;
		
		protected var bg							:Sprite;						//Background
		
		protected var topBar						:TopBar;						//Header Panel
		protected var readerWindow					:ReaderWindow;					//Reader Panel
		protected var editionsMenu					:AbstractEditionsMenu;					//Editions Panel
		
		protected var readersArray					:Array;
		
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function MtVView(c:IController) {
			
			super(c);
			
			//define controller
			MTVController = MtVController(c);
			
			//Listeners
			this.addEventListener(Event.ADDED_TO_STAGE, _added);
			this.addEventListener(MtVEvent.KILL, killEditionReader);
				
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function initialize():void {
			
			//bg
			bg = new Sprite();
			bg.graphics.beginFill(0x999999);
			bg.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			
			this.addChildAt(bg,0);
			
			var url:URLRequest = new URLRequest("images/background.png");
			var loader:Loader = new Loader();
			loader.load(url);
			loader.blendMode = "multiply";
			loader.alpha = .7;
			bg.addChild(loader);
			
			
			//--------------header---------------
			//add Header to the main view
			if (Settings.menuType == "linear")  {
				topBar = new TopBar(this.getController());
				this.addChild(topBar);
				topBar.initialize();
			}
			
			//--------------Reader---------------
			readersArray = new Array()
				
			readerWindow = new ReaderWindow(this.getController());
			
			//this.addChildAt(readerWindow,this.numChildren-1);
			this.addChild(readerWindow);
			
			readersArray.push(readerWindow);
			
			//proxy
			var readerWindowProxy:TweenProxy = TweenProxy.create(readerWindow);	
			readerWindowProxy.registration = new Point(readerWindow.currentWidth/2, readerWindow.currentHeight/2);
			
			//position
			readerWindowProxy.x = 230;
			readerWindowProxy.y = 400;
			
			//animation
			TweenMax.from(readerWindowProxy,3,{y:"-100", alpha:0, delay:2});
			
			readerWindow = null;
			
			//--------------Editions---------------
			//add Editions to the main view
			editionsMenu = EditionsMenuFactory.addMenu(this.getController(), Settings.menuType);
			
			if (Settings.menuType == "linear") {
				editionsMenu.y = topBar.height;
				this.addChildAt(editionsMenu, this.getChildIndex(topBar));
				TweenMax.from(editionsMenu,3,{y:"-70", delay:4});
			} else if (Settings.menuType == "circular") {
				this.addChildAt(editionsMenu,this.numChildren-1);
				TweenMax.from(editionsMenu,3,{scaleX:0, scaleY:0, delay:4, ease:Back.easeOut});
			}
			
			editionsMenu.init();
			//editionsMenu.addEventListener(MtVEvent.SELECT, addEditionPreview);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _added(e:Event):void {
			
			//listeners
			stage.addEventListener(Event.RESIZE, _resize);
			
			//get screensize
			initialSize = new Point(stage.stageWidth,stage.stageHeight);
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function addEditionPreview(event:MtVEvent):void {
			
			//add preview
			var editionPreview:AbstractEditionPreview = EditionPreviewFactory.addPreview(this.getController(), event.parameters.editionID, Settings.menuType);
	
			editionPreview.x = event.parameters.x - (editionPreview.width/2);
			editionPreview.y = event.parameters.y;
			editionPreview.rotation = event.parameters.rotation;
			this.addChild(editionPreview);
			
			editionPreview.addEventListener(MouseEvent.MOUSE_UP, editionPreviewReleased);
			
		}
		
		protected function editionPreviewReleased(event:MouseEvent):void {
			
			event.stopPropagation();
			
			var editionPreview:AbstractEditionPreview = AbstractEditionPreview(event.currentTarget);
			
			if (Settings.menuType == "linear") {
				
				if (editionPreview.y > editionsMenu.y + editionsMenu.height - 25) {
					this.addEditionReader(editionPreview);
				} else {
					this.killEditionPreview(editionPreview);
				}
				
			} else if (Settings.menuType == "circular") {
				if (editionPreview.updatedValues > 150) {
					this.addEditionReader(editionPreview);
				} else {
					this.killEditionPreview(editionPreview);
				}
			}
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function killEditionReader(e:MtVEvent):void {
			
			var id:int = e.parameters.editionID;
			readerWindow = null;
			
			for each (var panel:AbstractPanel in readersArray) {
				if (panel is ReaderWindow) {
					if (ReaderWindow(panel).editionID == id) {
						readerWindow = ReaderWindow(panel);
						readersArray.splice(readersArray.indexOf(readerWindow),1);
						break;
					}
				}
			}
			
			if (panel) {
				TweenMax.to(readerWindow,.5,{scaleX:0, scaleY:.01, alpha: .5, onComplete:removeChild, onCompleteParams:[readerWindow]});
			}
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _resize(event:Event):void {
			
			bg.graphics.clear();
			bg.graphics.beginFill(0x999999,.2);
			bg.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			
			//bg.width = stage.stageWidth;
			//bg.height = stage.stageHeight;
			
			// Editions Menu
			if (topBar) topBar.resize(); 
			editionsMenu.resize();
			
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************

		/**
		 * 
		 * @param editionPreview
		 * 
		 */
		protected function addEditionReader(editionPreview:AbstractEditionPreview):void {
			
			//highlight edition in edition menu
			editionsMenu.editionOpened(editionPreview.editionID);
			
			//create reader window
			readerWindow = new ReaderWindow(this.getController(),editionPreview.editionID);
			this.addChildAt(readerWindow,this.numChildren-1);
			readersArray.push(readerWindow);
			
			//proxy
			var readerWindowProxy:TweenProxy = TweenProxy.create(readerWindow);	
			readerWindowProxy.registration = new Point(readerWindow.currentWidth/2, readerWindow.currentHeight/2);
			
			//position
			var posX:Number = editionPreview.x; 
			var posY:Number = editionPreview.y;
			
			//new position
			readerWindowProxy.x = posX;
			readerWindowProxy.y = posY;
		 	if (Settings.menuType == "circular") readerWindowProxy.rotation = editionPreview.rotation;
			
			//animation
			TweenMax.from(readerWindow,1,{alpha:0});;
			TweenMax.to(editionPreview,1,{x:readerWindow.x + (readerWindow.width/2), y:readerWindow.y + (readerWindow.height/2), width:335, height:450, alpha:0, onComplete:killChild, onCompleteParams:[editionPreview]});
			
		}
		

		/**
		 * 
		 * @param editionPreview
		 * 
		 */
		protected function killEditionPreview(editionPreview:AbstractEditionPreview):void {
			TweenMax.to(editionPreview,.7,{alpha:0, scaleX:.2, scaleY:.2, onComplete:killChild, onCompleteParams:[editionPreview]});
		}
		
		//****************** PRIVATE METHODS ****************** ****************** ******************
		
		private function killChild(obj:DisplayObject):void {
			this.removeChild(obj);
		}
		
	}
}