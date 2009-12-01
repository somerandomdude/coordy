package conceptsadvanced
{
	import com.somerandomdude.coordy.behaviors.AutoAddToLayoutBehavior;
	import com.somerandomdude.coordy.constants.LatticeOrder;
	import com.somerandomdude.coordy.constants.LatticeType;
	import com.somerandomdude.coordy.layouts.twodee.Lattice;
	
	import flash.display.Sprite;
	
	public class AutoAddingChildren extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _lattice:Lattice;
		
		public function AutoAddingChildren()
		{
			init();
		}
		
		private function init():void
		{
			_lattice = new Lattice(LAYOUT_WIDTH-40, LAYOUT_HEIGHT-40, 10, 10);
			
			/*
			* The AutoAddToLayoutBehavior binds a DisplayObjectContainer to a layout.
			* In doing so, anytime a DisplayObject is added to the target's display list, 
			* the child is automatically added to the specified layout and rendered in the 
			* appropriate location using the Event.ADDED event.
			*
			* Additionally, any children of the target that are removed from the display list
			* will automatically be removed from the layout using the Event.REMOVED event
			*/
			var behavior:AutoAddToLayoutBehavior = new AutoAddToLayoutBehavior(this, _lattice);
			
			/*
			 * Basic display properties (such as x, y, width, height, etc.) 
			 * are set just like any DisplayObject
			*/
			_lattice.x=50, _lattice.y=30;
			
			/*
			 * Generate DisplayObjects to add to layout
			*/
			var s:Circle;
			for(var i:int=0; i<100; i++)
			{
				s = new Circle(10);				
				addChild(s);
			}
			
			/*
			 * Some basic layout properties of how the lattice is set
			*/
			_lattice.order=LatticeOrder.ORDER_HORIZONTALLY;
			_lattice.latticeType=LatticeType.DIAGONAL;
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