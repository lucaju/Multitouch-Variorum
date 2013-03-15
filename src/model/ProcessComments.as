package model {
	
	//imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ProcessComments extends EventDispatcher {
		
		//properties
		private var url:URLRequest;
		private var urlLoader:URLLoader;
		
		public var data:Array;
		
		public function ProcessComments() {
			
			//---------get list info.
			url = new URLRequest("http://labs.fluxo.art.br/mtv/getCommentsJSON.php");
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.load(url);
			
		}
		
		private function onComplete(e:Event):void {
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
			
			url = null;
			urlLoader = null;
			comment = null;
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
}