package layouts3d
{
	import com.somerandomdude.coordy.layouts.threedee.ILayout3d;
	import com.somerandomdude.coordy.layouts.threedee.Stack3d;
	import com.somerandomdude.coordy.proxyupdaters.InvalidationZSortProxyUpdater;
	
	import flash.display.Sprite;

	public class Stack3dLayout extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=600;
		public static const LAYOUT_HEIGHT:Number=300;
		public static const LAYOUT_DEPTH:Number=300;
		private var _layout:ILayout3d;
		
		public function Stack3dLayout()
		{
			super();
			_layout = new Stack3d(20);
			_layout.proxyUpdater = new InvalidationZSortProxyUpdater(this, _layout);
			_layout.x=200, _layout.y=120; 
			
			var c:Circle;
			for(var i:int=0; i<SIZE; i++) 
			{
				c=new Circle(50);
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