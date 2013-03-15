package view {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import view.style.TXTFormat;
	
	public class CommentItem extends Sprite {
		
		//properties
		private var _id:int;
		private var _lineStart:int;
		private var _lineEnd:int;
		private var _source:String;
		private var _author:String;
		private var _citation:String;
		private var _referenceStart:int;
		private var _referenceEnd:int;
		private var _text:String;
		
		private var textField:TextField;
		private var bg:Sprite;
		
		public function CommentItem(id_:int) {
			super();
			
			_id = id_;
		}
		
		public function init():void {
			
			//textfield
			var textString:String = "Author: " + author;
			textString += "From line " + lineStart + " to line: " + lineEnd;
			textString += "\nSource: " + source;
			textString += "\nReference: " + referenceStart + " to " + referenceEnd;
			textString += "\nText: " + text;
			
			textField = new TextField();
			textField.wordWrap = true;
			textField.multiline = true;
			textField.autoSize = "left";
			textField.selectable = false;
			textField.mouseEnabled = false;
			
			textField.text = textString;
			textField.setTextFormat(TXTFormat.getStyle("text"));
			
			textField.x = 5;
			textField.y = 5;
			textField.width = 250;
			
			this.addChild(textField);
			
			//bg
			bg = new Sprite();
			bg.graphics.lineStyle(1,0x333333);
			bg.graphics.beginFill(0x646464);
			bg.graphics.drawRect(0,0,textField.width + 10 ,textField.height + 10);
			bg.graphics.endFill();
			
			this.addChildAt(bg,0);
			
		}
		
		//---------GETTERS // SETTERS
		
		public function get id():int {
			return _id;
		}
		
		public function get lineStart():int {
			return _lineStart;
		}
		
		public function set lineStart(value:int):void {
			_lineStart = value;
		}
		
		public function get lineEnd():int {
			return _lineEnd;
		}
		
		public function set lineEnd(value:int):void {
			_lineEnd = value;
		}
		
		public function get source():String {
			return _source;
		}
		
		public function set source(value:String):void {
			_source = value;
		}
		
		public function get author():String {
			return _author;
		}
		
		public function set author(value:String):void {
			_author = value;
		}
		
		public function get citation():String {
			return _citation;
		}
		
		public function set citation(value:String):void {
			_citation = value;
		}
		
		public function get referenceStart():int {
			return _referenceStart;
		}
		
		public function set referenceStart(value:int):void {
			_referenceStart = value;
		}
		
		public function get referenceEnd():int {
			return _referenceEnd;
		}
		
		public function set referenceEnd(value:int):void {
			_referenceEnd = value;
		}
		
		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			_text = value;
		}
		
		
	}
}