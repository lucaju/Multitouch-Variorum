package events{
	
	import flash.events.Event;
	
	public class MtVEvent extends Event {
		
		public static const CHANGE:String = "change";
		public static const COMPLETE:String = "complete";
		public static const SELECT:String = "select";
		public static const KILL:String = "kill";
		
		
		public var parameters:Object; 
			
		public function MtVEvent(type:String,
								  parameters:Object = null,
								  bubbles:Boolean = true,
								  cancelable:Boolean = false) {
			
			
			//sort
		
			super(type, bubbles, cancelable);
			this.parameters = parameters;
		}
		
		public override function clone():Event {
			return new MtVEvent(type, parameters, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("MtVEvent", "type", "parameters", "bubbles", "cancelable", "eventPhase");
		}
			
	}
}