package view.reader.variantFloatBox {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class VariantFloatBox extends Sprite {	
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _id					:int;						// Article's id

		protected var maxWidth				:Number = 150;				// Balloon max width
		protected var minHeight				:Number = 20;				// Balloom min height
		protected var round					:Number = 10;				// Round corners
		protected var margin				:Number = 2;				// Margin size
		protected var _arrowDirection		:String = "bottom";			// Arrow point direction

		protected var shapeBox				:Balloon;					//Shape of the balloon;
		
		protected var titleTF				:TextField;					// Title Textfield
		protected var titleStyle			:TextFormat = new TextFormat("Arial Narrow", 12, 0xFFFFFF,true,null,null,null,null,"center");
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param idValue
		 * 
		 */
		public function VariantFloatBox(idValue:int = 0) {	
			//save properties
			_id = idValue;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function initialize(data:Object):void {
			
			var target:Sprite = data.target;
			
			if (target != null) {
			
				//set position
				var targetPoint:Point = new Point(this.x, this.y)
				var targetGlobalPos:Point = target.localToGlobal(targetPoint);
	
				this.x = targetGlobalPos.x + (target.width/2)	
				this.y = targetGlobalPos.y + target.height;
			
			}
			
			
			
			//----------title
			titleTF = new TextField();
			titleTF.selectable = false;
			titleTF.autoSize = "center";
			titleTF.text = " " + data.title + " ";
			titleTF.setTextFormat(titleStyle);
			
			titleTF.x = margin;
			titleTF.y = margin;
			
			addChild(titleTF);
			
			//shape
			shapeBox = new Balloon(titleTF.width + (2 * margin), titleTF.height + (1 * margin));
			addChildAt(shapeBox,0);
			
			//elements Position
			shapeBox.x = -shapeBox.width/2;
			shapeBox.y = -shapeBox.height;
			
			titleTF.x = shapeBox.x + margin;
			titleTF.y = shapeBox.y + margin;
			
			TweenMax.from(this,.5,{autoAlpha:0, y:this.y + 5});
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _closebutton(e:MouseEvent):void {
			//workflowController.killBalloon(id)
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get id():int {	
			return _id;
		}

	}
}