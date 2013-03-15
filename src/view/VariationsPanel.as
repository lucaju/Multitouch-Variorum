package view {
	
	//imports
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import model.VarModel;
	import model.VariationsModel;
	
	import mvc.IController;
	
	import view.util.scroll.Scroll;
	
	public class VariationsPanel extends AbstractPanel {
		
		//properties
		private const _maxHeight:int = 450;
		
		private var url:URLRequest;
		private var loader:URLLoader;
		
		private var container:Sprite;
		private var containerMask:Sprite;
		
		private var variation:VariationItem;
		
		private var scroll:Scroll;
		private var scrolling:Boolean = false;
		
		private var variationsCollections:Array;
		
		
		
		public function VariationsPanel(c:IController) {
			super(c);
			
			super.init("Variations");
			
			//get model through controlles
			var m:VariationsModel = VariationsModel(MtVController(this.getController()).getModel("variations"));
			
			//--------- Load editions		
			MtVController(this.getController()).loadVariations();
			super.addPreloader();
			
			//add listeners
			m.addEventListener(MtVEvent.COMPLETE, _complete);	
	
		}
		
		override protected function _complete(e:MtVEvent):void {
			//remove preloader
			super.removePreloader();
			
			//get data
			var vars:Array = e.parameters.data;
			
			//init
			variationsCollections = new Array();
			
			container = new Sprite();
			container.y = 30;
			this.addChild(container);
			
			//loop in the witnessess
			var posY:Number = 0;
			
			for each (var VAR:VarModel in vars) {

				variation = new VariationItem(VAR.id);
				variation.line = VAR.line;
				variation.lineEnd = VAR.lineEnd;
				variation.xmlTarget = VAR.xmlTarget;
				variation.source = VAR.source;
				variation.variant = VAR.variant;
				variation.type = VAR.type;
				
				variation.y = posY;
				container.addChild(variation);
				
				variation.init();
					
				variationsCollections.push(variation);
				
				posY += variation.height + 10;
			}
			
			testForScroll();
			
			
		}
		
		override protected function testForScroll(contructor:Boolean = true, diff:Number = 0):void {
			
			if (container.height + diff > _maxHeight) {
				scrolling = true;
				
				//bg
				var bg:Sprite = new Sprite();
				bg.graphics.beginFill(0xFFFFFF,0);
				bg.graphics.drawRect(0,0,container.width,container.height);
				bg.y = 30;
				this.addChildAt(bg,0);
				
				//mask for container
				containerMask = new Sprite();
				containerMask.graphics.beginFill(0xFFFFFF,0);
				containerMask.graphics.drawRect(container.x,container.y,this.width,_maxHeight);
				this.addChild(containerMask);
				container.mask = containerMask
					//containerMask = new BlitMask(container, container.x, container.y, this.width, _maxHeight, true);
				
				//add scroll system
				scroll = new Scroll();
				scroll.x = this.width - 6;
				scroll.y = container.y;
				this.addChild(scroll);
				
				scroll.direction = scroll.VERTICAL;
				scroll.target = container;
				scroll.offset = 30;
				scroll.maskContainer = containerMask;
				
			}
			
		}
	}
}