package views.witnesses.linear {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	public class EditionLinear extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		public const MIN_WIDTH					:Number = 30;
		public const MAX_WIDTH					:Number = 180;
		
		public const MAX_HEIGHT					:Number = 100;
		
		protected var _id						:int;
		
		protected var _selected					:Boolean;
		protected var _opened					:Boolean;
		
		protected var baseShape					:Sprite;
		protected var varLevel					:Sprite;
		protected var shapeHighight				:Sprite;
		
		protected var info						:EditionInfoLinear;
		
		protected var moveThreshold				:Number = 5;
		protected var movePos					:Point;
		
		protected var selectedHighlightColor	:uint	= 0xE5B611;
		protected var openeddHighlightColor		:uint	= 0x1B94D2;
		
		
		//****************** Contructor ****************** ****************** ******************

		/**
		 * 
		 * @param id_
		 * 
		 */
		public function EditionLinear(c:IController, id_:int) {
			super(c);
			
			//------init
			_id = id_;
			
			//----- basic shape
			baseShape = new Sprite();
			baseShape.graphics.beginFill(0xFFFFFF,.5);
			baseShape.graphics.drawRect(0,0,MIN_WIDTH, MAX_HEIGHT);
			baseShape.graphics.endFill();
			this.addChild(baseShape);
			
		}
		
		
		//****************** Contructor ****************** ****************** ******************
	
		/**
		 * 
		 * 
		 */
		public function init(abbr:String = null, numTotalVariations:int = 0):void {
			
			//1. var level
			var varLevelH:Number = MAX_HEIGHT - numTotalVariations;
			
			varLevel = new Sprite();
			varLevel.graphics.beginFill(0x000000,.8);
			varLevel.graphics.drawRect(0,0,MIN_WIDTH, varLevelH);
			varLevel.graphics.endFill();
			varLevel.alpha = .7;
			varLevel.y = numTotalVariations;
			
			this.addChild(varLevel);
			
			
			//2. abbreviation
			
			//style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0xFFFFFF;
			style.fontFamily = "Arial, Helvetica, _sans";
			style.fontSize = 14;
			style.fontWeight = "bold";
			style.textAlpha = .7;
			style.trackingLeft = 1.3; 
			
			//text
			var abbTF:TLFTextField = new TLFTextField();
			abbTF.autoSize = "left";
			
			abbTF.text = abbr;
			
			var abbTFlow:TextFlow = abbTF.textFlow;
			abbTFlow.hostFormat = style;
			abbTFlow.flowComposer.updateAllControllers();
			
			abbTF.rotation = -90;
			abbTF.x = (this.MIN_WIDTH/2) - (abbTF.width/2);
			abbTF.y = this.MAX_HEIGHT - 5;
			
			this.addChild(abbTF);
			
			//3. Listeners
			this.mouseChildren = false;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, click);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
		}
		
			
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function click(event:MouseEvent):void {
			
			selected = !selected;
			
			if (selected) {
				addInfo();
			} else {
				removeInfo();
			}
			
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function mouseDown(event:MouseEvent):void {
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			movePos = new Point(this.mouseX, this.mouseY);
		}	
		
		
		
		protected function mouseMove(event:MouseEvent):void {
			if (this.mouseX > movePos.x + moveThreshold || this.mouseX < movePos.x - moveThreshold || this.mouseY > movePos.y + moveThreshold || this.mouseY < movePos.y - moveThreshold) {
				
				event.stopImmediatePropagation();
				movePos = null;
				
				this.removeEventListener(MouseEvent.CLICK, click);
				this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				
				//send info
				var globalPosition:Point = this.parent.localToGlobal(new Point(this.x, this.y));
				var obj:Object = {editionID:this.id, x:globalPosition.x, y:globalPosition.y};
				this.dispatchEvent(new MtVEvent(MtVEvent.SELECT, null, obj));
			}
		}
		
		protected function mouseUp(event:MouseEvent):void {
			movePos = null;
			
			this.addEventListener(MouseEvent.CLICK, click);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		protected function addInfo():void {
			info = new EditionInfoLinear(this);
			info.x = MIN_WIDTH;
			this.addChild(info);
			
			if (!shapeHighight) {
				addShapeHighight(selectedHighlightColor);
			} else {
				changeShapeHighight(selectedHighlightColor);
			}
			
			TweenMax.from(shapeHighight,.5,{alpha:0});
		}
		
		/**
		 * 
		 * 
		 */
		protected function removeInfo():void {
			info.killInfo();
			info = null;
			
			if (opened) {
				changeShapeHighight(openeddHighlightColor);
			} else {
				TweenMax.to(shapeHighight,.5,{alpha:0, onComplete:removeObj, onCompleteParams:[shapeHighight]});
			}
			
			shapeHighight = null;
		}
		
		/**
		 * 
		 * @param obj
		 * 
		 */
		protected function removeObj(obj:Sprite):void {
			this.removeChild(obj);
			obj = null;
		}
		
		/**
		 * 
		 * @param color
		 * 
		 */
		protected function addShapeHighight(color:uint):void {
			shapeHighight = new Sprite();
			shapeHighight.graphics.beginFill(color);
			shapeHighight.graphics.drawRect(0,0,MIN_WIDTH, MAX_HEIGHT);
			shapeHighight.graphics.endFill();
			shapeHighight.blendMode = "hardlight"
			this.addChild(shapeHighight);
		}
		
		/**
		 * 
		 * @param color
		 * 
		 */
		protected function changeShapeHighight(color:uint):void {
			shapeHighight.graphics.clear();
			shapeHighight.graphics.beginFill(color);
			shapeHighight.graphics.drawRect(0,0,MIN_WIDTH, MAX_HEIGHT);
			shapeHighight.graphics.endFill();
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		public function open(value:Boolean):void {
			this.opened = value;
			
			if (opened) {
				if (!shapeHighight) addShapeHighight(openeddHighlightColor);
			} else{
				TweenMax.to(shapeHighight,.5,{alpha:0, onComplete:removeObj, onCompleteParams:[shapeHighight]});
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
		public function get getAbbreviation():String {
			return MtVController(this.getController()).getEditionInfo(this.id, "abbreviation");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getAuthor():String {
			return MtVController(this.getController()).getEditionInfo(this.id, "author");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getTitle():String {
			return MtVController(this.getController()).getEditionInfo(this.id, "title");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getYear():Number {
			return MtVController(this.getController()).getEditionInfo(this.id, "year");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getNumVariations():Number {
			return MtVController(this.getController()).getEditionInfo(this.id, "numVariations");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get currentWidth():Number {
			return !selected ? MIN_WIDTH : MAX_WIDTH;
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
		 * @param value
		 * 
		 */
		public function set selected(value:Boolean):void {
			_selected = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get opened():Boolean {
			return _opened;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set opened(value:Boolean):void {
			_opened = value;
		}


	}
}