package views.readerWindow.panels.variationPanel {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import views.assets.IconBT;
	import views.assets.IconBTFactory;
	import views.readerWindow.panels.PanelEvent;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Variation extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _target					:Variable;
		
		protected var _id						:int;
		protected var _uid						:int;
		
		protected var gapV						:int = 10;
		protected var _authorsVisible			:Boolean = false;
		protected var _selected					:Boolean = false;
		
		protected var background				:Sprite;
		protected var variationTF				:TLFTextField;
		protected var authorsBox				:AuthorsBox;
		protected var checkmark					:IconBT;
		protected var authorsBT					:AuthorsButton;
		
		
		//****************** Constructor ****************** ****************** ******************

		
		/**
		 * 
		 * 
		 */
		public function Variation(target_:Variable, id_:int, uid_:int) {
			//------init
			_id = id_;
			_target = target_;
			_uid = uid_;
		}
		
		
		//****************** Initialize ****************** ****************** ******************
		
		public function init(variantText:String = "", typeVariation:String = "", numEditions:int = 0):void {
			
			var gap:int = 5;
			
			//1. Text styles
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0xFFFFFF;
			style.fontFamily = "Constantia, Helvetica, Arial, _sans";
			style.fontSize = 16;
			
			//2. color type
			var colors:Array = new Array();
			colors["insert"] = 0x18864B;	//green
			colors["replace"] = 0x1B94D2;	//blue
			colors["remove"] = 0xB52025;	//red
			
			
			//3. Authors Button
			authorsBT = new AuthorsButton(numEditions);
			authorsBT.name = "AuthorsBT";
			authorsBT.x = target.usableWidth - authorsBT.width - gap;
			authorsBT.y = 1;
			this.addChild(authorsBT);
			
			//4. Variation Text
			variationTF = new TLFTextField();
			variationTF.autoSize = "left";
			variationTF.selectable = false;
			variationTF.mouseEnabled = false;
			variationTF.mouseChildren = false;
			variationTF.wordWrap = true;
			variationTF.multiline = true;
			variationTF.width = target.usableWidth - authorsBT.width - gap ;
			
			//correct display
			var variantString:String = variantText;
			if (variantString == "") variantString = " ";
			
			variationTF.htmlText = variantString;
			
			var variationTFlow:TextFlow = variationTF.textFlow;
			variationTFlow.hostFormat = style;
			variationTFlow.flowComposer.updateAllControllers();
			
			variationTF.x = gap;
			variationTF.y = gap;
			
			this.addChild(variationTF);
			
			//5. Background
			background = new Sprite();
			background.mouseEnabled = false;
			
			background.graphics.beginFill(colors[typeVariation],.5);
			background.graphics.drawRect(0,0,target.usableWidth,variationTF.height + gapV);
			background.graphics.endFill();
			
			this.addChildAt(background,0);
			
			//6. listeners
			this.buttonMode = true;
			authorsBT.addEventListener(MouseEvent.CLICK, displayAuthors);
		}
		
		
		//****************** PROTECTED EVENT ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function displayAuthors(event:MouseEvent):void {
			
			authorsVisible = !authorsVisible;
			
			if (authorsVisible) {	//add authors
				
				authorsBox = new AuthorsBox(target.usableWidth);
				authorsBox.x = variationTF.x;
				authorsBox.y = variationTF.height + gapV;
				this.addChild(authorsBox);
				
				this.dispatchEvent(new PanelEvent(PanelEvent.CELL_EXPANDED,"expanding", this.id));
				
				TweenMax.to(background,.5,{height:this.height});
				
			} else {				//remove authors
				
				this.removeChild(authorsBox)
				authorsBox = null;
				
				var currentHeight:Number = this.height;
				background.height = variationTF.height + gapV;
				
				this.dispatchEvent(new PanelEvent(PanelEvent.CELL_EXPANDED,"contracting", this.id));
				
				TweenMax.from(background,.5,{height:currentHeight});
			}		
			
		}
		
		
		//****************** PROTECED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		protected function addCheckmark(value:Boolean):void {
			if (value) {
				checkmark = IconBTFactory.addButton("checkmark");
				checkmark.x = -25;
				checkmark.y = authorsBT.y + 2;
				checkmark.alpha = .7;
				this.addChild(checkmark);
			} else {
				this.removeChild(checkmark);
				checkmark = null;
			}
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function setAuthors(data:Array):void {
			if (authorsBox) authorsBox.setAuthors(data)
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function select(value:Boolean):void {
			
			if (_selected != value) {
			
				_selected = value;
				
				if (value) {
					TweenMax.to(background,.5,{x:-30, width:target.maxWidth});
				} else {
					TweenMax.to(background,.5,{x:0, width:target.usableWidth});
				}
				
				this.addCheckmark(value);
			}
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get id():int {
			return _id;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get uid():int {
			return _uid;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get target():Variable {
			return _target;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set target(value:Variable):void {
			_target = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get variant():String {
			return target.getVariationText(this.id);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get type():String {
			return target.getVariationType(this.id);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get edition():Array {
			return target.getVariationEditions(this.id);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get selected():Boolean {
			return _selected;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get authorsVisible():Boolean {
			return _authorsVisible;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set authorsVisible(value:Boolean):void {
			_authorsVisible = value;
		}

		
	}
}