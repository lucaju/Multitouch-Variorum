package views.readerWindow.panels.commentPanel {
	
	//imports
	import controller.MtVController;
	
	import models.comment.CommentModel;
	
	import mvc.IController;
	
	import views.readerWindow.panels.AbstractContent;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Commentaries extends AbstractContent {
		
		//****************** Properties ****************** ****************** ******************
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function Commentaries(c:IController) {
			super(c);
		}
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		override public function init():void {
			collection = new Array();
			
			var comments:Array = MtVController(this.getController()).getComments();
			
			
			//loop in the witnessess
			var comment:Comment;
			var posY:Number = 0;
			
			for each (var COMM:CommentModel in comments) {
				
				comment = new Comment(this.getController(), COMM.id);
				comment.maxWidth = this.maxWidth;
				comment.y = posY;
				this.addChild(comment);
				
				comment.init(COMM.text,COMM.author,COMM.lineStart);
				
				collection.push(comment);
				
				posY += comment.height + 10;
			}
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getCommentByID(value:int):Comment {
			for each (var comment:Comment in collection) {
				if (comment.id == value) {
					return comment;
				}
			}
			return null;
		}
		
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getCommentByLine(value:int):Comment {
			for each (var comment:Comment in collection) {
				if (comment.lineStart == value) {
					return comment;
				}
			}
			return null;
		}

	}
}