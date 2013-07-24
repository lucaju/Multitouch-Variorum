package views.readerWindow.panels.variationPanel {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	
	import controller.MtVController;
	
	import models.variable.VariableModel;
	
	import mvc.IController;
	
	import views.readerWindow.panels.AbstractContent;
	import views.readerWindow.panels.PanelEvent;
	
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class Variables extends AbstractContent {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _columnWidth			:Number = 30;
		protected var verticalColumn		:Shape;
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function Variables(c:IController) {
			super(c);

		}
		
		//****************** INITIALIZE ****************** ****************** ******************
		
		override public function init():void {
			//1. vertical Column
			verticalColumn = new Shape();
			verticalColumn.graphics.beginFill(0x000000,.1);
			verticalColumn.graphics.drawRect(0,0,columnWidth,maxHeight);
			verticalColumn.graphics.endFill();
			
			this.parent.addChildAt(verticalColumn,0);
			
			
			//load Variables
			
			collection = new Array();
			
			var vars:Array = MtVController(this.getController()).getVariables();
			
			//loop in the witnessess
			var variable:Variable;
			var posY:Number = 0;
			
			for each (var VAR:VariableModel in vars) {
				
				variable = new Variable(this.getController(), VAR.variableID);
				//variable = Variable.getInstance(this.getController(), VAR.variableID)
				
				variable.target = this;
				variable.maxWidth = this.maxWidth;
				variable.y = posY;
				this.addChild(variable);
				
				variable.init(VAR.source, VAR.line);
				variable.loadVariations(VAR.variations);
				
				collection.push(variable);
				
				posY += variable.height + 5;
			}
			
			//listeners
			this.addEventListener(PanelEvent.CELL_EXPANDED, expandSize);
		}
		
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public function expandSize(event:PanelEvent):void {
					
			event.stopImmediatePropagation();
			
			var targetID:int = event.targetID;
			var target:Variable = getVariableByID(event.targetID);
			
			var i:int = getVariableIndex(target);
			var posY:Number = target.y;
			
			for (i; i < collection.length; i++) {
				TweenMax.to(collection[i],.5,{y:posY});
				posY += collection[i].height + 5;
			}
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		override public function resize():void {
			TweenMax.to(verticalColumn, .6,{height:maxHeight});
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariableByID(value:int):Variable {
			for each (var VAR:Variable in collection) {
				if (VAR.id == value) {
					return VAR;
				}
			}
			return null;
		}
		
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getVariableIndex(value:Variable):int {
			for each (var VAR:Variable in collection) {
				if (VAR == value) {
					return collection.indexOf(VAR);
				}
			}
			return null;
		}
		
		override public function kill():void {
			for each (var VAR:Variable in collection) {
				this.removeChild(VAR);
			}
			
			collection = null;
		}
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get columnWidth():Number {
			return _columnWidth;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set columnWidth(value:Number):void {
			_columnWidth = value;
		}

	}
}