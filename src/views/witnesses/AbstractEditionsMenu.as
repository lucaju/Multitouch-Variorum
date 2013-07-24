package views.witnesses {
	
	//imports
	import mvc.AbstractView;
	import mvc.IController;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class AbstractEditionsMenu extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _expanded					:Boolean;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function AbstractEditionsMenu(c:IController) {
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
		 * @param editionID
		 * 
		 */
		public function editionOpened(editionID:int):void {
			//to override
		}
		
		/**
		 * 
		 * 
		 */
		public function resize():void {
			//to override
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get expanded():Boolean {
			return _expanded;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set expanded(value:Boolean):void {
			_expanded = value;
		}
	}
}