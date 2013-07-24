package views.witnesses.circular.timeline {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import events.MtVEvent;
	
	import views.witnesses.circular.Arc;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class TimelineCircular extends Sprite {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _maxRadius				:Number = 180;
		protected var _minRadius				:Number = 160;
		protected var _thickness				:Number = 10;
		
		protected var periodModelCollection		:Array;
		protected var periodCollection			:Array;
		protected var periodContainer			:Sprite;
		
		protected var periodSplit				:Number	= 100;		//Century

		protected var timelineRoll				:Arc;
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function TimelineCircular() {
			super();
			periodModelCollection = new Array();
		}
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function addPeriod(value:String):TimelinePeriodModel {
			var periodModel:TimelinePeriodModel = new TimelinePeriodModel();
			periodModel.title = value;
			periodModelCollection.push(periodModel);
			return periodModel;
		}
		
		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function addYear(value:Number):void {
			
			//get period
			var yearPeriod:Number = Math.floor(value/periodSplit) * periodSplit;
			var periodModel:TimelinePeriodModel = getPeriodByTitle(yearPeriod.toString())	
			
			if (!periodModel) periodModel = this.addPeriod(yearPeriod.toString());
			
			periodModel.addYear(value);
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getPeriodByTitle(value:String):TimelinePeriodModel {
			for each (var periodModel:TimelinePeriodModel in periodModelCollection) {
				if (periodModel.title == value) return periodModel;
			}
			return null;
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getNumYears():int {
			var count:int = 0;
			for each (var periodModel:TimelinePeriodModel in periodModelCollection) {
				count += periodModel.collection.length;
			}
			return count;
		}
		
		
		/**
		 * 
		 * 
		 */
		public function createTimeline():void {
			
			periodContainer = new Sprite();
			periodContainer.mouseEnabled = false;
			periodContainer.mouseChildren = false;
			this.addChild(periodContainer);
			
			periodCollection = new Array();
			
			var period:TimelineSectionCircular;
			
			var startAngle:Number = 0;
			var iterationAngle:Number = startAngle;
			var radius:Number = maxRadius;
			var numYears:int = this.getNumYears();
			
			var gapLength:Number = 0;
			
			var arcLength:Number;

			var i:int = 0;
			
			for each (var periodModel:TimelinePeriodModel in periodModelCollection) {
				
				arcLength = (periodModel.collection.length/numYears) * 360;
				
				
				period = new TimelineSectionCircular();
				period.radius = this.minRadius+this.thickness;
				period.thickness = this.thickness;
				period.init(iterationAngle, arcLength, gapLength, periodModel.title);
				periodContainer.addChild(period);
				
				iterationAngle += arcLength;
				
				periodCollection.push(period);
				
				TweenMax.from(period,1,{rotation:-90, alpha:0, delay:1+(i*.4), ease:Circ.easeOut});
				
				i++;
			}
		}
		
		/**
		 * 
		 * @param rate
		 * 
		 */
		public function addScroll(rate:Number):void {
			timelineRoll = new Arc();
			timelineRoll.donut = true;
			timelineRoll.color = 0xB47916;
			//timeLineRoll.colorAlpha = .6;
			timelineRoll.innerRadius = this.minRadius;
			timelineRoll.steps = 360/rate;
			timelineRoll.draw(this.minRadius + this.thickness,0,360/rate);
			this.addChild(timelineRoll);
			timelineRoll.blendMode = "hardlight";
			
			TweenMax.from(timelineRoll,1,{rotation:360, alpha:0, delay:1+(periodModelCollection.length*.4), ease:Circ.easeOut});
			
			timelineRoll.buttonMode = true;
			timelineRoll.addEventListener(MouseEvent.MOUSE_DOWN, timelineRollDown);

		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function timelineRollDown(event:MouseEvent):void {
			
			event.stopImmediatePropagation();
			
			timelineRoll.removeEventListener(MouseEvent.MOUSE_DOWN, timelineRollDown);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, timelineRollMove);
			timelineRoll.addEventListener(MouseEvent.MOUSE_UP, timelineRollUp);
			timelineRoll.addEventListener(MouseEvent.RELEASE_OUTSIDE, timelineRollUp);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function timelineRollMove(event:MouseEvent):void {
			
			event.stopImmediatePropagation();
			
			var angle:Number = (Math.atan2(this.mouseY,this.mouseX) * 180/Math.PI) + 90; //angle in rads // tranformed to degrees // rotate -90º
			if (angle < 0) angle += 360;
			
			if (angle <=  360 - timelineRoll.outerRadius + 4) {
				timelineRoll.rotation = angle;
			}
				
			var obj:Object = {angle:angle};
			timelineRoll.dispatchEvent(new MtVEvent(MtVEvent.UPDATE,null,obj));
			
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function timelineRollUp(event:MouseEvent):void{
			
			event.stopImmediatePropagation();
			
			timelineRoll.addEventListener(MouseEvent.MOUSE_DOWN, timelineRollDown);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, timelineRollMove);
			timelineRoll.removeEventListener(MouseEvent.MOUSE_UP, timelineRollUp);
			timelineRoll.removeEventListener(MouseEvent.MOUSE_OUT, timelineRollUp);
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

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set maxRadius(value:Number):void {
			_maxRadius = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get thickness():Number {
			return _thickness;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set thickness(value:Number):void {
			_thickness = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get minRadius():Number {
			return _minRadius;
		}

		/**
		 * 
		 * @param value
		 * 
		 */
		public function set minRadius(value:Number):void {
			_minRadius = value;
		}

		
	}
}