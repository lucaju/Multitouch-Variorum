package view.reader {
	
	//imports
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import view.ReaderPanel;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderMenu extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var target				:ReaderPanel;
		protected var bg					:Sprite;
		protected var item					:ReaderMenuItem;
		protected var itemCollection		:Array = ["lineNumber", "variant", "reader_nav"];
		
		protected var margin				:int = 3;
		
		
		//****************** Contructtor ****************** ****************** ******************
		
		/**
		 * 
		 * @param target_
		 * 
		 */
		public function ReaderMenu(target_:ReaderPanel) {
			
			target = target_;
			
			var posX:int = margin;
			var size:int = 16;
			
			for each (var option:String in itemCollection) {
				item = new ReaderMenuItem(option, true, size);
				item.x = posX;
				item.y = margin;
				this.addChild(item);
				
				posX += size + margin;
				
				item.addEventListener(MouseEvent.CLICK, _click);
			}
			
			//bg
			bg = new Sprite();
			bg.graphics.beginFill(0xFFFFFF,0);
			bg.graphics.drawRect(0,0,posX + margin, size + (margin*2));
			bg.graphics.endFill();
			
			this.addChildAt(bg,0);
			
		}
		
		
		//****************** PROTECTED EVETNS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _click(e:MouseEvent):void {
			
			item = ReaderMenuItem(e.currentTarget);
			
			item.toggle = !item.toggle;
			
			switch (item.type) {
				case "lineNumber":
					target.showLineNumber(item.toggle);
					break;
				
				case "variant":
					target.showVariants(item.toggle);
					break;
				
				case "reader_nav":
					target.showNav(item.toggle);
					break;
			}
			
		}
	}
}