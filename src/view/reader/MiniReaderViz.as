package view.reader {
	
	//imports
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import view.ReaderPanel;
	
	public class MiniReaderViz extends Sprite {
		
		//properties
		private var _target:ReaderPanel
		
		private var plainTextLength:int;											//store text length in character number
		private var positions:Array;												//store refrence positions
		
		private var viz:Sprite;
		
		private var chunkCollection:Array;											//store chunks
		private var chunk:Shape;													//iterate chunk
		
		private var _hMax:int = 560;												//max height
		private var _wMax:int = 33;													//max width
		private var _numColumns:int = 1;											//number of columns
		
		private var lineWeight:Number = 1;											//line weigth
		private var columnGap:int = 5;												//gap between columns
			
		private var pixRate:Number;													//pixelrate - store the sample rate based in the text length and the max parameters
		
		private var generalColor:uint = 0xCCCCCC;
		private var highlightColor:uint = 0xFFFF00;
		
		private var animation:Boolean = true;
		
		private var scrollBar:ReaderScrollBar;
		
		public function MiniReaderViz(target_:ReaderPanel) {
			
			_target = target_;

		}
		
		// ------------- GETTERS AND SETTERS
		
		public function get target():ReaderPanel {
			return _target;
		}
		
		public function set target(value:ReaderPanel):void {
			_target = value;
		}
		
		public function get numColumns():int {
			return _numColumns;
		}

		public function set numColumns(value:int):void {
			_numColumns = value;
		}

		public function get wMax():int {
			return _wMax;
		}

		public function set wMax(value:int):void {
			_wMax = value;
		}

		public function get hMax():int {
			return _hMax;
		}

		public function set hMax(value:int):void {
			_hMax = value;
		}
		
		public function get numLines():int {
			return Math.floor(hMax/2);
		}
		
		//--------- METHODS
		
		public function initialize():void {
			
			updateViz();
			
			scrollBar = new ReaderScrollBar();
			scrollBar.target = target;
			scrollBar.track = this;
			scrollBar.initialize();
			this.addChild(scrollBar);
			
		}
		
		public function updateScrollPosition(value:Number):void {
			scrollBar.update(value);
		}
			
		//public function updateViz(notes:Array):void {
		public function updateViz():void {
			
			//clear previous
			clear();
			
			//container
			viz = new Sprite();
			this.addChild(viz);
			
			var widthUtil:Number = wMax - ((numColumns-1) * columnGap);				//define the width util for the visualiation
			var columnWidth:Number = widthUtil / numColumns;						//define column width
				
			//get plaintext
			plainTextLength = target.getPlainTextLength();
			pixRate = plainTextLength / (numLines * widthUtil);			//pixelrate - store the sample rate based on the text length and the max parameterss
			
			//array to store references start and end position
			positions = target.getNotes();												

			
			//loop on every character in the text
			var pixColorArray:Array = new Array();									//Array of sample pixels in the visualization
			var color:uint = generalColor;											//iteration color bucker
			var collectNotRenderPix:int = 0;
			
			for (var char:int = 0; char <= plainTextLength; char++) {
				
				for (var iRef:int = 0; iRef < positions.length; iRef++) {							//loop in the references start and end position
					
					//check and change color when a reference start or end
					if (char == positions[iRef].start) {
						color = highlightColor;	
					//	trace ("start highlight: " + char)
						
					} else if (char == positions[iRef].end) {
						color = generalColor;
						//trace ("end highlight: " + char)
					}
				}
				
				
				//!!!restrict to the max number od pixels
				//if (char - ((char+collectNotRenderPix) * pixRate) < -1) {
					pixColorArray.push(color);
				//}
					
			}
			
			
			chunkCollection = new Array()
			var actualColumn:int = 0;												//column position
			var px:int = 0;															//carret - Drawer x postion - used to start a chunk								
			var py:int = 0;															//drawer y position - used to break lines when the chunk is to long
			var cx:int = 0;															//chunk x position - used to start a new chunk
			var cy:int = 0;															//chunk y position - used to start a new chunk
			var l:int = 0;															//chunk length counter
			var currentColor:uint = pixColorArray[0];								//chunk color - store the current color
			
			
			//loop columns
			// this loop has one extra "lap" in order to close the circuit
			var i:int = 0;
			for (var pc:int; pc <= pixColorArray.length; pc++) {
				
				var cor:uint = pixColorArray[pc];
				
				if (cor == currentColor) { 											//adding pixels for a chunk
					
					l++;
					
				} else {															//draw chunk

					chunk = new Shape();
					chunk.x = cx;
					chunk.y = cy;
					chunk.graphics.lineStyle(lineWeight,currentColor,1,true);
					chunk.graphics.beginFill(generalColor);
					chunk.graphics.moveTo(px,0);
					
					
					var lineRelLength:int = px + l;									//relative size of the chunk to be draw. Sum of the current possiton and length.
					var numLinesNeed:int = Math.ceil(lineRelLength/columnWidth);	//number of lines necessary to draw the current chunk
					var lineDrawing:int;											//chunk to draw use in the iteration
					var pxOffset:Number = 0;
					
					for (i = 0; i < numLinesNeed; i++) {
						
						if (i==1) {  												//first line
							var spaceInCurrentLine:int = columnWidth - px;			//space available in current line to begin to draw the chunk
							lineDrawing = spaceInCurrentLine;						//use available space in current line to begin to draw the chunk
						}
						
						if (lineRelLength > columnWidth) {							//if chunk to be draw is greater than the max width
							lineDrawing = columnWidth;								//Take the max width size
						} else {									
							lineDrawing = lineRelLength;							//else, take the rest
						}
						
						//draw the line
						chunk.graphics.moveTo(px + pxOffset,py)
						chunk.graphics.lineTo(lineDrawing + pxOffset,py);
						
						lineRelLength -= lineDrawing;								//update chunk to be draw
						
						//update variables id the loops continues
						if (numLinesNeed > 1 && i != numLinesNeed-1) {
							cy += lineWeight * 2;
							px = 0;
							py += lineWeight * 2;
						}
						
						//update px in the last iteration
						if (i == numLinesNeed-1) {
							px = lineDrawing;
						}
						
						if (cy >= _hMax) {
							actualColumn++;
							cx = (columnWidth + columnGap) * (actualColumn);
							cy = 0;
							pxOffset = columnWidth + columnGap;
							px = 0;
							py = -chunk.y;
						}
						
					}
					
					//end chunk draw
					chunk.graphics.endFill();
					
					//add chunk to the screen and the array
					
					viz.addChild(chunk);	
					chunkCollection.push(chunk);
					
					//update variables
					currentColor = cor;
					l = 0;
					py = 0;
					
				}
				
			}
			
			if (animation == true) {
				playAnimation()
			}
			
		}
		
		private function playAnimation():void {
			//animation
			for (var i:int = 0; i < chunkCollection.length; i++) {
				
				if (i % 2 == 0) {
					//TweenMax.from(chunkCollection[i], 2,{colorMatrixFilter:{brightness:-3}, ease:Back.easeOut, delay:i *  0.01});
					//TweenMax.to(chunkCollection[i], 2, {glowFilter:{color:highlightColor, alpha:.4, blurX:4, blurY:4},repeat:1,yoyo:true, delay:i *  0.1});
					
					
				} else {
					//TweenMax.from(chunkCollection[i],2,{alpha:0, delay:i *  0.1});
					//TweenMax.from(chunkCollection[i], 2,{colorMatrixFilter:{brightness:-3}, ease:Back.easeOut, delay:i *  0.01});
					TweenMax.from(chunkCollection[i], 2,{tint:generalColor, ease:Back.easeOut, delay:i *  0.05});
					
				}
				
				//TweenMax.from(chunkCollection[i],2,{width:0, delay:i *  0.2, ease:SlowMo.ease.config(0.7, 0.7)});
				//TweenMax.from(chunkCollection[i],2,{width:0, delay:i *  0.2, ease:Back.easeOut});
			}
		}
	
		public function clear():void {
			
			if (viz) {
				this.removeChild(viz);
				viz = null;
				chunkCollection = null;
			}

		}
	
	}
}