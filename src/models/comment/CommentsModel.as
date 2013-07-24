package models.comment {
	
	//imports
	import flash.events.Event;
	
	import events.MtVEvent;
	
	import mvc.Observable;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class CommentsModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var collection				:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function CommentsModel() {
			super();
			this.name = "commentaries";
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function processComplete(e:Event):void {
			collection = e.target.data;
			
			var obj:Object = {data:collection}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE, null, obj));
			
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		//****************** PROCCESS ****************** 
		
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pC:ProcessComments = new ProcessComments();
			pC.addEventListener(Event.COMPLETE, processComplete);
			pC = null;
		}
		
		//****************** GENERAL INFORMATION ****************** 
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get hasComments():Boolean {
			return collection ? true : false;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getTotal():int {
			return collection.length;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getComments():Array {
			return collection.concat();
		}
		
		//****************** VARIABLE SPECIFIC INFORMATION ****************** 
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getComment(value:int = 0):CommentModel {
			for each (var comment:CommentModel in collection) {
				if (comment.id == value) {
					return comment
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
		public function getLineStartFromCommentID(value:int):int {
			var comment:CommentModel = getComment(value);
			return comment.lineStart;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getSourceFromCommentID(value:int):String {
			var comment:CommentModel = getComment(value);
			return comment.source;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getAuthorFromCommentID(value:int):String {
			var comment:CommentModel = getComment(value);
			return comment.author;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getTextFromCommentID(value:int):String {
			var comment:CommentModel = getComment(value);
			return comment.text;
		}
		
	}
}