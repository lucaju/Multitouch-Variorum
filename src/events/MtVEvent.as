package events{
	
	//import
	import flash.events.Event;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class MtVEvent extends Event {
		
		//****************** Properties ****************** ****************** ******************
		
		public static const CHANGE				:String = "change";
		public static const COMPLETE			:String = "complete";
		public static const SELECT				:String = "select";
		public static const KILL				:String = "kill";
		
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
		public function MtVEvent(type:String,
								  parameters:Object = null,
								  bubbles:Boolean = true,
								  cancelable:Boolean = false) {
			
			
			super(type, bubbles, cancelable);
			this.parameters = parameters;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public override function clone():Event {
			return new MtVEvent(type, parameters, bubbles, cancelable);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public override function toString():String {
			return formatToString("MtVEvent", "type", "parameters", "bubbles", "cancelable", "eventPhase");
		}
			
	}
}