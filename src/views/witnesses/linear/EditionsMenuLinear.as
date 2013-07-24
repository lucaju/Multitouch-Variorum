package views.witnesses.linear {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import models.edition.EditionsModel;
	
	import mvc.IController;
	
	import views.util.scroll.Scroll;
	import views.witnesses.AbstractEditionsMenu;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionsMenuLinear extends AbstractEditionsMenu {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _maxHeight				:Number = 120;
		
		protected var pullHeader				:EditionsHeaderLinear
		protected var editions					:EditionsLinear;
		
		protected var drawer					:Sprite;
		protected var editionsMask				:Sprite;
		
		protected var containerMask				:Sprite;
		protected var scroll					:Scroll;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function EditionsMenuLinear(c:IController) {
			super(c);
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		override public function init():void {
			
			//1. Header
			pullHeader = new EditionsHeaderLinear();
			pullHeader.x = (stage.stageWidth/2) - (pullHeader.width/2);
			
			this.addChild(pullHeader);
			
			//listeners
			pullHeader.addEventListener(MouseEvent.MOUSE_DOWN, pullHeaderMouseDown);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function pullHeaderMouseDown(event:MouseEvent):void {
			
			//add drawer
			if (!drawer) this.addDrawer();
			
			var rectLimit:Rectangle = new Rectangle(pullHeader.x, 0, 0, maxHeight);
			pullHeader.startDrag(false,rectLimit);
			
			//listeners
			pullHeader.removeEventListener(MouseEvent.MOUSE_DOWN, pullHeaderMouseDown);
			
			pullHeader.addEventListener(MouseEvent.MOUSE_UP, pullHeaderMouseUp);
			pullHeader.addEventListener(MouseEvent.MOUSE_OUT, pullHeaderMouseUp);
			pullHeader.addEventListener(MouseEvent.MOUSE_MOVE, pullHeaderMouseMove);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function pullHeaderMouseMove(event:MouseEvent):void {
			drawer.height = pullHeader.y;
			if (editionsMask) editionsMask.height = pullHeader.y;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function pullHeaderMouseUp(event:MouseEvent):void {
			
			//listeners
			pullHeader.addEventListener(MouseEvent.MOUSE_DOWN, pullHeaderMouseDown);
			
			pullHeader.removeEventListener(MouseEvent.MOUSE_UP, pullHeaderMouseUp);
			pullHeader.removeEventListener(MouseEvent.MOUSE_OUT, pullHeaderMouseUp);
			pullHeader.removeEventListener(MouseEvent.MOUSE_MOVE, pullHeaderMouseMove);
			
			//stop drag
			pullHeader.stopDrag();
			
			//final position
			if (!expanded) {
				
				if (drawer.height > (maxHeight * .2)) {
					TweenMax.to(pullHeader, .5, {y:maxHeight});
					TweenMax.to(drawer, .5, {height:maxHeight});
					if (editionsMask) TweenMax.to(editionsMask, .5, {height:maxHeight});
					expanded = !expanded;
				} else {
					TweenMax.to(pullHeader, .5, {y:0});
					TweenMax.to(drawer, .5, {height:0});
					if (editionsMask) TweenMax.to(editionsMask, .5, {height:0});
				}
				
				
			} else {
				
				if (drawer.height > (maxHeight * .8)) {
					TweenMax.to(pullHeader, .5, {y:maxHeight});
					TweenMax.to(drawer, .5, {height:maxHeight});
					if (editionsMask) TweenMax.to(editionsMask, .5, {height:maxHeight});
				} else {
					TweenMax.to(pullHeader, .5, {y:0});
					TweenMax.to(drawer, .5, {height:0});
					if (editionsMask) TweenMax.to(editionsMask, .5, {height:0, onComplete:removeEditions});
					expanded = !expanded;
				}
				
			}
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function dataLoaded(event:MtVEvent):void {
			event.stopPropagation();
			event.target.removeEventListener(MtVEvent.COMPLETE, dataLoaded);
			this.addEditions(event.parameters.editions);
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************

		/**
		 * 
		 * 
		 */
		protected function addDrawer():void {
			
			//1. Drawer
			drawer = new Sprite();
			drawer.graphics.beginFill(0x999999,.2);
			drawer.graphics.drawRect(0, 0, stage.stageWidth, maxHeight);
			drawer.graphics.lineStyle(1,0x999999);
			drawer.graphics.moveTo(0,maxHeight);
			drawer.graphics.lineTo(stage.stageWidth,maxHeight)
			drawer.graphics.endFill();
			
			drawer.height = 0;
			
			this.addChild(drawer);
			
			
			//2.load data
			//get model through controlles
			
			//--------- Load editions	
			var mtvController:MtVController = MtVController(this.getController());
			
			if (mtvController.hasEditions) {
				this.addEditions(mtvController.getEditions());
			} else {
				var m:EditionsModel = EditionsModel(MtVController(this.getController()).getModel("editions"));
				m.addEventListener(MtVEvent.COMPLETE, dataLoaded);
				mtvController.loadEditions();
			}
			
		}
		

		/**
		 * 
		 * @param data
		 * 
		 */
		protected function addEditions(data:Array):void {
			//Create Editions
			editions = new EditionsLinear(this.getController());
			this.addChild(editions);
			editions.y = 5;
			editions.init(data);
			
			//2. edition Mask
			editionsMask = new Sprite();
			editionsMask.graphics.beginFill(0x999999,.2);
			editionsMask.graphics.drawRect(0, 0, stage.stageWidth, maxHeight);
			editionsMask.graphics.endFill();
			
			editionsMask.height = 0;
			
			this.addChild(editionsMask);
			
			editions.mask = editionsMask;
			
			testForScroll();
		}
		
		/**
		 * 
		 * 
		 */
		protected function removeEditions():void {
			this.removeChild(drawer);
			this.removeChild(editions);
			this.removeChild(editionsMask);
			if (scroll) this.removeChild(scroll);
			
			drawer = null;
			editions = null;
			editionsMask = null;
			if (scroll) scroll = null;
		}
		
		/**
		 * 
		 * 
		 */
		protected function testForScroll():void {
			
			if (editions) {
			
				if (!scroll) {
					
					if (editions.width > this.stage.stageWidth) {
						
						//mask for container
						editions.mask = editionsMask;
						
						//add scroll system
						scroll = new Scroll();
						scroll.x = this.width - 7;
						scroll.alpha = .6;
						scroll.y = editions.y;
						scroll.direction = scroll.HORIZONTAL;
						scroll.target = editions;
						scroll.maskContainer = editionsMask;
						this.addChild(scroll);
						scroll.init();
					}
					
				} else {
					
					scroll.update();

				}
			}
				
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************

		/**
		 * 
		 * @param editionID
		 * 
		 */
		override public function editionOpened(editionID:int):void {
			editions.editionOpened(editionID);
		}
		
		/**
		 * 
		 * 
		 */
		override public function resize():void {
			pullHeader.x = (stage.stageWidth/2) - (pullHeader.width/2);
			if (editionsMask) editionsMask.width = stage.stageWidth;
			if (drawer) drawer.width = stage.stageWidth;
			testForScroll();
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxHeight():Number {
			return _maxHeight;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxHeight(value:Number):void {
			_maxHeight = value;
		}
		
		
	}
}