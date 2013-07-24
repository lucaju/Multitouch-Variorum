package views.readerWindow.reader.variantFloatBox {
	
	//imports
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	public class Balloon extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var balloon			:Sprite;
		protected var round				:Number = 10;			// Round corners
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param w
		 * @param h
		 * 
		 */
		public function Balloon(w:Number, h:Number) {
			
			super();
			
			//draw balloon
			balloon = new Sprite();
			balloon.graphics.beginFill(0xFFA500,1);
			balloon.graphics.drawRoundRect(0,0,w,h,round,round);
			balloon.graphics.endFill();
			
			addChild(balloon)
			
			balloon.x + balloon.width/2;
			balloon.y + balloon.height;
			
			//effects
			var fxs:Array = new Array();
			var fxGlow:BitmapFilter = getBitmapFilter(0x000000, .5);
			fxs.push(fxGlow);
			this.filters = fxs;
			
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************

		/**
		 * 
		 * @param colorValue
		 * @param a
		 * @return 
		 * 
		 */
		protected function getBitmapFilter(colorValue:uint, a:Number):BitmapFilter {
			//propriedades
			var color:Number = colorValue;
			var alpha:Number = a;
			var blurX:Number = 6;
			var blurY:Number = 6;
			var strength:Number = 3;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			return new GlowFilter(color,alpha,blurX,blurY,strength,quality);
		}
	}
}