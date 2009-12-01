package conceptsbasic
{
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Ellipse;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class AddingNodes extends Sprite
	{
		public static const SIZE:int=50;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _ellipse:Ellipse;
		
		public function AddingNodes()
		{
			init();
		}
		
		private function init():void
		{
			_ellipse = new Ellipse(300, 300);
			_ellipse.x=LAYOUT_WIDTH/2, _ellipse.y=LAYOUT_HEIGHT/2;
			
			/*
			 * 'alignType' sets the way in which each node is rotated in respect to 
			 * its position on the path of the ellipse
			*/
			_ellipse.alignType=PathAlignType.ALIGN_PARALLEL;
			_ellipse.alignAngleOffset=180;
			
			var s:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				s = new Circle(10);
				
				/*
				 * By setting the 'moveToCoordinates' method to false, you can save in performance by 
				 * simply calling 'updateAndRender()' after the loop. This will allow the layout to only
				 * need to calculate and position all elements once, instead of each time through the loop.
				*/
				_ellipse.addNode(s, false);
				addChild(s);
			}
			
			/*
			 * Updating the layout and moving all the nodes' linked objects into their correct position
			*/
			_ellipse.updateAndRender();			
		}

	}
}

import flash.display.Shape;	

internal class Circle extends Shape
{
	public function Circle(radius:Number)
	{
		graphics.lineStyle(1, 0x5d504f);
		graphics.beginFill(0xded3d1, .75);
		graphics.drawCircle(0, 0, radius);
		graphics.endFill();
		graphics.lineStyle(1, 0x5d504f);
		graphics.moveTo(0,0);
		graphics.lineTo(0, radius);
	}
}