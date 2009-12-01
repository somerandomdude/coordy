package conceptsbasic
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.twodee.Scatter;
	import com.somerandomdude.coordy.nodes.twodee.INode2d;
	import com.somerandomdude.coordy.utils.LayoutTransitioner;
	
	import fl.motion.easing.Cubic;
	import fl.transitions.Tween;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TweenLayoutItems extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _scatter:Scatter;
		private var _tweens:Array;
		
		public function TweenLayoutItems()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_scatter = new Scatter(LAYOUT_WIDTH, LAYOUT_HEIGHT, 0, 0, 1, true);
			_scatter.updateMethod=LayoutUpdateMethod.NONE;
			
			var c:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				c = new Circle(10);
				_scatter.addNode(c);
				addChild(c);
			}
			
			_scatter.updateAndRender();
			
			/*
			* The LayoutTransitioner class is a way to more simply move individual nodes in a layout.
			* By defining the 'tweenFunction' property, you can tween all linked DisplayObjects in a 
			* layout with a customized tween method. 
			*
			* The tween method defined must take a node object as the parameter. When dealing with 2d 
			* layouts, you should set the type as 'INode2d'. When dealing with 3d layouts, you should 
			* set the type as 'INode3d'. See the 'tweenItem' method below for an example.
			*/
			LayoutTransitioner.tweenFunction=tweenItem;
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function updateItems():void
		{
			if(_tweens) clearTweens();
			_tweens=new Array();
			
			/*
			* The 'scatter()' method completely randomizes the layout. Otherwise, changing the width, height 
			* (and depth if Scatter3d) will move the nodes in their proportionally-correct places - maintaing 
			* the same scatter layout.
			*/
			_scatter.scatter();
			
			/*
			* If a 'tweenFunction' is defined in the 'LayoutTransitioner' class, it will call that method
			* for each node in the layout. Otherwise it will simply update the node's x, y (and z if 3d) properties.
			*/
			LayoutTransitioner.syncNodesTo(_scatter);
		}
		
		private function tweenItem(node:INode2d):void
		{ 
			var link:Object=node.link;
			/*
			* Please, do not ever use Adobe's internal Tween class. This class was used only for increased
			* compatibility.
			*/
			_tweens.push(new Tween(link, 'x', Cubic.easeInOut, link.x, node.x, 1+Math.random()*2, true));
			_tweens.push(new Tween(link, 'y', Cubic.easeInOut, link.y, node.y, 1+Math.random()*2, true));
			_tweens.push(new Tween(link, 'rotation', Cubic.easeInOut, link.rotation, node.rotation, 1+Math.random()*2, true));
		}

		private function clickHandler(event:MouseEvent):void
		{
			updateItems();
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
		}
		
		private function clearTweens():void
		{
			var twn:Tween;
			for(var i:int=0; i<_tweens.length; i++)
			{
				twn=_tweens[i];
				twn.stop();
				delete _tweens[i];
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