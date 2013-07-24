package views.witnesses.circular {
	
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
	public class EditionInfoCircular extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var target			:EditionCircular;
		protected var bg				:Shape;
		protected var line				:Shape;
		protected var _textTF			:TLFTextField;
		
		//****************** Constructor ****************** ****************** ******************

		/**
		 * 
		 * @param _target
		 * 
		 */
		public function EditionInfoCircular(_target:EditionCircular) {
			
			target = _target
			
			//1. style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0x333333;
			style.fontFamily = "Arial, Helvetica, _sans";
			style.fontSize = 11;
			style.lineHeight = 14;
			style.trackingLeft = .6;
			style.paddingTop = 5;
			style.paddingBottom = 5;
			style.paddingLeft = 5;
			style.paddingRight = 5;
			
			var labelStyle:TextLayoutFormat = new TextLayoutFormat();
			labelStyle.copy(style);
			labelStyle.fontWeight = "bold";
			
			//2. text
			textTF = new TLFTextField();
			textTF.autoSize = "left";
			textTF.wordWrap = true;
			textTF.multiline = true;
			textTF.width = 170;
			
			var paragraph:ParagraphElement = new ParagraphElement();
			
			var labelTitle:SpanElement = new SpanElement;
			labelTitle.text = "Title: ";
			labelTitle.format = labelStyle;
			paragraph.addChild(labelTitle);
			
			var titlteText:SpanElement = new SpanElement;
			titlteText.text = target.getTitle + "\n";
			paragraph.addChild(titlteText);
			
			var yearlLabel:SpanElement = new SpanElement;
			yearlLabel.text = "Year: ";
			yearlLabel.format = labelStyle;
			paragraph.addChild(yearlLabel);
			
			var yearText:SpanElement = new SpanElement;
			yearText.text = target.getYear.toString() + "\n";
			paragraph.addChild(yearText);
			
			var authorLabel:SpanElement = new SpanElement;
			authorLabel.text = "Author: ";
			authorLabel.format = labelStyle;
			paragraph.addChild(authorLabel);
			
			var authorText:SpanElement = new SpanElement;
			authorText.text = target.getAuthor;
			if (target.arcLength <= target.labelLengthLimit) authorText.text += " (" + target.getAbbreviation + ")";
			authorText.text += "\n";
			
			
			paragraph.addChild(authorText);
			
			var variationsLabel:SpanElement = new SpanElement;
			variationsLabel.text = "Variations: ";
			variationsLabel.format = labelStyle;
			paragraph.addChild(variationsLabel);
			
			var variationText:SpanElement = new SpanElement;
			variationText.text = target.getNumVariations.toString() ;
			paragraph.addChild(variationText);
			

			var textTFlow:TextFlow = textTF.textFlow;
			textTFlow.hostFormat = style;
			textTFlow.addChild(paragraph);
			textTFlow.flowComposer.updateAllControllers();
			
			textTF.x = -textTF.textWidth/2;
			//textTF.y = 5;
			
			
			this.addChild(textTF);
			
			//3. line
			line = new Shape();
			line.graphics.lineStyle(1,0x333333,.5);
			line.graphics.beginFill(0xFFFFFF,.7);
			line.graphics.lineTo(0,10);
			line.graphics.moveTo(textTF.x,10);
			line.graphics.lineTo(textTF.textWidth/2,10);
			line.graphics.endFill();
			this.addChild(line);
			
			/*
			bg = new Shape();
			bg.x = textTF.x;
			bg.y = 10;
			bg.graphics.beginFill(0xFFFFFF,.7);
			bg.graphics.drawRect(0,0,textTF.textWidth,textTF.textHeight-10);
			bg.graphics.endFill();
			this.addChildAt(bg,0);
			*/
			
			//animation
			TweenMax.from(line,.5,{y:line.y-10,alpha:0});
			TweenMax.from(textTF,.5,{y:textTF.y-10, alpha:0});
			if (bg) TweenMax.from(bg,.5,{y:bg.y-10,alpha:0});
			
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
			TweenMax.to(line,.5,{y:line.y-10, alpha:0, onComplete:removeObj});
			TweenMax.to(textTF,.5,{y:textTF.y-10, alpha:0});
			if (bg) TweenMax.from(bg,.5,{y:bg.y-10, alpha:0});
		}

		public function get textTF():TLFTextField
		{
			return _textTF;
		}

		public function set textTF(value:TLFTextField):void
		{
			_textTF = value;
		}

	}
}