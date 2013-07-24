package models.baseText {
	
	//imports
	import flash.events.Event;
	
	import events.MtVEvent;
	
	import mvc.Observable;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class BaseTextModel extends Observable {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var baseTextXML					:XML;
		protected var editionsCollection			:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function BaseTextModel() {
			super();	
			this.name = "baseText";
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _editionProcessComplete(e:Event):void {
			
			if (!editionsCollection) {
				editionsCollection = new Array();
			}
			
			var data:Object = new Object();
			data.text = e.target.data;
			data.editionID = e.target.editionID;
			
			editionsCollection.push(data);
			
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE, null, data));
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _processComplete(e:Event):void {
			
			baseTextXML = e.target.data;
			
			var data:Object = new Object();
			data.text = e.target.data;
			data.editionID = e.target.editionID;
			
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE, null, data));
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		
		//****************** PROCCESS ******************
		
		/**
		 * 
		 * 
		 */
		public function load():void {
			var pTB:ProcessTextBase = new ProcessTextBase();
			pTB.addEventListener(Event.COMPLETE, _processComplete);
			pTB = null;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function loadEdition(value:int):void {
			var pTB:ProcessTextBase = new ProcessTextBase(value);
			pTB.addEventListener(Event.COMPLETE, _editionProcessComplete);
			pTB = null;
		}
		
		
		//****************** GENERAL ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function hasTextBase():Boolean {
			return baseTextXML ? true : false;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getBaseText():XML {
			return baseTextXML;
		}
		
	}
}