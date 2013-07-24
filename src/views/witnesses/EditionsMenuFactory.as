package views.witnesses {
	
	//imports
	import mvc.IController;
	
	import views.witnesses.circular.EditionsMenuCircular;
	import views.witnesses.linear.EditionsMenuLinear;
	
	/**
	 * Edition Menu Factory.
	 * Fabricates Edition Menu according to the speciications.
	 * Type:
	 * 	- Linear
	 *  - Circular
	 * 	- Spiral
	 * OS:
	 * 	- iPhone (iPad Retina Display)
	 *  - Mac OS
	 *  
	 * @author lucaju
	 * 
	 */
	public class EditionsMenuFactory {
		
		//****************** STATIC PUBLIC METHODS ****************** ****************** ****************** 
		
		/**
		 * Edition Menu Factory.
		 * Fabricates Edition Menu according to the speciications.
		 * Type:
		 * 	- Linear
		 *  - Circular
		 * 	- Spiral
		 * OS:
		 * 	- iPhone (iPad Retina Display)
		 *  - Mac OS
		 *  
		 * @author lucaju
		 * 
		 */
		static public function addMenu(c:IController, type:String):AbstractEditionsMenu {	
			
			var menu:AbstractEditionsMenu;
			
			switch (type.toLowerCase()) {
				case "linear":
					menu = new EditionsMenuLinear(c);
					break;
				
				case "circular":
					menu = new EditionsMenuCircular(c);
					break;
				
				case "spiral":
					
					break;
			}
			
			return menu;
		}
		
	}
}