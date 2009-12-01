package conceptsadvanced
{
	import com.somerandomdude.coordy.layouts.threedee.Ellipse3d;
	import com.somerandomdude.coordy.proxyupdaters.InvalidationZSortProxyUpdater;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ProxyUpdaters extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _layout:Ellipse3d;
		private var _angle:Number=0;
		
		public function ProxyUpdaters()
		{
			init();
		}
		
		private function init():void
		{
			_layout = new Ellipse3d(LAYOUT_WIDTH, LAYOUT_HEIGHT, LAYOUT_HEIGHT);
			
			/*Proxy updaters allow for a more custom and sometimes more appropriate method of 
			* updating nodes rather than the general updating methods native to coordy.
			*
			* In this case, we are going to take advantage of stage.invalidate() to make the 
			* updating/rendering processes for this layout more efficient. Since I am adding all
			* items belonging to the layout in this class, I point the proxy updater to this instance.
			*/
			_layout.proxyUpdater = new InvalidationZSortProxyUpdater(this, _layout);
			
			/*
			 * Basic display properties (such as x, y, width, height, etc.) 
			 * are set just like any DisplayObject
			*/
			_layout.x=LAYOUT_WIDTH/2, _layout.y=LAYOUT_HEIGHT/2;
			
			/*
			 * Generate DisplayObjects to add to layout
			*/
			var s:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				s = new Circle(10);	
				_layout.addNode(s);			
				addChild(s);
			}
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		
		private function enterFrameHandler(event:Event):void
		{
			_angle++;
			
			/*
			* When any property of the layout is modified, the proxy updater calls 
			* stage.invalidate(). The proxy updater listens for Event.RENDER, which occurs
			* once a frame. When that event is caught, it will perform an update and a render
			* for the layout. So instead of updating/rendering the layout 5 separate times in 
			* example, it will do it only once.
			*/
			_layout.rotationX=Math.sin(_angle*Math.PI/180)*360;	
			_layout.rotationY=Math.cos(_angle*Math.PI/180)*360;
			_layout.rotationZ=Math.sin(_angle*Math.PI/180)*360;
			
			_layout.width=200+Math.sin(_angle*Math.PI/180)*100;
			_layout.height=200+Math.cos(_angle*Math.PI/180)*100;
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