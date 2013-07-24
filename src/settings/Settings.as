package settings {
	
	/**
	 * Settings.
	 * This class holds configuration settings of this app.
	 * 
	 * @author lucaju
	 * 
	 */
	public class Settings {
		
		//****************** Properties ****************** ****************** ******************
		
		//general
		private static var _platformTarget				:String;			//["air","mobile","web", "table"]
		private static var _debug						:Boolean;			//Debug
		private static var _menuType					:String;			//["linear,circular,spiral"]
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * Constructor. Set default values 
		 * 
		 */
		public function Settings() {
			
			//--------default values
			
			//-- General
			_platformTarget = "air";
			_debug = false;
			_menuType = "linear";
			
		}
		
		//****************** GETTERS & SETTERS - GENERAL ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function get platformTarget():String {
			return _platformTarget;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public static function set platformTarget(value:String):void {
			_platformTarget = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function get debug():Boolean {
			return _debug;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public static function set debug(value:Boolean):void {
			_debug = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public static function get menuType():String {
			return _menuType;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public static function set menuType(value:String):void {
			_menuType = value;
		}

		
	}
}