package views.readerWindow {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import events.MtVEvent;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import models.edition.EditionModel;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderHeader extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		public const maxHeight					:Number = 24;
		
		protected var target					:ReaderWindow;
		
		protected var lockButton				:Sprite;
		protected var expandButton				:Sprite;
		
		protected var line						:Sprite;
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ReaderHeader(_target:ReaderWindow) {
			target = _target;
		}
		
		
		//****************** Initialize ****************** ****************** ******************
		
		/**
		 * 
		 * @param edition
		 * 
		 */
		public function initialize(edition:EditionModel = null):void {
			
			//0. Background
			this.graphics.beginFill(0xFFFFFF,0);
			this.graphics.drawRect(0,0,target.currentWidth, this.maxHeight);
			this.graphics.endFill();
			
			//1. set data
			var abb:String = "MLA";
			var author:String = "The Comedy of Errors The Comedy of Errors";
			var year:Number = 2012;
			
			if (edition) {
				abb = target.getAbbreviation;
				author = target.getAuthor;
				year = target.getYear;
			}
			
			//2. style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.fontFamily = "Helvetica, Arial, _sans";
			style.fontSize = 16;
			style.fontWeight = "bold";
			
			//3. Abbreviation
			var abbreviationTF:TLFTextField = new TLFTextField();
			abbreviationTF.autoSize = "left";
			abbreviationTF.selectable = false;
			
			abbreviationTF.text = abb;
			
			var abbTFlow:TextFlow = abbreviationTF.textFlow;
			abbTFlow.hostFormat = style;
			abbTFlow.flowComposer.updateAllControllers();
			
			abbreviationTF.x = 40;
			abbreviationTF.y = (maxHeight/2) - (abbreviationTF.height/2);
			
			this.addChild(abbreviationTF);
			
			//4. Author
			var styleAuthor:TextLayoutFormat = new TextLayoutFormat();
			styleAuthor.fontFamily = "Helvetica, Arial, _sans";
			styleAuthor.fontSize = 16;
			styleAuthor.fontWeight = "bold";
			styleAuthor.textAlign = "center";
			
			var authorTF:TLFTextField = new TLFTextField();
			//authorTF.autoSize = "left";
			authorTF.wordWrap = false;
			authorTF.multiline = false;
			authorTF.height = 17 //this.maxHeight;
			authorTF.width = target.currentWidth * .6; // 60% of header's width 
			authorTF.selectable = false;
			
			authorTF.text = author;
			
			var authorTFlow:TextFlow = authorTF.textFlow;
			authorTFlow.hostFormat = styleAuthor;
			authorTFlow.flowComposer.updateAllControllers();
			
			//authorTF.x = target.currentWidth/2 - authorTF.width/2;
			//authorTF.y = (maxHeight/2) - (authorTF.height/2);
			
			authorTF.x = abbreviationTF.x + abbreviationTF.width + 10;
			authorTF.y = abbreviationTF.y;
			
			
			this.addChild(authorTF);
			
			//5. Year
			var yearTF:TLFTextField = new TLFTextField();
			yearTF.autoSize = "left";
			yearTF.selectable = false;
			
			yearTF.text = year.toString();
			
			var yearTFlow:TextFlow = yearTF.textFlow;
			yearTFlow.hostFormat = style;
			yearTFlow.flowComposer.updateAllControllers();
			
			yearTF.x = target.currentWidth - 35 - yearTF.width;
			yearTF.y = (maxHeight/2) - (yearTF.height/2);
			
			this.addChild(yearTF);
			
			//6. lock button
			lockButton = new Sprite();
			lockButton.graphics.beginFill(0x444444,0);
			lockButton.graphics.drawRoundRect(0,0,20,20,4);
			lockButton.graphics.endFill();
			
			lockButton.x = 7;
			lockButton.y = 2;
			
			this.addChild(lockButton);
			
			this.lock(false);
			
			//7. Expand button
			expandButton = new Sprite();
			expandButton.name = "expand";
			expandButton.graphics.beginFill(0x444444,0);
			expandButton.graphics.drawRoundRect(0,0,20,20,4);
			expandButton.graphics.endFill();
			
			expandButton.x = target.currentWidth - 25;
			expandButton.y = 2;
			
			expandButton.buttonMode = true;
			expandButton.addEventListener(MouseEvent.CLICK, expandButtonClick);
			
			this.addChild(expandButton);
			
			this.changeExpandButton(false);
			
			
			//8. line
			line = new Sprite();
			line.graphics.lineStyle(1,0x6D6E70,1,true,"none");
			line.graphics.beginFill(0x000000,0);
			line.graphics.lineTo(target.currentWidth,0)
			line.graphics.endFill();
			
			line.y = maxHeight;
			
			this.addChild(line);
			
			//9.clean
			abb = null;
			author = null;
			year = 0;
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function expandButtonClick(event:MouseEvent):void {
			this.dispatchEvent(new MtVEvent(MtVEvent.SELECT));
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param isExpanded
		 * 
		 */
		protected function changeExpandButton(isExpanded:Boolean):void {
			
			if (expandButton.numChildren >= 1) {
				expandButton.removeChildAt(0);
			}
			
			var icon:Shape = new Shape();
			
			icon.graphics.lineStyle(2,0x444444);
			
			if (isExpanded) {
				icon.graphics.moveTo(8,0);
				icon.graphics.lineTo(0,5);
				icon.graphics.lineTo(8,10);
			} else {
				icon.graphics.lineTo(8,5);
				icon.graphics.lineTo(0,10);
			}
			
			icon.x = 6;
			icon.y = 5;
			
			icon.graphics.endFill();
			
			expandButton.addChild(icon);
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param param0
		 * 
		 */
		public function lock(isLock:Boolean):void {
			
			if (lockButton.numChildren > 1) {
				lockButton.removeChildAt(0);
			}
			
			var icon:Shape = new Shape();
			
			if (isLock) {
				icon.graphics.beginFill(0x444444);
				icon.graphics.drawCircle(10,10,5);
				icon.graphics.endFill();
			} else {
				icon.graphics.lineStyle(2,0x444444);
				icon.graphics.drawCircle(10,10,5);
				icon.graphics.endFill();
			}
			
			lockButton.addChild(icon);
			
		}
		
		public function expand(isExpanded:Boolean):void {
			
			//Change Expand Button
			this.changeExpandButton(isExpanded);
			
			//animation
			TweenMax.to(line,.6,{width:target.currentWidth});
			TweenMax.to(expandButton,.6,{x:target.currentWidth - 25});
			
		}


	}
}