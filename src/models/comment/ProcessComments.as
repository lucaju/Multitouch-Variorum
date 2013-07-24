package models.comment {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ProcessComments extends EventDispatcher {
		
		//****************** Properties ****************** ****************** ******************
		
		public var data				:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ProcessComments() {
			
			//---------get list info.
			var url:URLRequest = new URLRequest("http://labs.fluxo.art.br/mtv/getCommentsJSON.php");
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onComplete(e:Event):void {
			var comments:Object = JSON.parse(e.target.data);
				
			//init
			data = new Array();
			var comment:CommentModel;
			
			for each (var comm:Object in comments) {
				
				comment = new CommentModel(comm.id);
				comment.lineStart = comm.line_start;
				comment.lineEnd = comm.line_end;
				comment.source = comm.source;
				comment.author = comm.author;
				comment.referenceStart = comm.Reference_Start;
				comment.referenceEnd = comm.Reference_End;
				comment.text = comm.comment;
				
				data.push(comment);
				
			}
			
			comment = null;
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
}