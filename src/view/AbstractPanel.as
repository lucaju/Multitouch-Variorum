package view {
	
	//imports
	import com.greensock.BlitMask;
	
	import events.MtVEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	import view.style.TXTFormat;
	import view.util.preloader.Preloader;
	import view.util.scroll.Scroll;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class AbstractPanel extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var preloader						:Preloader;
		protected var window						:Shape;
		
		protected var scrollable					:Boolean = false;
		
		protected var container						:Sprite;
		protected var containerMask					:Sprite;
		
		protected var scroll						:Scroll;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function AbstractPanel(c:IController) {
			super(c);
			
			//listeners
			this.addEventListener(Event.ADDED_TO_STAGE, _added);
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * @param panelNamel
		 * 
		 */
		public function init(panelNamel:String):void {
			
			//---------- Area Title ----------
			var title:TextField = new TextField();
			title.selectable = false;
			title.autoSize = "left";
			title.text = panelNamel;
			title.setTextFormat(TXTFormat.getStyle("Panel Title"));
			
			addChild(title);
	
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _added(e:Event):void {
			//to override
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _complete(e:MtVEvent):void {
			//to override
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		protected function showWindow():void {
			//border
			window = new Shape();
			window.graphics.lineStyle(2,0xCCCCCC,1,true);
			window.graphics.beginFill(0xFFFFFF,1);
			window.graphics.drawRect(0,0,this.width, this.height);
			window.graphics.endFill();
			
			this.addChildAt(window,0);
		}
		
		/**
		 * 
		 * 
		 */
		protected function hideWindow():void {
			window.graphics.clear();
			this.removeChild(window);
			window = null;
		}
		
		/**
		 * 
		 * @param valueW
		 * @param valueH
		 * 
		 */
		public function setDimensions(valueW:Number, valueH:Number):void {
			//to override
		}
		
		/**
		 * 
		 * @param contructor
		 * @param diff
		 * 
		 */
		protected function testForScroll(contructor:Boolean = true, diff:Number = 0):void {
			//to override
		}
		
		/**
		 * 
		 * 
		 */
		public function resize():void {
			//to override
		}
		
		
		//****************** INTERNAL METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		internal function addPreloader():void {
			preloader = new Preloader();
			preloader.start();
			preloader.x = 30;
			preloader.y = 50;
			this.addChild(preloader);
		}
		
		/**
		 * 
		 * 
		 */
		internal function removePreloader():void {
			if (preloader) {
				this.removeChild(preloader);
				preloader = null;
			}
		}
	}
}