package view {
	
	//iomports
	import controller.MtVController;
	
	import events.MtVEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import model.EdModel;
	
	import mvc.IController;
	
	import view.assets.CrossBT;
	import view.style.TXTFormat;
	
	/**
	 * 
	 * @author lucaju
	 * 
	 */
	public class InfoBox extends AbstractPanel {
		
		//****************** Properties ****************** ****************** ******************
		
		protected var page						:Sprite;
		protected var infoPage					:TextField;
		protected var baseTextInfo				:TextField;
		protected var editionInfo				:EdModel;
		protected var closeBT					:Sprite;
		protected var _editionID				:int;
		
		
		//****************** Constructor ****************** ****************** ******************
		
		/**
		 * 
		 * @param c
		 * @param reader
		 * @param editionID
		 * 
		 */
		public function InfoBox(c:IController, reader:Boolean = false, editionID:int = 0) {
			super(c);
			
			_editionID = editionID;
			
			//---------- Page ----------
			page = new Sprite();
			this.addChild(page);
			
			
			//---------- info page ----------
			infoPage = new TextField();
			infoPage.selectable = false;
			infoPage.autoSize = "left";
			infoPage.mouseEnabled = false;
			this.addChild(infoPage);
			
			
			//---------- info page ----------
			baseTextInfo = new TextField();
			baseTextInfo.selectable = false;
			baseTextInfo.autoSize = "left";
			baseTextInfo.wordWrap = true;
			baseTextInfo.width = 200;
			
			baseTextInfo.y = 2;
			this.addChild(baseTextInfo);
			
			
			if (reader) {
				loadEditionInfo(editionID);
			} else {
				loadBasetextInfo();
			}
			
		}
		
		
		//****************** PROTECTED METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * 
		 */
		protected function loadBasetextInfo():void {
			
			//---------- Page ----------
			page.graphics.beginFill(0xFFFFFF);
			page.graphics.drawRect(0,0,50,70);
			page.graphics.endFill();
			
			//---------- info page ----------
			infoPage.x = 2;
			infoPage.y = 2;
			infoPage.text = "F1\n1963";
			infoPage.setTextFormat(TXTFormat.getStyle("InfoBox Basetext"));
			
			//---------- info page ----------
			baseTextInfo.text = "THE FIRST FOLIO, 1623\nMr. William Shakespeares Comedies, Histories, & Tragedies.";
			baseTextInfo.setTextFormat(TXTFormat.getStyle("InfoBox Basetext"));
			baseTextInfo.x = page.x + page.width + 5;
			
		}
		
		/**
		 * 
		 * @param editionID
		 * 
		 */
		protected function loadEditionInfo(editionID:int):void {
			
			if (editionID != 0) {
				//load close BT
				closeBT = new CrossBT(0xAAAAAA);
				closeBT.x = 7;
				closeBT.y = 9;
				this.addChild(closeBT)
				closeBT.buttonMode = true;
				closeBT.addEventListener(MouseEvent.CLICK, _click);
				
				//get info
				editionInfo = EdModel(MtVController(this.getController()).getEdition(editionID));
				
				//---------- info page ----------
				var string:String = editionInfo.abbreviation + " (" + editionInfo.date + ")";
				infoPage.text = string;
				infoPage.x = closeBT.x + (closeBT.width/2);
				
			} else {
				infoPage.text = "F1 (1963)";
				infoPage.x = 1;
			}
			
			//style
			infoPage.setTextFormat(TXTFormat.getStyle("InfoBox Edition"));
			
			infoPage.y = 1;
			
			//---------- Page ----------
			page.graphics.beginFill(0xFFFFFF);
			page.graphics.drawRect(0,0,infoPage.x + infoPage.width + 2,infoPage.height);
			page.graphics.endFill();
		}
		
		//****************** PROTECTED EVENTS ****************** ****************** ******************
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function _click(e:MouseEvent):void {
			var data:Object = {editionID:editionID};
			this.dispatchEvent(new MtVEvent(MtVEvent.KILL, data));
		}

		
		//****************** PUBLIC METHODS ****************** ****************** ******************
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get editionID():int {
			return _editionID;
		}

	}
}