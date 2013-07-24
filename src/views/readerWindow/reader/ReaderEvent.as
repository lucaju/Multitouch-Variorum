package views.readerWindow.reader {
	
	//import
	import flash.events.Event;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderEvent extends Event {
		
		//****************** Properties ****************** ****************** ******************
		
		public static const VARIABLE_SELECTED		:String = "variable_selected";
		public static const VARIABLE_UPDATED		:String = "variable_updated";
	
		public var targetID							:int; 
			
		
		//****************** CONTRUCTOR ****************** ****************** ******************
		
		/**
		 * 
		 * @param type
		 * @param parameters
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function ReaderEvent(type:String,
								  targetID = 0,
								  bubbles:Boolean = true,
								  cancelable:Boolean = false) {
			
			
			super(type, bubbles, cancelable);
			this.targetID = targetID;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public override function clone():Event {
			return new ReaderEvent(type, targetID, bubbles, cancelable);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public override function toString():String {
			return formatToString("PanelEvent", "type", "targetID", "bubbles", "cancelable", "eventPhase");
		}
			
	}
}