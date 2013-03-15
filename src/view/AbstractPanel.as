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
	
	public class AbstractPanel extends AbstractView {
		
		//properties
		protected var preloader:Preloader;
		protected var window:Shape;
		
		protected var scrollable:Boolean = false;
		
		private var container:Sprite;
		private var containerMask:BlitMask;
		
		private var scroll:Scroll;
		
		
		
		public function AbstractPanel(c:IController) {
			super(c);
			
			//listeners
			this.addEventListener(Event.ADDED_TO_STAGE, _added);
		}
		
		public function init(panelNamel:String):void {
			
			//---------- Area Title ----------
			var title:TextField = new TextField();
			title.selectable = false;
			title.autoSize = "left";
			title.text = panelNamel;
			title.setTextFormat(TXTFormat.getStyle("Panel Title"));
			
			addChild(title);
	
		}
		
		protected function _added(e:Event):void {
			
		}
		
		protected function showWindow():void {
			//border
			window = new Shape();
			window.graphics.lineStyle(2,0xCCCCCC,1,true);
			window.graphics.beginFill(0xFFFFFF,1);
			window.graphics.drawRect(0,0,this.width, this.height);
			window.graphics.endFill();
			
			this.addChildAt(window,0);
		}
		
		protected function hideWindow():void {
			window.graphics.clear();
			this.removeChild(window);
			window = null;
		}
		
		protected function _complete(e:MtVEvent):void {
			
		}
		
		public function setDimensions(valueW:Number, valueH:Number):void {
			
		}
		
		protected function testForScroll(contructor:Boolean = true, diff:Number = 0):void {
			
		}
		
		public function resize():void {
			
		}
		
		internal function addPreloader():void {
			preloader = new Preloader();
			preloader.start();
			preloader.x = 30;
			preloader.y = 50;
			this.addChild(preloader);
		}
		
		internal function removePreloader():void {
			if (preloader) {
				this.removeChild(preloader);
				preloader = null;
			}
		}
	}
}