package views.style {
	
	//imports
	import flash.text.TextFormat;

	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class TXTFormat {
		
		
		//****************** STATIC PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param styleName
		 * @param statusColor
		 * @return 
		 * 
		 */
		static public function getStyle(styleName:String = "standard", statusColor:String = "standard"):TextFormat {
			
			var style:TextFormat = new TextFormat();
			style.font = "Helvetica Neue";
			style.color = ColorSchema.getColor(statusColor);
			style.leading = 2;
			
			switch (styleName) {
				
				//----------General ------------
				
				case "Header Title":
					style.size = 24;
					style.bold = true;
					style.color = 0xFFFFFF;
					break;
				
				case "Panel Title":
					style.font = "Candara";
					style.size = 18;
					style.bold = true;
					style.color = 0xFFFFFF;
					break;
				
				//----------Info Box ------------
				
				case "InfoBox Basetext":
					style.size = 12;
					style.bold = true;
					break;
				
				case "InfoBox Edition":
					style.size = 11;
					style.bold = true;
					break;
				
				//----------Variation Panel ------------
				
				case "text":
					style.size = 12;
					style.color = 0xFFFFFF;
					break;
				
				default:
					style.size = 12;
					break;
				
			}
		
			return style;
		}
		 
	}
}