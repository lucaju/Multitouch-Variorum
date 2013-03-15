package view {
	
	//imports
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import mvc.IController;
	
	import view.AbstractPanel;
	import view.style.TXTFormat;
	
	final public class Header extends AbstractPanel {
		
		//properties
		private var bg:Shape;
		
		public function Header(c:IController) {
			super(c);
			
			//super.init("TopBar");
		}
		
		public function initialize():void {
			
			//---------- Background ----------
			bg = new Shape();
			bg.graphics.beginFill(0x333333);
			bg.graphics.drawRect(0,0,stage.stageWidth, 40);
			bg.graphics.endFill();
			addChild(bg);
			
			
			//---------- Document Title ----------
			
			var title:TextField = new TextField();
			title.selectable = false;
			title.autoSize = "left";
			title.text = "Comedy of Errors - Shakespeare Variorum Edition";
			title.setTextFormat(TXTFormat.getStyle("Header Title"));
			
			title.x = 20;
			title.y = 5;
			title.alpha = .8;
			
			addChild(title);
		}
		
		override public function resize():void {
			bg.width = stage.stageWidth;
		}
	}
}