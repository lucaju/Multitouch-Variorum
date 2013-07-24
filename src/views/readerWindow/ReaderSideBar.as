package views.readerWindow {
	
	//import
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import views.readerWindow.panels.Panel;
	import views.readerWindow.panels.PanelHeader;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderSideBar extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		public const MIN_WIDTH						:int	 = 33;
		public const MAX_WIDTH						:int	 = 233;
		
		public const MIN_HEIGHT						:int	 = 33;
		
		protected var _currentWidth					:int = MIN_WIDTH;
		
		protected var _maxHeight					:int	 = 440;
		protected var _averageHeight				:int	 = _maxHeight;
		
		protected var _expanded						:Boolean = false;
		protected var maximizedPanel				:Panel;
		
		protected var target						:ReaderWindow;
		
		protected var panels						:Array;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function ReaderSideBar(_target:ReaderWindow) {
			target = _target;
			panels = new Array();
		}
		
		
		//****************** Initialize ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init():void {
			
			//0. Panels Available
			var panelsAvailable:Array = new Array();
			panelsAvailable[0] = {contentType: "variables", title: "Textual Notes"};
			panelsAvailable[1] = {contentType: "commentaries", title: "Commentaries"};
			
			//1. Max height
			averageHeight = averageHeight/panelsAvailable.length;
			maxHeight = _maxHeight - (MIN_HEIGHT * (panelsAvailable.length - 1));
			
			//2. Add panels
			var panel:Panel;
			var posY:Number = 0;
			
			for each (var objPanel:Object in panelsAvailable) {
				
				//panel = new Panel(target.getController());
				panel = Panel.getInstance(target.getController(), target.id, objPanel.contentType);
				this.addChild(panel);
				
				if (!panel.initialized) {
					panel.minWidth = MIN_WIDTH;
					panel.maxWidth = MAX_WIDTH;
					
					panel.averageHeight = this.averageHeight;
					panel.maxHeight = this.maxHeight;
					
					panel.name = objPanel.contentType;
					panel.readerID = target.id;
					panel.contentType = objPanel.contentType;
					panel.initialize(objPanel.title);
					panel.y = posY;
					
					panels.push(panel);
					
					posY = panel.currentHeight;
				}
				
			}
			
			panel = null;
			
			//3. Listeners
			this.addEventListener(MouseEvent.CLICK, panelIconHeaderClick);
			
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************	
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function panelIconHeaderClick(event:MouseEvent):void {
			if (event.target is PanelHeader) {
				var panel:Panel = Panel(event.target.parent);
				maximizePanels(panel);
			}
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param panel
		 * 
		 */
		protected function maximizePanels(panel:Panel):void {
				
			//define maximized panel
			maximizedPanel = panel.maximizeStatus == "maximized" ? panel : null;
			
			///loop
			var posY:Number = 0;
			for each (panel in panels) {
				
				if (maximizedPanel == null) {
					panel.maximizeStatus = "normal";
					panel.changeMaximization();
				} else {
					if (panel != maximizedPanel) panel.maximizeStatus = "minimized";
					panel.changeMaximization();
				}
				
				TweenMax.to(panel, .6,{y:posY});
				posY = panel.currentHeight;
				
			}	
			
		}	
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getPanelByName(value:String):Panel {
			for each (var panel:Panel in panels) {
				if (panel.name == value) return panel;
			}
			return null;
		}
		
		/**
		 * 
		 * @param isExpanded
		 * 
		 */
		public function expand():void {
			
			//change status
			expanded = target.isExpanded;
			
			//redefine current width
			currentWidth = expanded ? MAX_WIDTH : MIN_WIDTH;
			
			//loop
			var posY:Number = 0 ;
			for each (var panel:Panel in panels) {
				
				//expand
				panel.expand(expanded)
				
				//define positions
				var prevPanel:Panel = panels[panels.indexOf(panel)-1];
				if (prevPanel) posY = prevPanel.currentHeight;
				
				//animation
				TweenMax.to(panel,.5,{y:posY * panels.indexOf(panel)});
					
			}
			
		}
		
		/**
		 * 
		 * @param panelName
		 * @param targetID
		 * 
		 */
		public function update(panelName:String, targetID):void {
			var panel:Panel = getPanelByName(panelName);
			panel.scrollTo(targetID);
		}
		
		public function KILL():void {
			for each (var panel:Panel in panels) {
				panel.KILL();
				this.removeChild(panel);
				panel = null;
			}
			
			panels = null;
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get expanded():Boolean {
			return _expanded;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set expanded(value:Boolean):void {
			_expanded = value;
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
		 * @param value
		 * 
		 */
		public function set currentWidth(value:int):void {
			_currentWidth = value;
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
		public function set maxHeight(value:int):void{
			_maxHeight = value;
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


	}

		
}