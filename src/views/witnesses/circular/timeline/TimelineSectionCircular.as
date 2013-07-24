package views.witnesses.circular.timeline {
	
	//imports
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import views.witnesses.circular.Arc;
	
	public class TimelineSectionCircular extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _radius						:Number					= 150;
		
		protected var _thickness					:Number = 10;
		
		protected var _median						:Point;
		
		protected var _id							:int;
		
		protected var _selected						:Boolean;
		
		protected var baseShape						:Arc;
		
		protected var color							:uint					= 0xFFFFFF;
		protected var selectedHighlightColor		:uint					= 0xE5B611;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function TimelineSectionCircular() {
			
		}
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init(startPos:Number, arcLength:Number, gapLength:Number, text:String):void {
			
			//save data
			
			
			//base shape
			baseShape = new Arc();
			baseShape.donut = true;
			baseShape.color = color;
			baseShape.colorAlpha = .8;
			baseShape.innerRadius = this.radius - this.thickness;
			baseShape.steps = arcLength;
			baseShape.draw(radius,startPos,arcLength, gapLength);
			this.addChild(baseShape);
			
			var filter:GlowFilter = new GlowFilter(0x999999,0.6, 3, 3, 2);
			baseShape.filters = [filter];
			
			median = baseShape.median;
						
			
			//1. year
			if (arcLength >= 20) {
				
				//style
				var style:TextLayoutFormat = new TextLayoutFormat();
				style.color = 0x58585B;
				style.fontFamily = "Arial, Helvetica, _sans";
				style.fontSize = this.thickness * .8;
				style.fontWeight = "bold";
				style.textAlpha = .7;
				
				//text container
				var textContainer:Sprite = new Sprite();
				this.addChild(textContainer);
				
				//text
				var textTF:TLFTextField = new TLFTextField();
				textTF.autoSize = "left";
				textTF.multiline = false;
				textTF.wordWrap = false;
				textTF.mouseChildren = false;
				textTF.mouseEnabled = false;
				textTF.width = 20;
				textTF.height = 20;
				
				textTF.text = text;
				
				var textTFlow:TextFlow = textTF.textFlow;
				textTFlow.hostFormat = style;
				textTFlow.flowComposer.updateAllControllers();
				
				textTF.x = -textTF.width/2;
				textTF.y = -textTF.height - 1;
				
				textContainer.x = median.x;
				textContainer.y = median.y;
				textContainer.rotation = startPos + (arcLength/2) + 180;
				textContainer.addChild(textTF);
			}
			
			//3. Listeners
			//this.mouseChildren = false;
			//this.buttonMode = true;
			//this.addEventListener(MouseEvent.CLICK, click);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function click(event:MouseEvent):void {
			
			
			/*
			selected = !selected;
			
			if (selected) {
			addInfo();
			} else {
			removeInfo();
			}*/
			
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param color
		 * 
		 */
		protected function changeShapeHighight(color:uint):void {
			/*shapeHighight.graphics.clear();
			shapeHighight.graphics.beginFill(color);
			shapeHighight.graphics.drawRect(0,0,MIN_WIDTH, MAX_HEIGHT);
			shapeHighight.graphics.endFill();*/
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
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
		public function get median():Point {
			return _median;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set median(value:Point):void {
			_median = value;
		}
		
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

		public function get thickness():Number
		{
			return _thickness;
		}

		public function set thickness(value:Number):void
		{
			_thickness = value;
		}
		
		
	}
}
