package views.witnesses.circular {
	
	//imports
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import controller.MtVController;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import models.edition.EditionModel;
	
	import mvc.IController;
	
	import views.witnesses.AbstractEditionPreview;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionPreviewCircular extends AbstractEditionPreview {
		
		//****************** Properties ****************** ****************** ******************
		
		
		//****************** Construvor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function EditionPreviewCircular(c:IController, editionID_:int) {
			super(c);
			
			_editionID = editionID_;
			
			//1.Shape
			var shape:Sprite = new Sprite();
			shape.graphics.beginFill(0xDDDDDD);
			shape.graphics.drawRoundRect(0,0,100,120,10);
			shape.graphics.lineStyle(1, 0x000000,.2,true);
			shape.graphics.beginFill(0xDDDDDD,0);
			shape.graphics.drawRoundRect(10,10,80,100,10);
			shape.graphics.endFill();
			
			this.addChild(shape);
			
			//add Glow
			var filter:GlowFilter = new GlowFilter(0x333333,0.4, 8, 8, 2);
			shape.filters = [filter];
			
			//2. info
			var edition:EditionModel = MtVController(this.getController()).getEdition(editionID);
			
			//3. style
			var style:TextLayoutFormat = new TextLayoutFormat();
			style.color = 0x666666;
			style.fontFamily = "Arial, Helvetica, _sans";
			style.fontSize = 14;
			style.fontWeight = "bold";
			style.textAlign = "center";
			
			//4. text
			var textTF:TLFTextField = new TLFTextField();
			textTF.autoSize = "center";
			textTF.selectable = false;
			textTF.wordWrap = true;
			textTF.multiline = true;
			textTF.width = 70;
			
			textTF.text = edition.author + "\n\n" + edition.date.toString();
			
			var textTFlow:TextFlow = textTF.textFlow;
			textTFlow.hostFormat = style;
			textTFlow.flowComposer.updateAllControllers();
			
			textTF.x = (shape.width/2) - (textTF.width/2);
			textTF.y = (shape.height/2) - (textTF.height/2);
			
			shape.addChild(textTF);
		
			//5.action
			
			shape.x = -shape.width/2;
			shape.y = -shape.height/2;
			
			this.alpha = .2;
			this.scaleX = this.scaleY = .2;
			
			this.startDrag(true);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override protected function mouseMove(event:MouseEvent):void {
			
			var centerX:Number = stage.stageWidth/2;
			var centerY:Number = stage.stageHeight/2;
			
			var point:Point = new Point(this.x,this.y);					//get the point under preview object
			point.offset(-centerX, -centerY);							//offset point to get reference on the center of the screen
			var radius:Number = point.length;							//the distance (radius) from the center of the screen			
			
			_updatedValues = radius;
			
			var value:Number = radius/100;
			
			//get angle
			var angle:Number;
			angle = (Math.atan2(point.y,point.x) * 180/Math.PI) - 90; //angle in rads // tranformed to degrees // rotate -90º
			
			
			//Visual change
			this.rotation = angle;
			
			if (value >= .5) {		
				
				if (value >= 1.8) {
				
					this.scaleX = this.scaleY = 1.5;
					this.alpha = 1;
				
				} else {
				
					this.scaleX = this.scaleY = value - .3;
					this.alpha = value - .3;
			
				}
			
			} else {
				
				this.alpha = .2;
				this.scaleX = this.scaleY = .2;
		
			}
			
			
		}
		
		
	}
}