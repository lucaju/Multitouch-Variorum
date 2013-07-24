package views.readerWindow.panels {
	
	//imports
	import flash.display.Sprite;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class NumTotal extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var bg					:Sprite;
		protected var textTF				:TLFTextField;
		protected var style					:TextLayoutFormat;
		protected var textTFlow				:TextFlow;
		
		//****************** Constructor ****************** ****************** ******************

		
		
		/**
		 * 
		 * 
		 */
		public function NumTotal() {
			
			//Style
			style = new TextLayoutFormat();
			style.fontFamily = "Constantia, Helvetica, Arial, _sans";
			style.fontSize = 10;
			
		}
		
		
		//****************** Initialize ****************** ****************** ******************
		
		public function init():void {
			
			//Create text Field
			textTF = new TLFTextField(); 
			textTF.autoSize = "left";
			textTF.selectable = false;
			textTF.antiAliasType = "advanced";
			
			textTF.text = " ";
			
			textTFlow = textTF.textFlow;
			textTFlow.hostFormat = style;
			textTFlow.flowComposer.updateAllControllers();
			
			this.addChild(textTF);

		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function update(value:int):void {
			textTF.text = value.toString();
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function changeTextSize(value:int):void {
			style.fontSize = value;
			textTFlow = textTF.textFlow;
			textTFlow.hostFormat = style;
			textTFlow.flowComposer.updateAllControllers();
		}
		
	}
}