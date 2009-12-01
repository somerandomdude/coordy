package conceptsadvanced
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.events.CoordyNodeEvent;
	import com.somerandomdude.coordy.layouts.twodee.Ellipse;
	import com.somerandomdude.coordy.nodes.twodee.Node2d;
	
	import fl.motion.easing.Cubic;
	import fl.transitions.Tween;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class NodeEvents extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _layout:Ellipse;
		private var _angle:Number=0;
		private var _timer:Timer;
		
		private var _tweens:Array;
		
		public function NodeEvents()
		{
			init();
		}
		
		private function init():void
		{
			_layout = new Ellipse(LAYOUT_WIDTH-200, LAYOUT_HEIGHT-40);
			_layout.updateMethod=LayoutUpdateMethod.UPDATE_ONLY;
			
			/* Whenever a node is added or removed from a layout, it fires its corresponding 
			* CoordyNodeEvent. This gives us an alternative method for handling the updating of
			* layouts when nodes are added or removed. 
			* 
			* In this case, when a node is added, the new node will be moved into place and all other
			* nodes in the layout will adjust to their new positions. Likewise, when a node is removed,
			* the linked DisplayObject will be removed from the stage and all nodes will be adjusted to their
			* newly calculated positions. 
			*/
			_layout.addEventListener(CoordyNodeEvent.ADD, nodeAddHandler);
			_layout.addEventListener(CoordyNodeEvent.REMOVE, nodeRemoveHandler);
			_layout.x=LAYOUT_WIDTH/2, _layout.y=LAYOUT_HEIGHT/2;
			_layout.alignType=PathAlignType.ALIGN_PARALLEL;
			
			_timer = new Timer(400, 100);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
		}
		
		private function nodeAddHandler(event:CoordyNodeEvent):void
		{
			
			var n:Node2d = Node2d(event.node);
			if(n.link) n.link.x=Math.random()*500, n.link.y=Math.random()*500;
			
			moveItems();
		}
		
		private function nodeRemoveHandler(event:CoordyNodeEvent):void
		{
			
			var n:Node2d = Node2d(event.node);
			removeChild(DisplayObject(n.link));
			
			moveItems();
		}
		
		private function moveItems():void
		{
			var n:Node2d;
			for(var i:int=0; i<_layout.size; i++)
			{
				n=_layout.nodes[i];
				
				/*Please, please, please do not use the native Tween class. I am using this only
				* for the sake of maximum compatibility.
				*/
				new Tween(n.link, 'x', Cubic.easeInOut, n.link.x, n.x, int(10*Math.random()+5));
				new Tween(n.link, 'y', Cubic.easeInOut, n.link.y, n.y, int(10*Math.random()+5));
				new Tween(n.link, 'rotation', Cubic.easeInOut, n.link.rotation, n.rotation, int(10*Math.random()+5));
			}
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			var s:Circle = new Circle(10);	
			_layout.addNode(s, false);		
			addChild(s);
			s.addEventListener(MouseEvent.CLICK, itemClickHandler);
		}
		
		private function itemClickHandler(event:MouseEvent):void
		{
			var t:Sprite = Sprite(event.target);
			_layout.removeNodeByLink(t);
		}
	}
}

import flash.display.Sprite;	

internal class Circle extends Sprite
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