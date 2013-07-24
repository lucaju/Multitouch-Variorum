package views.readerWindow.panels {
	
	//import
	import mvc.AbstractView;
	import mvc.IController;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class AbstractContent extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _maxHeight				:Number = 407;
		protected var _maxWidth					:Number = 233;
		protected var _readerID					:int;
		protected var collection				:Array;
		
		
		//****************** Contructor ****************** ****************** ******************	
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function AbstractContent(c:IController) {
			super(c);
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init():void {
			//to override
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************	
		
		/**
		 * 
		 * 
		 */
		public function resize():void {
			//to override
		}
		
		/**
		 * 
		 * 
		 */
		public function kill():void {
			//to override
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxWidth():Number {
			return _maxWidth;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxWidth(value:Number):void {
			_maxWidth = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxHeight():Number {
			return _maxHeight;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxHeight(value:Number):void {
			_maxHeight = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get readerID():int {
			return _readerID;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set readerID(value:int):void {
			_readerID = value;
		}

	}
}