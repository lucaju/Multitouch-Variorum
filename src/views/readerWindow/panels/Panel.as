package views.readerWindow.panels {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import models.comment.CommentsModel;
	import models.variable.VariablesModel;
	
	import mvc.AbstractView;
	import mvc.IController;
	import mvc.Observable;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Panel extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************

		private static var _instanceArray			:Array = new Array();
		protected var _initialized					:Boolean = false;
		
		public const MIN_HEIGHT						:int			= 33;
		
		protected var _minWidth						:int			= 33;
		protected var _maxWidth						:int			= 233;
		protected var _currentWidth					:int			= this.minWidth;
		
		protected var _averageHeight				:int			= 440;
		protected var _maxHeight					:int			= 450;
		protected var _currentHeight				:int			= this.MIN_HEIGHT;
		
		protected var _maximizeStatus			 	:String 		= "normal";
		protected var _expanded						:Boolean		= false;
		
		protected var _readerID						:int;
		protected var _contentType					:String;
		
		protected var header						:PanelHeader;
		protected var panelContainer				:PanelContainer;		
		
		protected var bottomLine					:Sprite;
		
		
		//****************** Constructor ****************** ****************** ******************

		public function Panel(c:IController, create:Boolean = false) {
			if(create) {
				super(c);
			} else {
				throw new Error("Singleton... use getInstance()");
			}
			
			_instanceArray.push(this);
		}
		
		public static function getInstance(c:IController, readerID_:int, contentType_:String):Panel {
			
			//Instance exists
			var panel:Panel;
			var notHere:Boolean = true;
			
			for each (panel in _instanceArray) {
					
				//same reader?
				if (panel.readerID == readerID_) {
					
					//same content type?
					if (panel.contentType == contentType_) {
						notHere = false;
						break;
					}
					
				}
			}
			
			
			if(notHere) {
				panel = new Panel(c, true);
			}
			
			return panel;
		}
		
		/**
		 * 
		 * @param c
		 * 
		 */
		/*public function Panel(c:IController) {
			super(c);
		}*/
			
		
		//****************** Initialize ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function initialize(title:String):void {
			
			//1. Header
			header = new PanelHeader(this);
			header.minWidth = minWidth;
			header.maxWidth = maxWidth;
			this.addChild(header);
			
			header.init(title);
			
			//2. Get Header Data
			var numTotal:int;
			switch (contentType) {
				case "variables":
					numTotal = MtVController(this.getController()).getNumVariables();
					break;
				
				case "commentaries":
					numTotal = MtVController(this.getController()).getNumComments();
					break;
			}
			
			header.updateTotal(numTotal);
			
			//2.1 Load data
			if (numTotal == 0) {
				//get model through controlles
				var m:Observable
				
				//--------- Load totals
				switch (contentType) {
					case "variables":
						m = VariablesModel(MtVController(this.getController()).getModel(contentType));
						MtVController(this.getController()).loadVariables();
						MtVController(this.getController()).loadEditions();
						break;
					
					case "commentaries":
						m = CommentsModel(MtVController(this.getController()).getModel(contentType));
						MtVController(this.getController()).loadComments();
						break;
				}
				
				
				//add listeners
				m.addEventListener(MtVEvent.COMPLETE, _complete);
			}
			
			//4. listeners
			this.addEventListener(MouseEvent.CLICK, headerClick);
			
			_initialized = true;
		}
			
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _complete(e:MtVEvent):void {
			var numTotal:int;
			switch (contentType) {
				case "variables":
					numTotal = MtVController(this.getController()).getNumVariables();
					break;
				
				case "commentaries":
					numTotal = MtVController(this.getController()).getNumComments();
					break;
			}
			header.updateTotal(numTotal)	
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function headerClick(event:MouseEvent):void {
			
			if (event.target is PanelHeader) {

				if (this.isExpanded) {
					//stop propagation
					event.stopImmediatePropagation();
					
					//redefine maximizeStatus
					maximizeStatus = maximizeStatus == "normal" ? "maximized" : "normal";
					
					//send event
					this.removeEventListener(MouseEvent.CLICK, headerClick);
					header.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					this.addEventListener(MouseEvent.CLICK, headerClick);
				}
				
			}
		}	
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		protected function expandedView():void {
			
			changeCurrentHeight();
			_currentWidth = this.maxWidth;
			
			//1. Header
			header.expand(isExpanded);
			
			//3. Add content
			//panelContainer = new PanelContainer(this);
			panelContainer = PanelContainer.getInstance(this);
			this.addChild(panelContainer);
			
			if (!panelContainer.initialized) {
				panelContainer.maxHeight = this.averageHeight - header.height;
				panelContainer.y = header.height;
				panelContainer.init();
			} else {
				panelContainer.expand(true);
			}
			
			
			//4. Bottom Line
			if (!bottomLine) {
				bottomLine = new Sprite();
				bottomLine.graphics.lineStyle(1,0x444444,.4,true,"none");
				bottomLine.graphics.lineTo(this.currentWidth,0);
				bottomLine.graphics.endFill();
				
				bottomLine.y = this.currentHeight;
				
				this.addChild(bottomLine);
			}
			TweenMax.from(bottomLine, .6, {width:0});
		}
		
		/**
		 * 
		 * 
		 */
		protected function contractedView():void {
			
			_currentHeight = this.MIN_HEIGHT;
			_currentWidth = minWidth;
			
			//1. Header
			header.expand(isExpanded);
			
			//2. remove content
			panelContainer.expand(false);
			panelContainer = null;
			
			//3. Bottom Line
			this.removeChild(bottomLine);
			bottomLine = null;
		}
		
		protected function changeCurrentHeight():void {
			switch (maximizeStatus) {
				
				case "maximized":
				_currentHeight = this.maxHeight;
				break;
				
				case "minimized":
				_currentHeight = this.MIN_HEIGHT;
				break;
				
				case "normal":
				_currentHeight = this.averageHeight;
				break;
				
			}
		}
		
		//****************** PUBLIC METHOD ****************** ****************** ******************
		
		/**
		 * 
		 * @param isExpanded
		 * 
		 */
		public function expand(isExpanded):void {
			
			//define status
			_expanded = isExpanded;
			
			//call apropriate method
			isExpanded ? expandedView() : contractedView();

		}
		
		/**
		 * 
		 * 
		 */
		public function changeMaximization():void {
			
			if (panelContainer) {
				
				changeCurrentHeight();
				
				panelContainer.maxHeight = this.currentHeight - header.height;
				
				TweenMax.to(bottomLine, .6, {y:currentHeight});
				
				panelContainer.resize();
			}
		}
		
		/**
		 * 
		 * @param targetID
		 * 
		 */
		public function scrollTo(targetID:int):void {
			if (panelContainer) panelContainer.scrollTo(targetID);
		}
		
		public function KILL():void {
			PanelContainer.killIntance(panelContainer);
			this.removeChild(panelContainer);
			panelContainer = null;
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get minWidth():int {
			return _minWidth;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set minWidth(value:int):void {
			_minWidth = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maxWidth():int {
			return _maxWidth;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxWidth(value:int):void {
			_maxWidth = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get currentWidth():int {
			return _currentWidth;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get averageHeight():int {
			return _averageHeight;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set averageHeight(value:int):void {
			_averageHeight = value;
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
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get currentHeight():int {
			return _currentHeight;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get readerID():int {
			return _readerID;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set readerID(value:int):void {
			_readerID = value;
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
		public function get isExpanded():Boolean {
			return _expanded;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get maximizeStatus():String {
			return _maximizeStatus;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maximizeStatus(value:String):void {
			_maximizeStatus = value;
		}

		public function get initialized():Boolean
		{
			return _initialized;
		}

		
	}
}