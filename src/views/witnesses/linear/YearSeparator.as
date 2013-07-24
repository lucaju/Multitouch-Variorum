package views.witnesses.linear {
	
	//import
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
	public class YearSeparator extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function YearSeparator(value:Number) {
			
			//1. line
			var line:Shape = new Shape();
			line.graphics.lineStyle(2,0x000000,.3);
			line.graphics.beginFill(0xFFFFFF,0);
			line.graphics.lineTo(0,112);
			line.graphics.endFill();
			
			this.addChild(line);
			
			//2. style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0x333333;
			style.fontFamily = "Helvetica, Arial, _sans";
			style.fontSize = 11;
			style.fontWeight = "bold";
			style.textAlpha = .5;
			
			//3. text
			var dateTF:TLFTextField = new TLFTextField();
			dateTF.autoSize = "left";
			dateTF.selectable = false;
			
			dateTF.text = value.toString();;
			
			var dateTFlow:TextFlow = dateTF.textFlow;
			dateTFlow.hostFormat = style;
			dateTFlow.flowComposer.updateAllControllers();
			
			dateTF.x = 4;
			dateTF.y = line.height - dateTF.height;
			
			this.addChild(dateTF);
		}
	}
}