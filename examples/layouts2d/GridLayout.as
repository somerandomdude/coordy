package layouts2d
{
	import com.somerandomdude.coordy.layouts.twodee.Grid;
	import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
	
	import flash.display.Sprite;

	public class GridLayout extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _layout:ILayout2d;
		
		public function GridLayout()
		{
			super();
			_layout = new Grid(LAYOUT_WIDTH-40, LAYOUT_HEIGHT-40, 10, 10);
			_layout.x=50, _layout.y=30; 
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