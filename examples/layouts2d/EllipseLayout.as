package layouts2d
{
	import com.somerandomdude.coordy.layouts.twodee.Ellipse;
	import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
	
	import flash.display.Sprite;

	public class EllipseLayout extends Sprite
	{
		public static const SIZE:int=50;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _layout:ILayout2d;
		
		public function EllipseLayout()
		{
			super();
			_layout = new Ellipse(LAYOUT_WIDTH-50, LAYOUT_HEIGHT-50);
			_layout.x=LAYOUT_WIDTH/2, _layout.y=LAYOUT_HEIGHT/2; 
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