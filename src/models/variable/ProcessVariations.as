package models.variable {
	
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
	public class ProcessVariations extends EventDispatcher {
		
		//****************** Properties ****************** ****************** ******************
		
		public var data					:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ProcessVariations() {
			
			//---------get list info.
			var url:URLRequest = new URLRequest("http://labs.fluxo.art.br/mtv/witnessVariantsJSON.php");
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
			var variations:Object = JSON.parse(e.target.data);
			
			data = new Array();
			var variation:VariableModel;
			
			for each (var VAR:Object in variations) {
				
				//get Variable
				variation = getVariableByVaraibleID(VAR.variation_id);
				
				if (!variation) { 							//if varaition is null, create a new one
					variation = new VariableModel(VAR.id);
					variation.line = VAR.line;
					variation.lineEnd = VAR.line_end;
					variation.variableID = VAR.variation_id;
					variation.xmlTarget = VAR.xml_target;
					variation.source = VAR.source;
					
					variation.addVariation(VAR.id, VAR.variant, VAR.type, VAR.editions);
					
					data.push(variation);
				
				} else {											//Add variation to a Variable
					variation.addVariation(VAR.id, VAR.variant, VAR.type, VAR.editions);
				}
				
			}
			
			variation = null;
			
			data = data.sortOn("line", Array.NUMERIC);
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		protected function getVariableByVaraibleID(value:int):VariableModel {
			for each (var variableSaved:VariableModel in data) {
				if (variableSaved.variableID == value) return variableSaved;
			}
			return null;
		}
		
	}
}