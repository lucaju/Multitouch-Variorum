package views.readerWindow.panels {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import flash.display.Sprite;
	
	import mvc.IController;
	
	import views.readerWindow.panels.AbstractContent;
	import views.readerWindow.panels.commentPanel.Comment;
	import views.readerWindow.panels.commentPanel.Commentaries;
	import views.readerWindow.panels.variationPanel.Variable;
	import views.readerWindow.panels.variationPanel.Variables;
	import views.util.scroll.Scroll;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class PanelContainer extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		private static var _instance			:PanelContainer;
		private static var _instanceArray		:Array = new Array();
		protected var _initialized				:Boolean = false;
		
		protected var _maxHeight				:Number = 407;
		
		protected var _contentType				:String;
		
		protected var target					:Panel;
		protected var content					:AbstractContent;
		
		protected var bg						:Sprite;
		protected var containerMask				:Sprite;
		protected var scroll					:Scroll;
		
		
		//****************** Constructor ****************** ****************** ******************

		
		/**
		 * 
		 * @param target_
		 * @param create
		 * 
		 */
		public function PanelContainer(target_:Panel, create:Boolean = false) {
			if(create) {
				target = target_;
				contentType = target.contentType;
			} else {
				throw new Error("Singleton... use getInstance()");
			}
			
			_instanceArray.push(this);
		}
		
		
		//****************** STATIC PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param target_
		 * @return 
		 * 
		 */
		public static function getInstance(target_:Panel):PanelContainer {
			
			//Instance exists
			var panelContainer:PanelContainer;
			var notHere:Boolean = true;
			
			for each (panelContainer in _instanceArray) {
				
				//same reader?
				if (panelContainer.target.readerID == target_.readerID) {
					
					//same content type?
					if (panelContainer.target.contentType == target_.contentType) {
						notHere = false;
						break;
					}
					
				}
			}
			
			
			if(notHere) {
				panelContainer = new PanelContainer(target_, true);
			}
			
			return panelContainer;
			
		}
		
		/**
		 * 
		 * 
		 */
		public static function killIntance(target:PanelContainer):void {
			
			for each (var panelContainer:PanelContainer in _instanceArray) {
				if (panelContainer == target) {
					_instanceArray.splice(_instanceArray.indexOf(panelContainer),1);
					target = null;
					panelContainer = null;
					break;
				}
			}
		}
		
		
		//****************** Initialize ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init():void {
			
			var controler:IController = target.getController();
			
			//load
			switch (contentType) {
				
				case "variables":
					content = new Variables(controler); 
					break;
				
				case "commentaries":
					content = new Commentaries(controler);
					break;	
			}
			
			content.maxWidth = target.maxWidth;
			content.maxHeight = this.maxHeight;
			content.readerID = target.readerID;
			this.addChild(content);
			content.init();
			
			//scroll?
			testForScroll();
			
			_initialized = true;
		}
		
		/**
		 * 
		 * 
		 */
		protected function testForScroll():void {
		
			if (!scroll) {
			
				if (content.height > _maxHeight) {
					
					//bg
					bg = new Sprite();
					bg.graphics.beginFill(0xFFFFF0,0);
					bg.graphics.drawRect(0,0,content.width-1,content.height);
					content.addChildAt(bg,0);
					
					
					//mask for container
					containerMask = new Sprite();
					containerMask.graphics.beginFill(0xFFFFFF,0);
					containerMask.graphics.drawRect(content.x,content.y,this.width,maxHeight);
					this.addChild(containerMask);
					content.mask = containerMask;
					
					TweenMax.from(containerMask,.56,{width:0});
						
					//add scroll system
					scroll = new Scroll();
					scroll.x = target.maxWidth;
					scroll.alpha = .6;
					scroll.y = content.y;
					scroll.direction = scroll.VERTICAL;
					scroll.target = content;
					scroll.maskContainer = containerMask;
					this.addChild(scroll);
					scroll.init();
				}
			
			} else {
				
				//resize mask
				TweenMax.to(containerMask, .6,{height:maxHeight, onUpdate:scroll.update});
				
			}
			
			
		}
		
		
		//****************** PUBLIC METHOD ****************** ****************** ******************
		
		/**
		 * 
		 * @param targetID
		 * 
		 */
		public function scrollTo(targetID:int):void {
			
			var posY:Number;
			
			switch (contentType) {
				
				case "variables":
					
					var variable:Variable = Variables(content).getVariableByID(targetID);
					
					// Scroll variables
					if (variable.y > content.height-_maxHeight) {
						posY = content.height-_maxHeight
					} else {
						posY = variable.y;
					}
					
					TweenMax.to(content,1,{y:-posY,ease:Strong.easeInOut});
					
					break;
				
				case "commentaries":
				
					// Scroll Comments
					var comment:Comment = Commentaries(content).getCommentByLine(targetID);
					if (comment) {
						
						if (comment.y > content.height-_maxHeight) {
							posY = content.height-_maxHeight
						} else {
							posY = comment.y;
						}
						
						TweenMax.to(content,1,{y:-posY,ease:Strong.easeInOut});
					
					}
					
					break;
					
			}
		}
		
		/**
		 * 
		 * 
		 */
		public function resize():void {
			
			//1.
			content.maxHeight = this.maxHeight;
			content.resize();
			
			//2.
			testForScroll();
		}
		
		/**
		 * 
		 * 
		 */
		public function expand(isExpanded:Boolean):void {
			if (isExpanded) {
				TweenMax.to(containerMask,.6,{width:this.width, alpha:1});
				TweenMax.to(this,.6,{alpha:1});
			} else {
				TweenMax.to(containerMask,.6,{width:this.target.minWidth, alpha:0, onComplete:removeThis});
				TweenMax.to(this,.6,{alpha:0});
			}
		}
		
		
		//****************** PRIVATE METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		private function removeThis():void {
			this.parent.removeChild(this);
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get initialized():Boolean {
			return _initialized;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get contentType():String {
			return _contentType;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set contentType(value:String):void {
			_contentType = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxHeight():int {
			return _maxHeight;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxHeight(value:int):void {
			_maxHeight = value;
		}

	}
}