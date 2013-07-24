package views.readerWindow {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.TweenProxy;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.system.System;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import models.baseText.BaseTextModel;
	import models.edition.EditionModel;
	import models.reader.VariationVariableModel;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	import views.readerWindow.panels.PanelEvent;
	import views.readerWindow.reader.Reader;
	import views.readerWindow.reader.ReaderEvent;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class ReaderWindow extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _minWidth				:int = 335;
		protected var _normalWidth			:int = 405;
		protected var _maxWidth				:int = 605;
		
		protected var normalHeight			:int = 465;
		
		protected var _currentWidth			:int = normalWidth;
		protected var _currentHeight		:int = normalHeight;
		
		protected var _id					:int;
		
		protected var _editionID			:int;
		
		protected var loaded				:Boolean = false;
		protected var expanded				:Boolean = false;
		protected var locked				:Boolean = false;
		
		protected var background			:Sprite;
		protected var header				:ReaderHeader;
		protected var reader				:Reader;
		protected var readerViz				:ReaderViz;						//Navvigation Panel
		protected var sideBar				:ReaderSideBar;
		
		
		//****************** Contructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * @param editionID_
		 * 
		 */
		public function ReaderWindow(c:IController, editionID_:int = 0) {
			super(c);
	
			//save data
			editionID = editionID_;		
			this.name = "Reader " + editionID_;
				
			//add readers to collections
			_id = MtVController(this.getController()).addReader(editionID);
			
			//add background
			background = new Sprite();
			background.graphics.beginFill(0xFFFFFF,.9);
			background.graphics.drawRoundRect(0,0,currentWidth,normalHeight,4);
			background.graphics.endFill();
			//this.blendMode = "multiply";
			
			this.addChild(background);
			
			//add Glow
			var filter:GlowFilter = new GlowFilter(0x333333,0.4, 8, 8, 2);
			background.filters = [filter];
			
			//listeners
			this.addEventListener(TransformGestureEvent.GESTURE_ROTATE, _rotate);
			
			//--------- Load base text or edition text
			
			var data:XML = MtVController(this.getController()).loadBaseText();
			
			if (!data) {
				var m:BaseTextModel = BaseTextModel(MtVController(this.getController()).getModel("baseText"));
				m.addEventListener(MtVEvent.COMPLETE, _complete);	
				m = null;
			} else {
				initialize(data);
			}
			
		}
		
		
		//****************** PROTECTED INITIALIZE ****************** ****************** ******************
		
		protected function initialize(xml:XML):void {
			
			this.loaded = true;
			
			//1. get editon info
			var editionInfo:EditionModel = EditionModel(MtVController(this.getController()).getEdition(editionID));
			
			//2. add Header
			header = new ReaderHeader(this);
			header.initialize(editionInfo);
			this.addChild(header);
			
			//3. add reader
			reader = new Reader();
			this.addChild(reader);
			reader.init(xml);
			
			//4. add Viz
			readerViz = new ReaderViz(this);
			readerViz.hMax = this.height;
			
			this.addChild(readerViz);
			
			readerViz.initialize();
			readerViz.y = header.height + 2;
			
			//5 position position
			reader.x = readerViz.width;
			reader.y = header.height;
			
			//5. add sidebar
			sideBar = new ReaderSideBar(this);
			sideBar.x = reader.x + reader.width - 1;
			sideBar.y = header.height;
			
			sideBar.maxHeight = this.normalHeight - header.maxHeight;
			
			this.addChild(sideBar);
			sideBar.init();
			
			//6.Check Edition's variation
			//  It there are variations, replace them in the base text.
			if (this.editionID > 0) {
				var variationsArray:Array = MtVController(this.getController()).getVariationsByEditionID(editionID); //get data
				MtVController(this.getController()).setVariationToReader(this.id, variationsArray);						//save data
				for each (var variationVariable:VariationVariableModel in variationsArray) {
					updateVariable(variationVariable.variableID, variationVariable.variationText);
				}
			}
			
			//7. listeners
			this.addEventListener(MtVEvent.SELECT, expendRequest);
			this.addEventListener(PanelEvent.CELL_SELECTED, cellSelected);
			
			reader.addEventListener(Event.SCROLL, readerScrolling);
			reader.addEventListener(ReaderEvent.VARIABLE_SELECTED, variableSelected);
			
			//8. dispatch event
			this.dispatchEvent(new MtVEvent(MtVEvent.COMPLETE));
		
		}					
		
		
		//****************** PRIVATE METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param obj
		 * 
		 */
		private function killChild(obj:DisplayObject):void {
			this.removeChild(obj);
		}
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _complete(e:MtVEvent):void {
			if (e.parameters.editionID == editionID && !this.loaded) {
				var xml:XML = e.parameters.text;
				initialize(xml);	
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function expendRequest(event:MtVEvent):void {
			expanded = !expanded;
			this.expand(expanded);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function readerScrolling(e:Event):void {
			readerViz.updateScrollPosition(reader.scrollPosition)	
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _rotate(event:TransformGestureEvent):void {
			var proxy:TweenProxy = TweenProxy.create(this);	
			proxy.registration = new Point(event.stageX, event.stageY);
			proxy.rotation += event.rotation;
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _startDrag(e:MouseEvent):void {
			this.startDrag();
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _stopDrag(e:MouseEvent):void {
			this.stopDrag();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function variableSelected(event:ReaderEvent):void {
			
			event.stopPropagation();
			
			if (event.type == "variable_selected") {
				
				//variations
				sideBar.update("variables",event.targetID);

				//commentaries
				var lineNumber:int = MtVController(this.getController()).getVariableLine(event.targetID);
				sideBar.update("commentaries",lineNumber);
			}
			
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function cellSelected(event:PanelEvent):void {
			
			switch (event.phase) {
				
				case "scrollReader":
					event.stopImmediatePropagation();
					
					if (event.parameters.eventSource == "variable") {
						reader.scrollToVariable(event.targetID);
					} else if (event.parameters.eventSource == "comment") {
						reader.scrollToLine(event.parameters.lineNumber);
					}
					
					break;
				
				case "changeVariable":
					event.stopImmediatePropagation();
					updateVariable(event.targetID, event.parameters.variationText);
					//save to reader model
					MtVController(this.getController()).setReaderVariation(this.id, event.targetID, event.parameters.variationUID, event.parameters.variationText);
					break;
				
				case "loadReaderVariations":
					event.stopImmediatePropagation();
					
					MtVController(this.getController()).getReaderVariations(this.id);
					
					break;
				
			}
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		protected function expand(expanded:Boolean):void {
			
			//change parameter
			if (expanded) {
				currentWidth = maxWidth;
			} else {
				currentWidth = normalWidth;
			}
			
			//background
			TweenMax.to(background,.6,{width:currentWidth});
			
			//change header
			header.expand(expanded);
			
			//variation Panel
			sideBar.expand();
			
		}
		
		/**
		 * 
		 * @param targetID
		 * @param variationText
		 * 
		 */
		protected function updateVariable(targetID:int, variationText:String):void {
			reader.updateVariable(targetID, variationText);
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param valueW
		 * @param valueH
		 * 
		 */
		public function setDimensions(valueW:Number, valueH:Number):void {
			normalWidth = valueW;
			normalHeight = valueH;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function setScrollReader(value:Number):void {
			reader.scrollPosition = Math.round(value);
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getReaderHeight():Number {
			return reader.getFlowHeight();
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function showNav(value:Boolean):void {
			
			if (value) {
				TweenMax.from(readerViz,1,{x:readerViz.x - readerViz.width - 10});
			} else {
				//TweenMax.to(readerViz,1,{x:readerViz.x - readerViz.width - 10, onComplete:removeChild, onCompleteParams:[readerViz]});
				TweenMax.to(readerViz,1,{x:readerViz.x - readerViz.width - 10, onComplete:removeChild, onCompleteParams:[readerViz]});
			}
	
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function showVariants(value:Boolean):void {
			reader.showVariations(value);	
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function showLineNumber(value:Boolean):void {
			reader.showLineNumbers(value);	
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getPlainTextLength():int {
			return reader.getPlainText().length;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getNotes():Array {
			return reader.getVarPositions();
		}
		
		/**
		 * 
		 * 
		 */
		public function KILL():void {
			
			//do it needs readers ID?
			
			//kill panels
			sideBar.KILL();
			
			//Force Run Garbage COllector
			System.gc();
			
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
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get editionID():int {
			return _editionID;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set editionID(value:int):void {
			_editionID = value;
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
		public function get normalWidth():int {
			return _normalWidth;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set normalWidth(value:int):void {
			_normalWidth = value;
		}
		
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
		public function get currentHeight():int {
			return _currentHeight;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set currentHeight(value:int):void {
			_currentHeight = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get isExpanded():Boolean {
			return expanded;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getAbbreviation():String {
			return MtVController(this.getController()).getEditionInfo(editionID, "abbreviation");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getAuthor():String {
			return MtVController(this.getController()).getEditionInfo(editionID, "author");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getTitle():String {
			return MtVController(this.getController()).getEditionInfo(editionID, "title");
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get getYear():Number {
			return MtVController(this.getController()).getEditionInfo(editionID, "year");
		}

		
	}
}