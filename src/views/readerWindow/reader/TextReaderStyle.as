package views.readerWindow.reader {
	
	//imports
	import flashx.textLayout.formats.TextLayoutFormat;
	import views.style.ColorSchema;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class TextReaderStyle {
		
		//****************** STATIC PUBLIC METHODS ****************** ****************** ******************

		/**
		 * 
		 * @param styleName
		 * @param statusColor
		 * @return 
		 * 
		 */
		static public function getStyle(styleName:String, statusColor:String = "standard"):TextLayoutFormat {
			
			var style:TextLayoutFormat = new TextLayoutFormat();
		
			switch (styleName) {
				
				case "DefaultParagraph":
					style.fontFamily = "Helvetica Neue";
					style.fontSize = 11;
					style.lineHeight = 17;
					style.textAlign = "left";
					style.color = 0x000000;
					break;
				
				case "LineNumberHide":
					style.color = 0xAAAAAA;
					style.textAlpha = 0.1;
					break;
				
				case "LineNumberShow":
					style.color = 0xAAAAAA;
					style.textAlpha = 1;
					break;
				
				case "Act Intro Paragraph":
					style.paragraphSpaceAfter = 20;
					style.tabStops = "e18 s56";
					break;
				
				case "Act Intro":
					style.fontSize = 18;
					style.lineHeight = 27;
					style.fontWeight = "bold";
					style.paragraphSpaceAfter = 36;
					break;
				
				case "Stage Direction":
					style.fontStyle = "italic";
					break;
				
				case "Speaker":
					style.fontWeight = "bold";
					//style.backgroundColor = 0xFF00FF;
					//style.backgroundAlpha = .6;
					break;
				
				case "Variation":
					style.color = 0x000000;
					//style.backgroundColor = 0x333333;
					style.backgroundAlpha = 0;
					break;
				
				case "Variation_Highlight":
					style.color = 0x000000;
					style.backgroundColor = 0xFFFF00;
					style.backgroundAlpha = .4;
					break;
				
				case "Variation_Selected":
					style.color = 0xFFFFFF;
					style.backgroundColor = 0xA52A2A;
					style.backgroundAlpha = .8;
					style.fontWeight = "bold";
					break;
				
				case "paragraph":
					style.tabStops = "e18 s28";
					break;
				
				
				default:
					style.fontFamily = "Helvetica Neue";
					style.fontSize = 11;
					style.lineHeight = 17;
					style.textAlign = "left";
					style.color = ColorSchema.getColor(statusColor);
					break;
				
			}
		
			return style;
		}
		 
	}
}