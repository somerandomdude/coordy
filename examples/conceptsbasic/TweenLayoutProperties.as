package conceptsbasic
{
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	import com.somerandomdude.coordy.proxyupdaters.InvalidationZSortProxyUpdater;
	
	import fl.motion.easing.Cubic;
	import fl.transitions.Tween;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TweenLayoutProperties extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _wave3d:Wave3d;
		private var _tweens:Array;
		
		public function TweenLayoutProperties()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_wave3d = new Wave3d(LAYOUT_WIDTH-40, LAYOUT_HEIGHT-40, LAYOUT_HEIGHT-40, 20, LAYOUT_HEIGHT/2);
			
			/*
			* The proxyUpdater property is a alternate method of defining how you would like 
			* your layout to update. The more traditional way is to set updateMethod to either
			* LayoutUpdateMethod.NONE, LayoutUpdateMethod.UPDATE or LayoutUpdateMethod.UPDATE_AND_REDNER.
			*
			* Proxy updaters allow for more custom methods of updating layouts. The proxy updater below
			* uses a potentially more efficent manner of updating by taking advantage of the stage.invalidate()
			* method in addition to running a Z-Sorting routine on all objects in the layout
			*/
			_wave3d.proxyUpdater=new InvalidationZSortProxyUpdater(this, _wave3d);
			
			/*
			 * Wave layouts are centered along the middle y axis of the wave. So setting the layout to 
			 * 0 would crop half of the wave
			*/
			_wave3d.y=200;
			
			var c:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				c = new Circle(10);
				_wave3d.addToLayout(c, false);
				addChild(c);
			}
			_wave3d.updateAndRender();
			_wave3d.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function tweenLayout():void
		{
			if(_tweens) clearTweens();
			_tweens=new Array();
			
			var width:Number=500+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var frequency:Number=Math.random()*5;
			var rotation:Number=Math.random()*360;
			
			/*
			* As shown in other examples, updating a layout's properties is the same as how you 
			* would update any normal DisplayObject's properties. In this example, layout updating is set
			* to update and render its nodes whenever a property is changed. When tweening multiple properties, it 
			* is advised to set the layout being updated to LayoutUpdateMode.NONE and then perform an 
			* 'updateAndRender()' on the tween update event/callback for maximum performance.
			* 
 			* Adobe's default Tween class is being used simply for the sake of maximum compatibility.
			* I highly suggest using basically anything other than this class for normal circumstances 
			* as most third party tween engines could tween all these properties in one call.
			*/
			_tweens.push(new Tween(_wave3d, 'x', Cubic.easeInOut, _wave3d.x, (LAYOUT_WIDTH-width)/2, 3, true));
			_tweens.push(new Tween(_wave3d, 'width', Cubic.easeInOut, _wave3d.width, width, 3, true));
			_tweens.push(new Tween(_wave3d, 'height', Cubic.easeInOut, _wave3d.height, height, 3, true));
			_tweens.push(new Tween(_wave3d, 'depth', Cubic.easeInOut, _wave3d.depth, depth, 3, true));
			_tweens.push(new Tween(_wave3d, 'frequency', Cubic.easeInOut, _wave3d.frequency, frequency, 3, true));
			_tweens.push(new Tween(_wave3d, 'rotation', Cubic.easeInOut, _wave3d.rotation, rotation, 3, true));
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
		
		private function clickHandler(event:MouseEvent):void
		{
			tweenLayout();
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
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