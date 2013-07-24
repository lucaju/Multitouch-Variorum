package views.witnesses.circular {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
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
	public class EditionsMenuCircular extends AbstractEditionsMenu {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _maxRadius				:Number = 150;
		
		protected var _header					:EditionsHeaderCircular
		protected var editions					:EditionsCircular;
		
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
		public function EditionsMenuCircular(c:IController) {
			super(c);
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		override public function init():void {
			
			//1. Header
			_header = new EditionsHeaderCircular(maxRadius/3);
			_header.mouseChildren = false;
			//position
			this.x = stage.width/2;
			this.y = stage.height/2;
			
			this.addChild(_header);
			
			//listeners
			_header.addEventListener(MouseEvent.CLICK, headerClick);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function headerClick(event:MouseEvent):void {
			expanded = !expanded;
			expanded ? this.getData() : this.removeEditions();
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
		protected function getData():void {
			
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
			editions = new EditionsCircular(this);
			editions.maxRadius = maxRadius;
			this.addChildAt(editions,0);
			
			editions.init(data);
			
			header.animation(false);

		}
		
		/**
		 * 
		 * 
		 */
		protected function removeEditions():void {
			TweenMax.to(editions,1,{scaleX:0.2, scaleY:0.2, alpha:0, ease:Circ.easeOut, onComplete:removeObj, onCompleteParams:[editions]});
			editions = null;
			
			header.animation(true);
		}
		
		
		//****************** PRIVATE METHODS ****************** ****************** ******************
		
		private function removeObj(value:DisplayObject):void {
			this.removeChild(value);
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
			
			this.z
			
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;
		
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxRadius():Number {
			return _maxRadius;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxRadius(value:Number):void {
			_maxRadius = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get header():EditionsHeaderCircular {
			return _header;
		}
		
		
	}
}