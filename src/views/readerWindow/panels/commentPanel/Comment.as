package views.readerWindow.panels.commentPanel {
	
	//imports
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import controller.MtVController;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	import views.readerWindow.panels.PanelEvent;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Comment extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _maxWidth					:Number = 233;
		
		protected var _id						:int;
		
		protected var bg						:Sprite;
		
		
		//****************** Contructor ****************** ****************** ******************		
		
		/**
		 * 
		 * @param c
		 * @param id_
		 * 
		 */
		public function Comment(c:IController, id_:int) {
			super(c);
			_id = id_;
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init(commentText:String = null, authorName:String = null, commentLine:int = 0):void {
			
			//0. styles
			
			//0.1 author
			var authorStyle:TextLayoutFormat = new TextLayoutFormat();
			authorStyle.color = 0x333333;
			authorStyle.fontFamily = "Constantia, Helvetica, Arial, _sans";
			authorStyle.fontSize = 14;
			authorStyle.paddingTop = 5;
			authorStyle.paddingLeft = 5;
			
			//0.2 line Number
			var LineStyle:TextLayoutFormat = new TextLayoutFormat();
			LineStyle.color = 0x666666;
			LineStyle.fontFamily = "Constantia, Helvetica, Arial, _sans";
			LineStyle.fontSize = 14;
			LineStyle.paddingTop = 5;
			LineStyle.paddingRight = 5;
			
			//0.3 author
			var textStyle:TextLayoutFormat = new TextLayoutFormat();
			textStyle.color = 0x333333;
			textStyle.fontFamily = "Constantia, Helvetica, Arial, _sans";
			textStyle.fontSize = 12;
			textStyle.lineHeight = 14;
			textStyle.paddingTop = 5;
			textStyle.paddingLeft = 10;
			textStyle.paddingRight = 10;
			textStyle.paddingBottom = 5;
			
			//1. Background
			bg = new Sprite();
			bg.graphics.beginFill(0x000000,.1);
			bg.graphics.drawRect(0,0,maxWidth,25);
			bg.graphics.endFill();
			
			this.addChild(bg);
			
			
			//2. Line number
			var lineNumberTF:TLFTextField = new TLFTextField();
			lineNumberTF.autoSize = "left";
			lineNumberTF.selectable = false;
			lineNumberTF.mouseEnabled = false;
			lineNumberTF.mouseChildren = false;
			lineNumberTF.width = 50;
			lineNumberTF.height = 25;
			
			lineNumberTF.text =  "line " + commentLine.toString();
			
			var lineNumberTFlow:TextFlow = lineNumberTF.textFlow;
			lineNumberTFlow.hostFormat = LineStyle;
			lineNumberTFlow.flowComposer.updateAllControllers();
			
			lineNumberTF.x =  maxWidth - lineNumberTF.width;
			
			this.addChild(lineNumberTF);
			
			//3. Author
			var authorTF:TLFTextField = new TLFTextField();
			authorTF.autoSize = "left";
			authorTF.selectable = false;
			authorTF.mouseEnabled = false;
			authorTF.mouseChildren = false;
			authorTF.wordWrap = true;
			authorTF.multiline = true;
			
			authorTF.y = 10;
			authorTF.y = 2;
			authorTF.width = maxWidth - authorTF.y - lineNumberTF.y;
			authorTF.height = 25;
			
			//correct display
			if (authorName == "") authorName = " ";
			authorTF.text = authorName;
			
			var authorTFlow:TextFlow = authorTF.textFlow;
			authorTFlow.hostFormat = authorStyle;
			authorTFlow.flowComposer.updateAllControllers();
			
			this.addChild(authorTF);
			
			
			//4. Text
			var textTF:TLFTextField = new TLFTextField();
			textTF.autoSize = "left";
			textTF.mouseChildren = false;
			textTF.mouseEnabled = false;
			textTF.wordWrap = true;
			textTF.multiline = true;
			
			textTF.y = bg.height;
			textTF.width = maxWidth;
		
			if (commentText == "") commentText = " ";
			textTF.text = commentText;
			
			var textTFlow:TextFlow = textTF.textFlow;
			textTFlow.hostFormat = textStyle;
			textTFlow.flowComposer.updateAllControllers();
			
			this.addChild(textTF);
			
			textTF.height = textTF.height; // IMPORTANT! leave this line. don't why. This is BUGGY...
			
			//5. listerners
			bg.buttonMode = true;
			bg.addEventListener(MouseEvent.CLICK, scrollText);
			
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function scrollText(event:MouseEvent):void {
			var params:Object = {eventSource:"comment",lineNumber:this.lineStart};
			this.dispatchEvent(new PanelEvent(PanelEvent.CELL_SELECTED, "scrollReader", this.id, params));
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
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
		public function get maxWidth():Number {
			return _maxWidth;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxWidth(value:Number):void {
			_maxWidth = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get lineStart():int {
			return MtVController(this.getController()).getCommentInfo(this.id,"lineStart");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get source():String {
			return MtVController(this.getController()).getCommentInfo(this.id,"source");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get author():String {
			return MtVController(this.getController()).getCommentInfo(this.id,"author");
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get text():String {
			return MtVController(this.getController()).getCommentInfo(this.id,"text");
		}

		
	}
}