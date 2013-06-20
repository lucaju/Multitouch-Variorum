package view {
	
	//imports
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import view.style.TXTFormat;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class CommentItem extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id						:int;
		protected var _lineStart				:int;
		protected var _lineEnd					:int;
		protected var _source					:String;
		protected var _author					:String;
		protected var _citation					:String;
		protected var _referenceStart			:int;
		protected var _referenceEnd				:int;
		protected var _text						:String;
		
		protected var textField					:TextField;
		protected var bg						:Sprite;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param id_
		 * 
		 */
		public function CommentItem(id_:int) {
			super();
			_id = id_;
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
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
		public function get lineStart():int {
			return _lineStart;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set lineStart(value:int):void {
			_lineStart = value;
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
		public function get citation():String {
			return _citation;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set citation(value:String):void {
			_citation = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get referenceStart():int {
			return _referenceStart;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set referenceStart(value:int):void {
			_referenceStart = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get referenceEnd():int {
			return _referenceEnd;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set referenceEnd(value:int):void {
			_referenceEnd = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get text():String {
			return _text;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set text(value:String):void {
			_text = value;
		}	
		
	}
}