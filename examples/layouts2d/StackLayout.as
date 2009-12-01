package layouts2d
{
	import com.somerandomdude.coordy.constants.StackOrder;
	import com.somerandomdude.coordy.layouts.twodee.ILayout2d;
	import com.somerandomdude.coordy.layouts.twodee.Stack;
	import com.somerandomdude.coordy.proxyupdaters.OrderSortProxyUpdater;
	
	import flash.display.Sprite;

	public class StackLayout extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=600;
		public static const LAYOUT_HEIGHT:Number=300;
		private var _layout:ILayout2d;
		
		public function StackLayout()
		{
			super();
			_layout = new Stack(20);
			_layout.proxyUpdater=new OrderSortProxyUpdater(this, Stack(_layout));
			_layout.x=150, _layout.y=100; 
			var c:Circle;
			for(var i:int=0; i<SIZE; i++) 
			{
				c=new Circle(40);
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