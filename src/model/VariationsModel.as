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
	public class VariationsModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var variations				:Array;
		
		
		//****************** Constuctor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function VariationsModel() {	
			super();
			this.name = "variations";
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function processComplete(e:Event):void {
			variations = e.target.data;
			
			var obj:Object = {data:variations}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,obj));	
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function hasVariations():Boolean {
			return variations ? true : false;
		}
		
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pV:ProcessVariations = new ProcessVariations();
			pV.addEventListener(Event.COMPLETE, processComplete);
			pV = null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariation(value:int = 0):* {
			if (value == 0) {
				return variations.concat();
			} else {
				
			}
		}
		
	}
}