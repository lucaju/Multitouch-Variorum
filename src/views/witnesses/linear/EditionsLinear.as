package views.witnesses.linear {
	
	//imports
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import controller.MtVController;
	
	import models.edition.EditionModel;
	
	import mvc.AbstractView;
	import mvc.IController;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class EditionsLinear extends AbstractView {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var bg							:Sprite;
		protected var editionsCollection			:Array;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * 
		 */
		public function EditionsLinear(c:IController) {
			super(c);
		}
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		public function init(data:Array):void {
			
			editionsCollection = new Array();
			
			var mtvController:MtVController = MtVController(this.getController());
			
			//loop in the witnessess
			var edition:EditionLinear;
			var yearSep:YearSeparator;
			var posX:Number = 10;
			var date:Number = 0;
			
			for each (var ed:EditionModel in data) {
			
				//1. Create new edition
				edition = new EditionLinear(this.getController(), ed.id);
				
				//1.1 save datea
				var edDate:Number = ed.date;
				var numVariations:int = ed.numVariations;
				
				//2. num variations
				if (numVariations == -1) numVariations = mtvController.getNumVariationsByEdition(ed.id);
				
				//3. init
				edition.init(ed.abbreviation, numVariations);
				
				//4. test date
				if (date == 0) date = Math.floor(edDate/100);
				var dateToTest:Number = edDate/100;
				if (dateToTest >= date) {
					//add year separator
					yearSep = new YearSeparator(date*100)
					this.addChild(yearSep);
					
					yearSep.x = posX - (edition.width/8); 
					
					editionsCollection.push(yearSep);
				}
				
				date = Math.ceil(edDate/100);
					
				//5.position
				edition.x = posX;
				
				//6. highlight
				if (mtvController.editionID(edition.id)) edition.open(true);
				
				//Finalize
				this.addChild(edition);
				editionsCollection.push(edition);
				
				posX += edition.width + (edition.width/4);
			}
			
			edition = null;
			
			//6. BG
			bg = new Sprite();
			bg.graphics.beginFill(0xFFFFF0,0);
			bg.graphics.drawRect(0,0,this.width + 15, this.height);
			this.addChildAt(bg,0);
			
			//listeners
			this.addEventListener(MouseEvent.CLICK, editionClick);
			
		}
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function editionClick(event:MouseEvent):void {
			if (event.target is EditionLinear) {
				adapt(EditionLinear(event.target));	
			}
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		protected function adapt(target:EditionLinear):void {
			
			var posX:Number = 10;
			
			for each (var obj:Sprite in editionsCollection) {
				
				if (obj is EditionLinear) {
					
					var edition:EditionLinear = EditionLinear(obj);
					//edition.x = posX;
					
					TweenMax.to(obj,.5,{x:posX});
					
					posX += edition.currentWidth + (edition.MIN_WIDTH/4);
					
				} else {
					//obj.x = posX - (this.getEdition(1).MIN_WIDTH/8);
					TweenMax.to(obj,.5,{x:posX - (this.getEdition(1).MIN_WIDTH/8)});
				}
				
			}
			
			//adjust
			bg.width = posX + 15;
		}
		
		//****************** PUBLIC EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */
		public function getEdition(value:int):EditionLinear {
			for each (var obj:Sprite in editionsCollection) {
				if (obj is EditionLinear) {
					var edition:EditionLinear = EditionLinear(obj);
					if (edition.id == value) {
						return edition;
					}
				}
			}
			
			return null;
		}
		
		/**
		 * 
		 * @param editionID
		 * 
		 */
		public function editionOpened(editionID:int):void {
			var edition:EditionLinear = getEdition(editionID);
			edition.open(true);
		}

	}
}