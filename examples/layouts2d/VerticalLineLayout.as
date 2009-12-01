package layouts2d
{
	import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
	import com.somerandomdude.coordy.layouts.twodee.VerticalLine;
	
	import flash.display.Sprite;

	public class VerticalLineLayout extends Sprite
	{
		public static const SIZE:int=50;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _layout:ILayout2d;
		
		public function VerticalLineLayout()
		{
			super();
			_layout = new VerticalLine();
			_layout.x=LAYOUT_WIDTH/2; 
			var c:Circle;
			for(var i:int=0; i<SIZE; i++) 
			{
				c=new Circle(10);
				_layout.addNode(c);
				addChild(c);
			}
			
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