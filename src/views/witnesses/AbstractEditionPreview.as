package views.witnesses {
	
	//imports
	import flash.events.MouseEvent;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class AbstractEditionPreview extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _editionID						:int;
		protected var _updatedValues						:Number = -1;
		
		
		//****************** Construvor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function AbstractEditionPreview (c:IController) {
			super(c);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function mouseMove(event:MouseEvent):void {
			//to override
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function mouseUp(event:MouseEvent):void {
			this.stopDrag();
			event.target.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get editionID():int {
			return _editionID;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get updatedValues():Number {
			return _updatedValues;
		}


	}
}