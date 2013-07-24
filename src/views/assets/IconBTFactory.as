package views.assets {
	
	//imports
	import settings.Settings;
	
	/**
	 * Icon Button Factory.
	 * Fabricates Icon Buttons the speciications.
	 * Type:
	 * 	- Variations
	 *  - Authors
	 * OS:
	 * 	- iPhone (iPad Retina Display)
	 *  - Mac OS
	 *  
	 * @author lucaju
	 * 
	 */
	public class IconBTFactory {
		
		//****************** STATIC PUBLIC METHODS ****************** ****************** ****************** 
		
		/**
		 * Icon Button Factory.
		 * Fabricates Icon Buttons the speciications.
		 * Type:
		 * 	- Variations
		 *  - Authors
		 * OS:
		 * 	- iPhone (iPad Retina Display)
		 *  - Mac OS
		 * 
		 * @param title:String
		 * @return ButtonBar
		 * 
		 */
		static public function addButton(type:String, target:String = ""):IconBT {	
			
			//create new Button Bar
			var item:IconBT = new IconBT();
			
			if (target == "panelHeader") {
				item.w = 33;
				item.h = 33;
			}
			
			var iconFile:String;
			
			if (Settings.platformTarget == "mobile") {
				iconFile = getIconHDIcon(type);
			} else {
				iconFile = getIconSDIcon(type);
			}
			
	
			//initiate
			item.init(iconFile);
			
			return item;
		}
		
		
		//****************** STATIC PRIVATE METHODS ****************** ****************** ****************** 
		
		/**
		 * Get Icon File for Mac
		 *  
		 * @param titleLower:Strinf
		 * @return String
		 * 
		 */
		static private function getIconSDIcon(type:String):String {
			
			var file:String;
			
			switch(type) {
				
				case "variables":
					file = "images/icon_flag_20.png";
					break;
				
				case "commentaries":
					file = "images/icon_balloon_20.png";
					break;
				
				case "authors":
					file = "images/icon_authors_20.png";
					break;
				
				case "checkmark":
					file = "images/icon_check_20.png";
					break;

			}
			
			return file;
		}
		
		/**
		 * Get Icon File for iPhone (iPad retina Display)
		 *  
		 * @param titleLower:Strinf
		 * @return String
		 * 
		 */
		static private function getIconHDIcon(type:String):String {
			
			var file:String;
			
			switch(type) {
				
				case "variables":
					file = "images/icon_flag_20.png";
					break;
				
				case "commentaries":
					file = "images/icon_balloon_20.png";
					break;
				
				case "authors":
					file = "images/icon_authors_20.png";
					break;
				
				case "checkmark":
					file = "images/icon_check_20.png";
					break;
			}
			
			return file;
		}
	}
}