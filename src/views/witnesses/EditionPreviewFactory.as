package views.witnesses {
	
	//imports
	import mvc.IController;
	
	import views.witnesses.circular.EditionPreviewCircular;
	import views.witnesses.linear.EditionPreviewLinear;
	
	/**
	 * Edition Preview Factory.
	 * Fabricates Edition Preview according to the speciications.
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
	public class EditionPreviewFactory {
		
		//****************** STATIC PUBLIC METHODS ****************** ****************** ****************** 
		
		/**
		 * Edition Preview Factory.
		 * Fabricates Edition Preview according to the speciications.
		 * Type:
		 * 	- Linear
		 *  - Circular
		 * 	- Spiral
		 * OS:
		 * 	- iPhone (iPad Retina Display)
		 *  - Mac OS
		 * 
		 */
		static public function addPreview(c:IController, editionID:int, type:String):AbstractEditionPreview {	
			
			var preview:AbstractEditionPreview;
			
			switch (type.toLowerCase()) {
				case "linear":
					preview = new EditionPreviewLinear(c,editionID);
					break;
				
				case "circular":
					preview = new EditionPreviewCircular(c,editionID);
					break;
				
				case "spiral":
					
					break;
			}
			
			return preview;
		}
		
	}
}

