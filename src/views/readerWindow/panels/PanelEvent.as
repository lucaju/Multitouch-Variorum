package views.readerWindow.panels {
	
	//import
	import flash.events.Event;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class PanelEvent extends Event {
		
		//****************** Properties ****************** ****************** ******************
		
		public static const CELL_EXPANDED		:String = "cell_expanded";
		public static const CELL_SELECTED		:String = "cell_selected";
		
		public var phase						:String = "";
		public var targetID						:int;
		public var parameters					:Object; 
			
		
		//****************** CONTRUCTOR ****************** ****************** ******************
		
		/**
		 * 
		 * @param type
		 * @param parameters
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function PanelEvent(type:String,
								  phase:String = null,
								  targetID = 0,
								  parameters = null,
								  bubbles:Boolean = true,
								  cancelable:Boolean = false) {
			
			
			super(type, bubbles, cancelable);
			this.phase = phase;
			this.targetID = targetID;
			this.parameters = parameters;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public override function clone():Event {
			return new PanelEvent(type, phase, targetID, parameters, bubbles, cancelable);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public override function toString():String {
			return formatToString("PanelEvent", "type", "phase", "targetID", "parameters", "bubbles", "cancelable", "eventPhase");
		}
			
	}
}