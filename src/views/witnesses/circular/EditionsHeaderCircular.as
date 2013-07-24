package views.witnesses.circular {
	
	//import
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class EditionsHeaderCircular extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _maxRadius			:Number = 50;
		
		protected var circle1				:Sprite;
		protected var circle2				:Sprite;
		protected var circle3				:Sprite;
		protected var title1				:Sprite;
		protected var title2				:Sprite;
		
		//****************** Constructor ****************** ****************** ******************
		
		public function EditionsHeaderCircular(newRadius:Number = 0) {
			
			this.mouseChildren = false;
			
			if (newRadius != 0) _maxRadius = newRadius;
			
			//
			this.buttonMode = true;
			this.mouseChildren = false;
			
			//1. circles
			circle1 = new Sprite();
			circle1.graphics.beginFill(0x010101);
			circle1.graphics.drawCircle(0,0,maxRadius);
			circle1.graphics.endFill();
			circle1.alpha = .2;
			this.addChild(circle1);
			
			circle2 = new Sprite();
			circle2.graphics.beginFill(0x010101);
			circle2.graphics.drawCircle(0,0,maxRadius/1.4);
			circle2.graphics.endFill();
			circle2.alpha = .2;
			this.addChild(circle2);
			
			circle3 = new Sprite();
			circle3.graphics.beginFill(0x010101);
			circle3.graphics.drawCircle(0,0,_maxRadius/1.8);
			circle3.graphics.endFill();
			circle3.alpha = .2;
			this.addChild(circle3);
			
			TweenMax.to(circle2,10,{alpha:.3,repeat:-1, yoyo:true});
			TweenMax.to(circle3,6,{alpha:.3, yoyo:true});
			
			
			//title
			title1 = new Sprite();
			title1.mouseChildren = false;
			title1.mouseEnabled = false;
			this.addChild(title1);
			
			title2 = new Sprite();
			title2.mouseChildren = false;
			title2.mouseEnabled = false;
			title2.rotation = 180;
			this.addChild(title2);
			
			//load image
			
			var url:URLRequest = new URLRequest("views/witnesses/circular/image/title.png");
			
			var loader1:Loader = new Loader();
			loader1.mouseChildren = false;
			loader1.mouseEnabled = false;
			loader1.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader1.load(url);
			
			var loader2:Loader = new Loader();
			loader2.mouseChildren = false;
			loader2.mouseEnabled = false;
			loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader2.load(url);
			
			//add image
			title1.addChild(loader1);
			title2.addChild(loader2);
			

			//animation
			this.animation(true)

		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function onLoaderComplete(event:Event):void {
			event.stopImmediatePropagation();
			event.target.removeEventListener(Event.COMPLETE, onLoaderComplete);
			event.target.content.x = -event.target.width/2;
			event.target.content.y = -event.target.height/2;
		}
		
		
		//****************** PUBLIC EVENTS ****************** ****************** ******************
		
		public function animation(value:Boolean):void {
			if (value) {
				TweenMax.to(title1,40,{rotation:360,repeat:-1, ease:Linear.easeNone});
				TweenMax.to(title2,40,{rotation:540,repeat:-1, ease:Linear.easeNone});
			} else {
				TweenMax.killTweensOf(title1);
				TweenMax.killTweensOf(title2);
			}
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxRadius():Number {
			return _maxRadius;
		}

	}
}