package views.witnesses.circular {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import models.edition.EditionModel;
	
	import mvc.AbstractView;
	
	import views.witnesses.circular.timeline.TimelineCircular;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionsCircular extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var _target						:EditionsMenuCircular;
		
		protected var _maxRadius					:Number = 150;
		
		protected var _minSlotLength				:Number = 0;		//0 - show all
		
		protected var spiral						:Boolean = false;
		
		protected var _gapRate						:Number = 1/5;
		protected var gapLength						:Number	= 10;
		protected var slotLength					:Number = 30;
		
		protected var scrollRate					:Number	= 1;
		
		protected var currentEditionSelected		:EditionCircular;
		
		protected var editionsCollection			:Array;
		protected var editionsContainer				:Sprite;
		
		protected var timeline						:TimelineCircular;
		
		
		//****************** Constructor ****************** ****************** ******************

		
		
		/**
		 * 
		 * @param target_
		 * 
		 */
		public function EditionsCircular(target_:EditionsMenuCircular) {
			_target = target_;
			super(target.getController());
			timeline = new TimelineCircular();
			editionsCollection = new Array();
			editionsContainer = new Sprite();
			this.addChild(editionsContainer)
		}
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function init(data:Array):void {
			
			//1. Controller
			var mtvController:MtVController = MtVController(this.getController());
			
			//2. Starting vars to loop
			var edition:EditionCircular;
			var numVariations:int
			
			var startAngle:Number = 0;
			var iterationAngle:Number = startAngle;
			
			//2.1 Slot Length
			slotLength = (360/data.length);
			if (slotLength < _minSlotLength) slotLength = minSlotLength;
			
			//2.3 gap
			gapLength = slotLength * gapRate;
			if (gapLength > 5) gapLength = 5;
			
			//2.4 Arc Lenght
			var arcLength:Number = slotLength - gapLength;
			
			var iRadius:Number = maxRadius - 50;
			var scale:Number = 1;
			var sz:Number = 1;
			var zk:Number = 30;
			var k:Number = 1 + (Math.PI / 100);
			
			//3. loop in the witnessess
			for each (var ed:EditionModel in data) {
				
				//3.1. Create new edition
				edition = new EditionCircular(this.getController(), ed.id);
				edition.radius = iRadius;
				
				//3.2. num variations
				numVariations = ed.numVariations;
				if (numVariations == -1) numVariations = mtvController.getNumVariationsByEdition(ed.id);
				
				//3.3. init
				if (spiral) {
					edition.init(iterationAngle, arcLength, 0, ed.abbreviation, numVariations);
					edition.scaleX = edition.scaleY *= scale;
					//edition.z = -sz;
					//trace (sz)
				} else {
					edition.init(iterationAngle, arcLength, gapLength, ed.abbreviation, numVariations);
				}
				
				//3.4. add year to timeline
				timeline.addYear(ed.date);	
				
				//3.5. highlight
				if (mtvController.editionID(edition.id)) edition.open(true);
				
				//3.6.Finalize
				editionsContainer.addChildAt(edition,0);
				editionsCollection.push(edition);
				
				//3.7. animation
				if (spiral) {
					TweenMax.from(edition,1,{scaleX:0, scaleY:0, delay:edition.id*0.01, ease:Circ.easeOut});
				} else {
					if (iterationAngle < 360) {
						TweenMax.from(edition,1,{scaleX:0, scaleY:0, delay:edition.id*0.01, ease:Circ.easeOut});
					} else {
						edition.scaleX = edition.scaleY = 0;
						edition.visible = false;
					}
				}
				
				iterationAngle += slotLength;
				//iRadius *= k;
				scale *= k;
				sz += zk;
			}
			
			
			//8. Create timeline ----------
			scrollRate = iterationAngle/360;
			this.addTimeline();
			
			//9. listeners
			this.addEventListener(MouseEvent.CLICK, editionClick);
			timeline.addEventListener(MtVEvent.UPDATE, timelineScroll);
			
			//10. clean
			edition = null;
			mtvController = null;
			numVariations = 0;
			startAngle = 0;
			iterationAngle = 0;
			arcLength = 0;
			
		}	
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function editionClick(event:MouseEvent):void {

			if (event.target is EditionCircular) {
				
				//set vars
				var target:EditionCircular = EditionCircular(event.target);
				
				
				if (currentEditionSelected) {
					// deselect 
					currentEditionSelected.select(false);
				
					// select if diferent
					if (currentEditionSelected != target) {
						currentEditionSelected = target;
						currentEditionSelected.select(true);
					} else {										
						currentEditionSelected = null;
					}
					
				} else {
					currentEditionSelected = target;
					currentEditionSelected.select(true);
				}
				
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function timelineScroll(event:MtVEvent):void {
			event.stopImmediatePropagation();
			var angle:Number = event.parameters.angle * scrollRate;
			
			if (spiral) {
				scrollSpiral(angle)
			} else {
				scrollCircle(angle);
			}
		}	
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		protected function scrollSpiral(angle:Number):void {
			
			var editionAngle:Number;
			var k:Number = ((angle/360)-1);
			
			//editionsContainer.z = angle;
			
			if (angle > 10 && angle < (360 *(scrollRate-1)) + 10) {
				
				angle = -angle;
				
				editionsContainer.scaleX = editionsContainer.scaleY = 1- (k/scrollRate);
				editionsContainer.rotationZ = angle;
				
				
				
				for each (var editionCircular:EditionCircular in editionsCollection) {
					editionAngle = angle + editionCircular.startPos;
					
					var angleVanish:Number = -720; // 0
					
					if (editionCircular.id == 8) {
						trace (editionAngle)
					}
					
					if (editionAngle < angleVanish) {
						if (editionCircular.alpha > 0) {
							editionCircular.alpha -= .1;
						} else if (editionCircular.alpha <= 0) {
							editionCircular.alpha = 0;
							editionCircular.visible = false;
						}
					}
					
					if (editionAngle >= angleVanish) {
						if (editionCircular.alpha < 1) {
							editionCircular.alpha += .1;
							editionCircular.visible = true;
						} else if (editionCircular.alpha >= 1) {
							editionCircular.alpha = 1;
							editionCircular.visible = true;
						}
					}
					
				}
			}
			
			/*
			if (angle > 10 && angle < (360 *(scrollRate-1)) + 10) {
				
				//trace (angle, 360 *(scrollRate-1))
				
				//rotate counter-clockwise
				angle = -angle;
				
				for each (var editionCircular:EditionCircular in editionsCollection) {
					
					editionAngle = angle + editionCircular.startPos;
					
					editionCircular.rotation = angle;
					
				
					//lesser than 0 - hide
					if (editionAngle < 0) {
						if (editionCircular.scaleX > 0) {
							editionCircular.scaleX = editionCircular.scaleY -= k;
						} else if (editionCircular.scaleX <= 0) {
							editionCircular.scaleX = editionCircular.scaleY = 0;
							editionCircular.visible = false;
						}
					}
					
					// between 0 and 360 - show
					if (editionAngle >= 0 && editionAngle <= 360) {
						if (editionCircular.scaleX < 1) {
							editionCircular.scaleX = editionCircular.scaleY += k;
							editionCircular.visible = true;
						} else if (editionCircular.scaleX >= 1) {
							editionCircular.scaleX = editionCircular.scaleY = 1;
							editionCircular.visible = true;
						}
					}
					
					//more than 360 - hide
					if (editionAngle > 360) {
						if (spiral) {
							editionCircular.scaleX = editionCircular.scaleY += k;
						} else {
							if (editionCircular.scaleX >= 0) {
								editionCircular.scaleX = editionCircular.scaleY -= .1;
							} else if (editionCircular.scaleX < 0) {
								editionCircular.scaleX = editionCircular.scaleY = 0;
								editionCircular.visible = false;
							}
						}
					}
					
				}
					
					
				//Beginning 
			}
					
			*/
		}
		
		/**
		 * 
		 * @param angle
		 * 
		 */
		protected function scrollCircle(angle:Number):void {
			
			var editionAngle:Number;
			
			
			if (angle > 10 && angle < (360 *(scrollRate-1)) + 10) {
				
				//trace (angle, 360 *(scrollRate-1))
				
				//rotate counter-clockwise
				angle = -angle;
				
				for each (var editionCircular:EditionCircular in editionsCollection) {
					
					editionAngle = angle + editionCircular.startPos;
					editionCircular.rotation = angle;
					
					
					//lesser than 0 - hide
					if (editionAngle < 0) {
						if (editionCircular.scaleX > 0) {
							editionCircular.scaleX = editionCircular.scaleY -= .1;
						} else if (editionCircular.scaleX <= 0) {
							editionCircular.scaleX = editionCircular.scaleY = 0;
							editionCircular.visible = false;
						}
					}
					
					// between 0 and 360 - show
					if (editionAngle >= 0 && editionAngle <= 360) {
						if (editionCircular.scaleX < 1) {
							editionCircular.scaleX = editionCircular.scaleY += .1;
							editionCircular.visible = true;
						} else if (editionCircular.scaleX >= 1) {
							editionCircular.scaleX = editionCircular.scaleY = 1;
							editionCircular.visible = true;
						}
					}
					
					//more than 360 - hide
					if (editionAngle > 360) {
						if (spiral) {
							editionCircular.scaleX = editionCircular.scaleY += .1;
						} else {
							if (editionCircular.scaleX >= 0) {
								editionCircular.scaleX = editionCircular.scaleY -= .1;
							} else if (editionCircular.scaleX < 0) {
								editionCircular.scaleX = editionCircular.scaleY = 0;
								editionCircular.visible = false;
							}
						}
					}
				}
				
				//Beginning 
			} else if (angle < 10) {
				for each (editionCircular in editionsCollection) {
					editionCircular.rotation = 0;
					
					if (editionCircular.startPos >= 360) {
						editionCircular.scaleX = editionCircular.scaleY = 0;
						editionCircular.visible = false;
					} else {
						editionCircular.scaleX = editionCircular.scaleY = 1;
						editionCircular.visible = true;	
					}
				}
				
				//ending
			} else if (angle > (360 *(scrollRate-1)) + 10) {
				for each (editionCircular in editionsCollection) {
					editionCircular.rotation = -(360 *(scrollRate-1)) + slotLength;
					
					if (editionCircular.startPos < 360 *(scrollRate-1)) {
						
						editionCircular.scaleX = editionCircular.scaleY = 0;
						editionCircular.visible = false;
					} else {
						editionCircular.scaleX = editionCircular.scaleY = 1;
						editionCircular.visible = true;	
					}
					
				}
			}
			
		}
		
		/**
		 * 
		 * 
		 */
		protected function addTimeline():void {
			
			var timelineLocation:String = "inner";
			
			switch(timelineLocation) {
				case "inner":
					timeline.minRadius = target.header.maxRadius + 5;
					timeline.thickness = 10;
					break;
				
				case "outter":
					timeline.minRadius = this.maxRadius + 5;
					timeline.thickness = 30;
					break;
			}
			
			timeline.createTimeline();
			this.addChild(timeline);
			
			if (scrollRate > 1) timeline.addScroll(scrollRate);
			
			timelineLocation = null;
		}
		
		//****************** PUBLIC EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getEdition(value:int):EditionCircular {
			for each (var editionCircular:EditionCircular in editionsCollection) {
				if (editionCircular.id == value) return editionCircular;
			}
			return null;
		}
		
		/**
		 * 
		 * @param editionID
		 * 
		 */
		public function editionOpened(editionID:int):void {
			var edition:EditionCircular = getEdition(editionID);
			if (currentEditionSelected == edition) currentEditionSelected = null;
			if (edition.selected) edition.select(false);
			edition.open(true);
		}
		
		
		//****************** GETTERS // SETTERS ****************** ****************** ******************

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get target():EditionsMenuCircular {
			return _target;
		}
		
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
		public function get minSlotLength():Number {
			return _minSlotLength;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set minSlotLength(value:Number):void {
			_minSlotLength = value;
		}

		/**
		 * 
		 * @return 
		 * 
		 */
		public function get gapRate():Number {
			return _gapRate;
		}


	}
}