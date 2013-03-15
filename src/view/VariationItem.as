package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import view.style.TXTFormat;
	
	public class VariationItem extends Sprite {
		
		//properties
		private var _id:int;
		private var _line:int;
		private var _lineEnd:int;
		private var _xmlTarget:String;
		private var _source:String;
		private var _variant:String;
		private var _type:String;
		
		private var textField:TextField;
		private var bg:Sprite;
		
		public function VariationItem(id_:int) {
			super();
			
			_id = id_;
		}
		
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
		
		//---------GETTERS // SETTERS
		
		public function get id():int {
			return _id;
		}
		
		public function get line():int {
			return _line;
		}
		
		public function set line(value:int):void {
			_line = value;
		}
		
		public function get lineEnd():int {
			return _lineEnd;
		}
		
		public function set lineEnd(value:int):void {
			_lineEnd = value;
		}
		
		public function get xmlTarget():String {
			return _xmlTarget;
		}
		
		public function set xmlTarget(value:String):void {
			_xmlTarget = value;
		}
		
		public function get source():String {
			return _source;
		}
		
		public function set source(value:String):void {
			_source = value;
		}
		
		public function get variant():String {
			return _variant;
		}
		
		public function set variant(value:String):void {
			_variant = value;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function set type(value:String):void {
			_type = value;
		}
	}
}