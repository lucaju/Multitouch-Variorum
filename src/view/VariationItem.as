package view {
	
	//imports
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import view.style.TXTFormat;
	
	public class VariationItem extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id					:int;
		protected var _line					:int;
		protected var _lineEnd				:int;
		protected var _xmlTarget			:String;
		protected var _source				:String;
		protected var _variant				:String;
		protected var _type					:String;
		
		protected var textField				:TextField;
		protected var bg					:Sprite;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function VariationItem(id_:int) {
			super();
			_id = id_;
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init():void {
			
			var colors:Array = new Array();
			colors["insert"] = {line: 0x0071DA, fill:0x0095DA};
			colors["replace"] = {line: 0xD2232A, fill:0xB61D22};
			colors[""] = {line: 0x333333, fill:0x646464};
			
			
			//textfield
			var text:String = "Line: " + line;
			text += "\n Source: " + source;
			text += "\n Variant: " + variant;
			text += "\n Type: " + type;
			
			textField = new TextField();
			textField.wordWrap = true;
			textField.multiline = true;
			textField.autoSize = "left";
			textField.selectable = false;
			textField.mouseEnabled = false;
			
			textField.text = text;
			textField.setTextFormat(TXTFormat.getStyle("text"));
			
			textField.x = 5;
			textField.y = 5;
			textField.width = 250;
			
			this.addChild(textField);
			
			//bg
			bg = new Sprite();
			bg.graphics.lineStyle(1,colors[type].line);
			bg.graphics.beginFill(colors[type].fill);
			bg.graphics.drawRect(0,0,textField.width + 10 ,textField.height + 10);
			bg.graphics.endFill();
			
			this.addChildAt(bg,0);
			
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
		public function get line():int {
			return _line;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set line(value:int):void {
			_line = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get lineEnd():int {
			return _lineEnd;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set lineEnd(value:int):void {
			_lineEnd = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get xmlTarget():String {
			return _xmlTarget;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set xmlTarget(value:String):void {
			_xmlTarget = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get source():String {
			return _source;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set source(value:String):void {
			_source = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get variant():String {
			return _variant;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set variant(value:String):void {
			_variant = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get type():String {
			return _type;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set type(value:String):void {
			_type = value;
		}
	}
}