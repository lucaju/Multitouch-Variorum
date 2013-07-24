package views.readerWindow.panels.variationPanel {
	
	//imports
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import views.assets.IconBT;
	import views.assets.IconBTFactory;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class AuthorsButton extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function AuthorsButton(numAuthors:int) {
			
			//0. Text styles
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0xFFFFFF;
			style.fontFamily = "Constantia, Helvetica, Arial, _sans";
			style.fontSize = 16;
			
			//1 Icon
			var icon:IconBT = IconBTFactory.addButton("authors");
			icon.alpha = .7;
			this.addChild(icon);
			
			//2. Number of Authors
			var authorsTF:TLFTextField = new TLFTextField();
			authorsTF.autoSize = "left";
			authorsTF.selectable = false;
			authorsTF.mouseEnabled = false;
			authorsTF.wordWrap = false;
			authorsTF.multiline = false;
			
			authorsTF.x = icon.width + 5;
			authorsTF.y = 2;
			authorsTF.width = 17;
			authorsTF.height = 17;
			
			authorsTF.text = numAuthors.toString();
			
			var authorsTFlow:TextFlow = authorsTF.textFlow;
			authorsTFlow.hostFormat = style;
			authorsTFlow.flowComposer.updateAllControllers();
			
			this.addChild(authorsTF);
			
			//action
			this.mouseChildren = false;
			this.buttonMode = true;
		}
	}
}