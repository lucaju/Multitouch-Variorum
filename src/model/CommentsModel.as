package model {
	
	//imports
	import events.MtVEvent;
	import flash.events.Event;
	import mvc.Observable;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class CommentsModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var comments				:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function CommentsModel() {
			super();
			this.name = "comments";
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function processComplete(e:Event):void {
			comments = e.target.data;
			
			var obj:Object = {data:comments}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,obj));
			
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function hasComments():Boolean {
			return comments ? true : false;
		}
		
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pC:ProcessComments = new ProcessComments();
			pC.addEventListener(Event.COMPLETE, processComplete);
			pC = null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getComments(value:int = 0):* {
			if (value == 0) {
				return comments.concat();
			} else {
				
			}
		}
		
	}
}