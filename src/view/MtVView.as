package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	import view.reader.MiniReaderViz;
	
	public class MtVView extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		static public var MTVController				:MtVController					//controller
		
		protected var initialSize					:Point;
		
		protected var bg							:Sprite;						//Background
		
		protected var header						:Header;						//Header Panel
		protected var infoBox						:InfoBox;						//Info Box Panel
		protected var readerPanel					:ReaderPanel;					//Reader Panel
		protected var editionPanel					:EditionPanel;					//Editions Panel
		protected var variationPanel				:VariationsPanel;				//Variations Panel
		protected var commentsPanel					:CommentsPanel;					//Comment Panel
		protected var navigationPanel				:MiniReaderViz;					//Navvigation Panel
		
		protected var panelsArray					:Array;
		
		protected var gap							:int 	= 5;					//gap between elements
		protected var posMainY						:Number = 60;
		
		
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
			bg.graphics.beginFill(0xAAAAAA);
			bg.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			
			this.addChildAt(bg,0);
			
			var url:URLRequest = new URLRequest("images/background.png");
			var loader:Loader = new Loader();
			loader.load(url);
			loader.blendMode = "multiply";
			loader.alpha = .7;
			bg.addChild(loader);
			
			//Panels
			panelsArray = new Array()
			
			//--------------header---------------
			//add Header to the main view
			header = new Header(this.getController());
			this.addChild(header);
			header.initialize();
			
			panelsArray.push(header);
			
			//--------------Info Box---------------
			//add info Box to the main view
			infoBox = new InfoBox(this.getController());
			infoBox.x = 30;
			infoBox.y = 80;
			
			this.addChild(infoBox);
			
			panelsArray.push(infoBox);
			
			//--------------Editions---------------
			//add Editions to the main view
			editionPanel = new EditionPanel(this.getController());
			editionPanel.x = infoBox.x + infoBox.width + 30;
			editionPanel.y = 50;
			
			this.addChild(editionPanel);
			
			editionPanel.addEventListener(MtVEvent.SELECT, addEditionReader);
			
			panelsArray.push(editionPanel);
			
			//--------------Reader---------------
			
			readerPanel = new ReaderPanel(this.getController());
			readerPanel.x = 30;
			readerPanel.y = 180;
			readerPanel.setDimensions(335,450)
			
			this.addChild(readerPanel);
			
			panelsArray.push(readerPanel);	
			
			readerPanel = null;
			
			//--------------Variations---------------
			//add vartiations to the main view
			variationPanel = new VariationsPanel(this.getController());
			variationPanel.x = 445;
			variationPanel.y = 180;
			
			this.addChild(variationPanel);
			
			panelsArray.push(variationPanel);
			
			//--------------Comments---------------
			//add vartiations to the main view
			commentsPanel = new CommentsPanel(this.getController());
			commentsPanel.x = 725;
			commentsPanel.y = 180;
			
			this.addChild(commentsPanel);
			
			panelsArray.push(commentsPanel);
			
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
		protected function addEditionReader(e:MtVEvent):void {
				
			var editionID:int = e.parameters.editionID;
			
			readerPanel = new ReaderPanel(this.getController(),editionID);
			
			readerPanel.setDimensions(335,450)
			
			this.addChild(readerPanel);
			
			panelsArray.push(readerPanel);
			
			var posX:Number = 340;
			var posY:Number = 180;
			for each (var panel:AbstractPanel in panelsArray) {
				if (panel is ReaderPanel) {
					posX += 50;
					posY += 20;
				}
			}
			
			readerPanel.x = posX;
			readerPanel.y = posY;
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function killEditionReader(e:MtVEvent):void {
			
			var id:int = e.parameters.editionID;
			readerPanel = null;
			
			for each (var panel:AbstractPanel in panelsArray) {
				if (panel is ReaderPanel) {
					if (ReaderPanel(panel).editionID == id) {
						readerPanel = ReaderPanel(panel);
						panelsArray.splice(panelsArray.indexOf(readerPanel),1);
						break;
					}
				}
			}
			
			if (panel) {
				TweenMax.to(readerPanel,.5,{scaleX:0, scaleY:.01, alpha: .5, onComplete:removeChild, onCompleteParams:[readerPanel]});
			}
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _resize(e:Event):void {
			
			bg.graphics.clear();
			bg.graphics.beginFill(0xAAAAAA);
			bg.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			
			//bg.width = stage.stageWidth;
			//bg.height = stage.stageHeight;
			
			//panels
			if (stage.stageWidth > initialSize.x || stage.stageHeight > initialSize.y) {
				for each(var panel:AbstractPanel in panelsArray) {
					panel.resize();
				}
			}
		}
		
		
		//****************** PRIVATE METHODS ****************** ****************** ******************
		
		private function killChild(obj:DisplayObject):void {
			this.removeChild(obj);
		}
		
	}
}