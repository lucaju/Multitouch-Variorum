package views.witnesses.linear {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionInfoLinear extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var target			:EditionLinear;
		protected var bg				:Shape;
		protected var textTF			:TLFTextField;
		
		//****************** Constructor ****************** ****************** ******************

		/**
		 * 
		 * @param _target
		 * 
		 */
		public function EditionInfoLinear(_target:EditionLinear) {
			
			target = _target
			
			//1. bg
			bg = new Shape();
			bg.graphics.beginFill(0xFFFFFF,.7);
			bg.graphics.drawRect(0,0,target.MAX_WIDTH-target.MIN_WIDTH, target.MAX_HEIGHT);
			bg.graphics.endFill();
			this.addChild(bg);
			
			//2. style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0x333333;
			style.fontFamily = "Arial, Helvetica, _sans";
			style.fontSize = 11;
			
			var labelStyle:TextLayoutFormat = new TextLayoutFormat();
			labelStyle.copy(style);
			labelStyle.fontWeight = "bold";
			
			//3. text
			textTF = new TLFTextField();
			textTF.autoSize = "left";
			textTF.wordWrap = true;
			textTF.multiline = true;
			
			var paragraph:ParagraphElement = new ParagraphElement();
			
			var labelTitle:SpanElement = new SpanElement;
			labelTitle.text = "Title: ";
			labelTitle.format = labelStyle;
			
			var titlteText:SpanElement = new SpanElement;
			titlteText.text = target.getTitle + "\n";
			
			var yearlLabel:SpanElement = new SpanElement;
			yearlLabel.text = "Year: ";
			yearlLabel.format = labelStyle;
			
			var yearText:SpanElement = new SpanElement;
			yearText.text = target.getYear.toString() + "\n";
			
			var authorLabel:SpanElement = new SpanElement;
			authorLabel.text = "Author: ";
			authorLabel.format = labelStyle;
			
			var authorText:SpanElement = new SpanElement;
			authorText.text = target.getAuthor + "\n";
			
			var variationsLabel:SpanElement = new SpanElement;
			variationsLabel.text = "Variations: ";
			variationsLabel.format = labelStyle;
			
			var variationText:SpanElement = new SpanElement;
			variationText.text = target.getNumVariations.toString();
			
			paragraph.addChild(labelTitle);
			paragraph.addChild(titlteText);
			paragraph.addChild(yearlLabel);
			paragraph.addChild(yearText);
			paragraph.addChild(authorLabel);
			paragraph.addChild(authorText);
			paragraph.addChild(variationsLabel);
			paragraph.addChild(variationText);
			
			var textTFlow:TextFlow = textTF.textFlow;
			textTFlow.hostFormat = style;
			textTFlow.addChild(paragraph);
			textTFlow.flowComposer.updateAllControllers();
			
			textTF.x = 5;
			textTF.y = -5;
			textTF.width = bg.width - 10;
			
			this.addChild(textTF);
			
			
			//animation
			TweenMax.from(bg,.5,{width:0});
			TweenMax.from(textTF,.4,{alpha:0, delay:.3});
			
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function removeObj():void {
			target.removeChild(this);
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function killInfo():void {
			TweenMax.to(bg,.5,{width:0, onComplete:removeObj});
			TweenMax.to(textTF,.4,{alpha:0});
		}
	}
}