package views.witnesses.linear {
	
	//import
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	public class EditionsHeaderLinear extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		
		
		//****************** Constructor ****************** ****************** ******************
		
		public function EditionsHeaderLinear() {
			
			//
			this.buttonMode = true;
			this.mouseChildren = false;
			
			//1. Background
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x777777);
			bg.graphics.drawRoundRectComplex(0,0,70,25,0,0,5,5);
			bg.graphics.endFill()
			this.addChild(bg);
			
			//2. style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0xFFFFFF;
			style.fontFamily = "Candara, Arial, Helvetica, _sans";
			style.fontSize = 14;
			style.fontWeight = "bold";
			
			//3. text
			var textTF:TLFTextField = new TLFTextField();
			textTF.autoSize = "left";
			textTF.selectable = false;
			
			textTF.text = "Editions";
			
			var textTFlow:TextFlow = textTF.textFlow;
			textTFlow.hostFormat = style;
			textTFlow.flowComposer.updateAllControllers();
			
			textTF.x = (bg.width/2) - (textTF.width/2);
			textTF.y = 5;
			
			this.addChild(textTF);
			
			
			//4. dashes
			var dashes:Shape = new Shape();
			dashes.graphics.lineStyle(1, 0x999999);
			dashes.graphics.beginFill(0xFFFFFF);
			dashes.graphics.lineTo(30,0);
			dashes.graphics.moveTo(5,2);
			dashes.graphics.lineTo(25,2);
			dashes.graphics.endFill();
			
			dashes.x = (bg.width/2) - (dashes.width/2);
			dashes.y = bg.height - 6;
			
			this.addChild(dashes);

		}
	}
}