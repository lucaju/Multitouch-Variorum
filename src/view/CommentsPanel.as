package view {
	
	//imports
	import controller.MtVController;
	
	import events.MtVEvent;
	
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.CommentModel;
	import model.CommentsModel;
	
	import mvc.IController;
	
	import view.util.scroll.Scroll;
	
	public class CommentsPanel extends AbstractPanel {
		
		//properties
		private const _maxHeight:int = 450;
		
		private var url:URLRequest;
		private var loader:URLLoader;
		
		private var container:Sprite;
		private var containerMask:Sprite;
		
		private var comment:CommentItem;
		
		private var scroll:Scroll;
		private var scrolling:Boolean = false;
		
		private var variationsCollections:Array;
		
		
		
		public function CommentsPanel(c:IController) {
			super(c);
			
			super.init("Comments");
			
			//get model through controlles
			var m:CommentsModel = CommentsModel(MtVController(this.getController()).getModel("comments"));
			
			//--------- Load editions		
			MtVController(this.getController()).loadComments();
			super.addPreloader();
			
			//add listeners
			m.addEventListener(MtVEvent.COMPLETE, _complete);	
	
		}
		
		override protected function _complete(e:MtVEvent):void {
			//remove preloader
			super.removePreloader()
			
			//get data
			var vars:Array = e.parameters.data;
			
			//init
			variationsCollections = new Array();
			
			container = new Sprite();
			container.y = 30;
			this.addChild(container);
			
			//loop in the witnessess
			var posY:Number = 0;
			
			for each (var comm:CommentModel in vars) {

				comment = new CommentItem(comm.id);
				comment.lineStart = comm.lineStart;
				comment.lineEnd = comm.lineEnd;
				comment.source = comm.source;
				comment.author = comm.author;
				comment.referenceStart = comm.referenceStart;
				comment.referenceEnd = comm.referenceEnd;
				comment.text = comm.text;
				
				comment.y = posY;
				container.addChild(comment);
				
				comment.init();
					
				variationsCollections.push(comment);
				
				posY += comment.height + 10;
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