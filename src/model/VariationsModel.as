package model {
	
	//imports
	import events.MtVEvent;
	
	import flash.events.Event;
	
	import mvc.Observable;
	
	public class VariationsModel extends Observable {
		
		//properties
		private var variations:Array;
		
		public function VariationsModel() {
			
			super();
			
			this.name = "variations";
		}
		
		public function hasVariations():Boolean {
			return variations ? true : false;
		}
		
		public function load():void {
			var pV:ProcessVariations = new ProcessVariations();
			pV.addEventListener(Event.COMPLETE, processComplete);
			pV = null;
		}
		
		private function processComplete(e:Event):void {
			variations = e.target.data;
			
			var obj:Object = {data:variations}
			
			//this.notifyObservers(obj);
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE,obj));
		
		}
		
		public function getVariation(value:int = 0):* {
			if (value == 0) {
				return variations.concat();
			} else {
				
			}
		}
		
	}
}