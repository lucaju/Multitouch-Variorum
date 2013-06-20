package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import view.assets.tooltip.ToolTip;
	
	public class Edition extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id						:int;
		protected var _title					:String;
		protected var _author					:String;
		protected var _abreviation				:String;
		protected var _date						:String;
		
		protected var barH						:Number = 70;
		
		protected var shape						:Sprite;
		protected var varLevel					:Sprite;
		protected var _variationLevel			:Number; 
		
		protected var toolTip					:ToolTip;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function Edition(id_:int) {
			super();
			
			//------init
			_id = id_;
			
			//----- basic shape
			var shape:Sprite = new Sprite();
			shape.graphics.beginFill(0x333333);
			shape.graphics.drawRect(0,0,10, barH);
			shape.graphics.endFill();
			addChild(shape);
		}
		
		
		//****************** Contructor ****************** ****************** ******************
	
		/**
		 * 
		 * 
		 */
		public function init():void {
			this.buttonMode = true;
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		protected function addVariationViz(value:Number):void {
			varLevel = new Sprite();
			varLevel.graphics.beginFill(0xFFFFFF);
			varLevel.graphics.drawRect(0,0,10, barH);
			varLevel.graphics.endFill();
			varLevel.alpha = .7;
			varLevel.scaleY = value * 0.01;
			
			this.addChild(varLevel);
			
			
			this.addEventListener(MouseEvent.MOUSE_OVER, _over);
			this.addEventListener(MouseEvent.MOUSE_OUT, _out);
		}
		
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		protected function _over(e:MouseEvent):void {
			TweenMax.to(varLevel,.5,{scaleY:0,alpha:0});
			
			toolTip = new ToolTip();
			
			var toolTipPos:Point = new Point(this.x, 0);
			var outerPoint:Point = this.parent.localToGlobal(toolTipPos)
			
			toolTip.x = outerPoint.x - this.parent.parent.x + (this.width/2);
			toolTip.alpha = .8;
			toolTip.y = 20;	
				
			this.parent.parent.addChild(toolTip);
			
			//info
			var str:String = title + " - " + date + "\n" + author + " (" + abreviation + ")";
			
			toolTip.initialize({title:str});
			
		}
		
		protected function _out(e:MouseEvent):void {
			TweenMax.to(varLevel,.5,{scaleY:variationLevel * 0.01,alpha:.7});
			
			if (toolTip) {
				this.parent.parent.removeChild(toolTip);
				toolTip = null;
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
		public function get title():String {
			return _title;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set title(value:String):void {
			_title = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get author():String {
			return _author;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set author(value:String):void {
			_author = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get abreviation():String {
			return _abreviation;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set abreviation(value:String):void {
			_abreviation = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get date():String {
			return _date;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set date(value:String):void {
			_date = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get variationLevel():Number {
			return _variationLevel;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set variationLevel(value:Number):void {
			_variationLevel = value;
			
			if (!varLevel) {
				addVariationViz(value)
			}
		}

	}
}