package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import model.EdModel;
	import model.EditionsModel;
	import model.VarModel;
	import model.VariationsModel;
	
	import mvc.IController;
	
	import view.util.scroll.Scroll;
	
	import util.DeviceInfo;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionPanel extends AbstractPanel {
		
		//****************** Properties ****************** ****************** ******************
		protected var _maxWidth						:int	 = 800;
		
		protected var scrollBg						:Sprite;
		
		protected var edition						:Edition;
		
		protected var scrolling						:Boolean = false;
		
		protected var editionsCollection			:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function EditionPanel(c:IController) {
			super(c);
			
			super.init("Editions");
			
			//get model through controlles
			var m:EditionsModel = EditionsModel(MtVController(this.getController()).getModel("editions"));
			
			//--------- Load editions		
			MtVController(this.getController()).loadEditions();
			super.addPreloader();
			
			//add listeners
			m.addEventListener(MtVEvent.COMPLETE, _complete);
			
			container = new Sprite();
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		override protected function _added(e:Event):void {
			//define area
			if (DeviceInfo.os() != "Mac") {
				_maxWidth = (stage.stageWidth/2) - this.x - 10;
			} else {
				_maxWidth = stage.stageWidth - this.x - 10;
			}
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		override protected function _complete(e:MtVEvent):void {
			
			//remove preloader
			super.removePreloader();
			
			//get data
			var editions:Array = e.parameters.editions;
			
			//init
			editionsCollection = new Array();
			
			
			container.y = 30;
			this.addChild(container);
			
			//loop in the witnessess
			var posX:Number = 0;
			
			
			for each (var ed:EdModel in editions) {

				edition = new Edition(ed.id);
				edition.title = ed.title;
				edition.author = ed.author;
				edition.abreviation = ed.abbreviation;
				edition.date = ed.date;
				edition.init();
				
				edition.x = posX;
				container.addChild(edition);
					
				editionsCollection.push(edition);
				
				posX += edition.width + (edition.width/2);
				
				TweenMax.from(edition,1,{alpha:0, delay:Math.random() * 3});
				
				edition.addEventListener(MouseEvent.CLICK, _editionClick);
			}
			
			edition = null;
			
			testForScroll();
			
			//get variations level
			var variations:Array = MtVController(this.getController()).getVariationsByEdition();
			
			if (variations) {
				setVariationLevel(variations);
			} else {
				
				var mVariations:VariationsModel = VariationsModel(MtVController(this.getController()).getModel("variations"));
				mVariations.addEventListener(MtVEvent.COMPLETE, _variationsLoaded);
				mVariations = null;
			}	
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _editionClick(e:MouseEvent):void {
			edition = Edition(e.currentTarget);
			
			var obj:Object = {editionID:edition.id}
			
			this.dispatchEvent(new MtVEvent(MtVEvent.SELECT,obj));
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _variationsLoaded(e:MtVEvent):void {
			
			var variations:Array = MtVController(this.getController()).getVariationsByEdition();
			
			if (variations) {
				setVariationLevel(variations);
			}
			
			
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param variations
		 * 
		 */
		protected function setVariationLevel(variations:Array):void {
			
			var numVars:int;
			
			for each (var edition:Edition in editionsCollection) {
				
				numVars = 0;
				
				
				for each (var variant:VarModel in variations) {
					for each (var edID:int in variant.editions) {
						if (edition.id == edID) {
							numVars++;
						}
					}
				}
				
				edition.variationLevel = numVars;
				
			}
			
		}
		
		/**
		 * 
		 * @param contructor
		 * @param diff
		 * 
		 */
		override protected function testForScroll(contructor:Boolean = true, diff:Number = 0):void {
			
			if (container.width + diff > _maxWidth) {
				
				if (!scrolling) {
					scrolling = true;
					
					//bg
					scrollBg = new Sprite();
					scrollBg.graphics.beginFill(0xFFFFFF,0);
					scrollBg.graphics.drawRect(0,0,container.width,container.height);
					scrollBg.y = 30;
					this.addChildAt(scrollBg,0);
					
					//mask for container
					containerMask = new Sprite();
					containerMask.graphics.beginFill(0xFFFFFF,0);
					containerMask.graphics.drawRect(container.x,container.y,_maxWidth,this.height);
					this.addChild(containerMask);
					container.mask = containerMask
					//containerMask = new BlitMask(container, container.x, container.y, _maxWidth, this.height, true);
					
					//add scroll system
					scroll = new Scroll();
					scroll.x = this.width - 6;
					scroll.y = container.y;
					this.addChild(scroll);
					
					scroll.direction = scroll.HORIZONTAL;
					scroll.target = container;
					scroll.maskContainer = containerMask;
				}
				
			} else {
				
				if (scrolling) {
					scrolling = false;
					
					this.removeChild(scrollBg);
					scrollBg = null;
					
					this.removeChild(scroll);
					scroll = null;
					
					containerMask = null;
					
				}
				
			}
			
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
	
		/**
		 * 
		 * 
		 */
		override public function resize():void {
			
			_maxWidth = stage.stageWidth - this.x - 10;
			
			testForScroll();
			
			if (scrolling) {
				
				//containerMask.setSize(_maxWidth,this.height);
				scroll.maskContainer = containerMask;
				
			}
			
		}

	}
}