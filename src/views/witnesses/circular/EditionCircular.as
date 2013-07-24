package views.witnesses.circular {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionCircular extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id							:int;
		
		protected var _radius						:Number					= 150;
		protected var _startPos						:Number					= 0;
		protected var _arcLength					:Number					= 30;
		protected var _gapLength					:Number					= 5;
		
		protected var _currentRotation				:Number;
		protected var _median						:Point;
		
		protected var _labelLengthLimit				:Number					= 25;
		
		protected var _selected						:Boolean;
		protected var _opened						:Boolean;
		
		protected var baseShape						:Arc;
		protected var infoShape						:Arc;
		protected var varLevel						:Arc;
		protected var shapeHighight					:Arc;
		protected var info							:EditionInfoCircular;
		
		protected var moveThreshold					:Number					 = 5;
		protected var movePos						:Point;
		
		protected var selectedHighlightColor		:uint					= 0xE5B611;
		protected var openeddHighlightColor			:uint					= 0x1B94D2;
		
		
		//****************** Contructor ****************** ****************** ******************

		/**
		 * 
		 * @param c
		 * @param id_
		 * 
		 */
		public function EditionCircular(c:IController, id_:int) {
			super(c);
			_id = id_;
		}
		
		
		//****************** Contructor ****************** ****************** ******************
	
		/**
		 * 
		 * @param startPos_
		 * @param arcLength_
		 * @param gapLength_
		 * @param abbr
		 * @param numTotalVariations
		 * 
		 */
		public function init(startPos_:Number, arcLength_:Number, gapLength_:Number, abbr:String = null, numTotalVariations:int = 0):void {
			
			//save data
			_startPos = startPos_;
			_arcLength = arcLength_
			_gapLength = gapLength_;
			
			//base shape
			baseShape = new Arc();
			baseShape.donut = true;
			baseShape.innerRadius = radius * .75;
			baseShape.steps = arcLength;
			baseShape.draw(radius,startPos,arcLength, gapLength);
			this.addChild(baseShape);
			
			var filter:GlowFilter = new GlowFilter(0x999999,0.6, 3, 3, 2);
			baseShape.filters = [filter];
			
			//save numerical values from the arc
			_currentRotation = startPos + (arcLength/2) + 180;
			_median = baseShape.median;
			
			//1. var level
			//base shape
			var varLevelMask:Arc = new Arc();
			varLevelMask.donut = true;
			varLevelMask.innerRadius = radius * .75;
			varLevelMask.steps = arcLength;
			varLevelMask.alpha = .7;
			varLevelMask.draw(radius,startPos,arcLength, gapLength);
			varLevelMask.mouseEnabled = false;
			this.addChild(varLevelMask);
			
			var varLevelH:Number = radius - numTotalVariations;
			
			varLevel = new Arc();
			varLevel.donut = true;
			varLevel.innerRadius = radius * .75;
			varLevel.steps = arcLength;
			varLevel.color = 0x000000;
			varLevel.colorAlpha = .6;
			varLevel.alpha = .7;
			varLevel.draw(varLevelH,startPos,arcLength, gapLength);
			varLevel.mouseEnabled = false;
			this.addChild(varLevel);
			
			varLevel.mask = varLevelMask;
			
			//2. abbreviation
			if (arcLength >= labelLengthLimit) {
				
				//style
				var style:TextLayoutFormat = new TextLayoutFormat();
				style.color = 0x000000;
				style.fontFamily = "Arial, Helvetica, _sans";
				style.fontSize = 11;
				style.fontWeight = "bold";
				style.textAlpha = .7;

				//text container
				var abbContainer:Sprite = new Sprite();
				this.addChild(abbContainer);
				
				//text
				var abbTF:TLFTextField = new TLFTextField();
				abbTF.autoSize = "left";
				abbTF.multiline = false;
				abbTF.wordWrap = false;
				abbTF.mouseChildren = false;
				abbTF.mouseEnabled = false;
				abbTF.width = 20;
				abbTF.height = 20;
				
				abbTF.text = abbr;
				
				var abbTFlow:TextFlow = abbTF.textFlow;
				abbTFlow.hostFormat = style;
				abbTFlow.flowComposer.updateAllControllers();
				
				abbTF.x = -abbTF.width/2;
				abbTF.y = -abbTF.height - 2;
				
				abbContainer.x = median.x;
				abbContainer.y = median.y;
				abbContainer.rotation = currentRotation;
				abbContainer.addChild(abbTF);
			}
			
			//3. Listeners
			//this.mouseChildren = false;
			baseShape.buttonMode = true;
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
			if (event.target is Arc){
				event.stopPropagation();
				this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
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
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function mouseMove(event:MouseEvent):void {
			
			if (this.mouseX > movePos.x + moveThreshold || this.mouseX < movePos.x - moveThreshold || this.mouseY > movePos.y + moveThreshold || this.mouseY < movePos.y - moveThreshold) {
				
				event.stopImmediatePropagation();
				movePos = null;
				
				this.removeEventListener(MouseEvent.CLICK, click);
				this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				
				//send info
				var globalPosition:Point = this.parent.localToGlobal(new Point(this.x, this.y));
				var obj:Object = {editionID:this.id, x:globalPosition.x, y:globalPosition.y, rotation:this.currentRotation};
				
				this.dispatchEvent(new MtVEvent(MtVEvent.SELECT, null, obj));
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
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
			

			info = new EditionInfoCircular(this);
			info.mouseChildren = false;
			info.mouseEnabled = false;
			info.x = median.x;
			info.y = median.y;
			info.rotation = startPos + (arcLength/2) + 180;
			this.addChild(info);
			
			
			if (arcLength >= 25) {
				/*
				infoShape = new Arc();
				infoShape.donut = true;
				infoShape.steps = arcLength;
				infoShape.colorAlpha = .6;
				infoShape.alpha = .7;
				infoShape.innerRadius = radius + 10;
				
				infoShape.draw(radius+info.textTF.textHeight + 10,startPos-(arcLength/2),arcLength*2, radius+10 - info.textTF.textWidth);
				infoShape.mouseEnabled = false;
				this.addChildAt(infoShape,0);
				*/
			
			}
			
			
			
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
			shapeHighight = new Arc();
			shapeHighight.mouseEnabled = false;
			shapeHighight.donut = true;
			shapeHighight.steps = arcLength;
			shapeHighight.color = color;
			shapeHighight.draw(radius,startPos,arcLength, gapLength);
			this.addChild(shapeHighight);
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
			shapeHighight.color = color;
			shapeHighight.draw(radius,startPos,arcLength, gapLength);
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function select(value:Boolean):void {
			selected = value ? true : false;
			selected ? this.addInfo() : this.removeInfo();			
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
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
		public function get radius():Number {
			return _radius;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set radius(value:Number):void {
			_radius = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get startPos():Number {
			return _startPos;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set startPos(value:Number):void {
			_startPos = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get arcLength():Number {
			return _arcLength;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set arcLength(value:Number):void {
			_arcLength = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get gapLength():Number {
			return _gapLength;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set gapLength(value:Number):void {
			_gapLength = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get currentRotation():Number {
			return _currentRotation;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get median():Point {
			return _median;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get labelLengthLimit():Number {
			return _labelLengthLimit;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set labelLengthLimit(value:Number):void {
			_labelLengthLimit = value;
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


	}
}