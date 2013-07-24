package views.readerWindow.panels.variationPanel {
	
	//imports
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class AuthorsBox extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var authorsTF							:TLFTextField;
		protected var bg								:Shape;
		
		//****************** Constructor ****************** ****************** ******************

		/**
		 * 
		 * 
		 */
		public function AuthorsBox(maxWidth:Number) {
			
			var gap:Number = 20
			
			//1. Text styles
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0xFFFFFF;
			style.fontFamily = "Constantia, Helvetica, Arial, _sans";
			style.fontSize = 12;
			
			//2. sep Line
			var sepLine:Shape = new Shape();
			sepLine.graphics.lineStyle(1,0xFFFFFF,.5);
			sepLine.graphics.beginFill(0x000000,1);
			sepLine.graphics.lineTo(195,0);
			sepLine.graphics.endFill();
			
			this.addChild(sepLine);
			
			//3. Authors Text
			authorsTF = new TLFTextField();
			authorsTF.autoSize = "left";
			authorsTF.selectable = false;
			authorsTF.mouseEnabled = false;
			authorsTF.wordWrap = true;
			authorsTF.multiline = true;
			
			authorsTF.y = 5;
			authorsTF.width = maxWidth;
			authorsTF.height = gap;
			
			var authorsTFlow:TextFlow = authorsTF.textFlow;
			authorsTFlow.hostFormat = style;
			authorsTFlow.flowComposer.updateAllControllers();
			
			this.addChild(authorsTF);
			
		}
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function setAuthors(data:Array):void {
			if (authorsTF) authorsTF.text = data.join("\n");
			
			bg = new Shape();
			bg.graphics.beginFill(0xFFFFFF,0);
			bg.graphics.drawRect(0,0,authorsTF.width,this.height + 5);
			bg.graphics.endFill();
			
			this.addChild(bg);
		}


	}
}