package model {
	
	//imports
	import events.MtVEvent;
	
	import flash.events.Event;
	
	import mvc.Observable;
	
	public class CommentsModel extends Observable {
		
		//properties
		private var comments:Array;
		
		public function CommentsModel() {
			
			super();
			
			this.name = "comments";
		}
		
		public function hasComments():Boolean {
			return comments ? true : false;
		}
		
		public function load():void {
			var pC:ProcessComments = new ProcessComments();
			pC.addEventListener(Event.COMPLETE, processComplete);
			pC = null;
		}
		
		private function processComplete(e:Event):void {
			comments = e.target.data;
			
			var obj:Object = {data:comments}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,obj));
		
		}
		
		public function getComments(value:int = 0):* {
			if (value == 0) {
				return comments.concat();
			} else {
				
			}
		}
		
	}
}