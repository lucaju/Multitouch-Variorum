package views.readerWindow.panels {
	
	//imports
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import events.MtVEvent;
	
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
	public class PanelHeader extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		public const MAX_HEIGHT					:Number		= 33;
		
		protected var _minWidth					:Number		= 33;
		protected var _maxWidth					:Number		= 233;
		protected var _currentWidth				:Number		= _minWidth;
		
		protected var _target					:Panel;

		protected var icon						:IconBT;
		protected var titleTF					:TLFTextField;
		protected var bottomLine				:Sprite;
		protected var numTotal					:NumTotal;
		
		protected var title						:String;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param target_
		 * 
		 */
		public function PanelHeader(target_:Panel) {
			this.name = "PanelHeader";
			target = target_;
		}
		
		
		//****************** Initalize ****************** ****************** ******************
		
		public function init(title_:String):void {
			
			title = title_;
			
			//0. Background
			this.graphics.beginFill(0xFFFFFF,0);
			this.graphics.drawRect(0,0,currentWidth, MAX_HEIGHT);
			this.graphics.endFill();
			
			//1. icon
			icon = IconBTFactory.addButton(target.contentType,"panelHeader");
			icon.w = 33;
			icon.h = 33;
			this.addChild(icon);
			
			//2. Line
			bottomLine = new Sprite();
			bottomLine.graphics.lineStyle(1,0x444444,.4,true,"none");
			bottomLine.graphics.lineTo(currentWidth,0);
			bottomLine.graphics.endFill();
			
			bottomLine.y = MAX_HEIGHT;
			bottomLine.width = currentWidth;
			
			this.addChild(bottomLine);
			
			//3. total
			numTotal = new NumTotal();
			numTotal.mouseEnabled = false;
			numTotal.mouseChildren = false;
			numTotal.x = 20;
			numTotal.y = 21;
			this.addChild(numTotal);
			numTotal.init();
			
			//4. Listeners
			icon.buttonMode = true;
			icon.addEventListener(MouseEvent.CLICK, iconClick);
			this.buttonMode = true;
		}
		
		
		//****************** PROTECTED EVENT ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function iconClick(event:MouseEvent):void {
			this.dispatchEvent(new MtVEvent(MtVEvent.SELECT));
		}	
		
		//****************** PUBLIC METHOD ****************** ****************** ******************
		
		/**
		 * 
		 * @param isExpanded
		 * @param w
		 * 
		 */
		public function expand(isExpanded:Boolean):void {
			
			var textTween:TimelineLite;
			
			if (isExpanded) {
				
				//1. Expand
				_currentWidth = this.maxWidth + 6;
				
				//2. style
				var style:TextLayoutFormat = new TextLayoutFormat();
				style.fontFamily = "Constantia, Helvetica, Arial, _sans";
				style.fontSize = 16;
				style.fontWeight = "bold";
				
				//3. text
				titleTF = new TLFTextField();
				titleTF.autoSize = "left";
				titleTF.selectable = false;
				titleTF.mouseChildren = false;
				titleTF.mouseEnabled = false;
				
				titleTF.text = title;
				
				var titleTFlow:TextFlow = titleTF.textFlow;
				titleTFlow.hostFormat = style;
				titleTFlow.flowComposer.updateAllControllers();
				
				titleTF.x = (currentWidth/2) - (titleTF.width/2);
				titleTF.y = 10;
				
				this.addChild(titleTF);
				
				TweenMax.from(titleTF,.3,{alpha:0, delay:.5});
				
				//4. move NumTotal
				textTween = new TimelineLite();
				textTween.to(numTotal,.3,{alpha:0}).to(numTotal,.3,{x:205, y:8, onComplete:numTotal.changeTextSize, onCompleteParams:[16]}).to(numTotal,.5,{alpha:1});
				
			} else {
				
				//1. Contract
				_currentWidth = this.minWidth;
				
				//2. remove Title
				this.removeChild(titleTF);
				titleTF = null;
				
				//3. move NumTotal
				textTween = new TimelineLite();
				textTween.to(numTotal,0,{alpha:0}).to(numTotal,.3,{x:20, y:21, onComplete:numTotal.changeTextSize, onCompleteParams:[10]}).to(numTotal,.5,{alpha:1});
				
			}
			
			//general
			//0. Background
			this.graphics.clear()
			this.graphics.beginFill(0xFFFFFF,0);
			this.graphics.drawRect(0,0,currentWidth, MAX_HEIGHT);
			this.graphics.endFill();
			
			//1. Bottom Line
			TweenMax.to(bottomLine,.6,{width:currentWidth});
		}
		
		
		//****************** PUBLIC METHOD ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function updateTotal(value:int):void {
			if (numTotal) numTotal.update(value);
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get target():Panel {
			return _target;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set target(value:Panel):void {
			_target = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxWidth():int {
			return _maxWidth;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxWidth(value:int):void {
			_maxWidth = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get minWidth():int {
			return _minWidth;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set minWidth(value:int):void {
			_minWidth = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get currentWidth():int {
			return _currentWidth;
		}


	}
}