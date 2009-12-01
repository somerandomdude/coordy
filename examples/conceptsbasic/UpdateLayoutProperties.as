package conceptsbasic
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Wave;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class UpdateLayoutProperties extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _wave:Wave;
		
		public function UpdateLayoutProperties()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_wave = new Wave(LAYOUT_WIDTH-40, LAYOUT_HEIGHT, 20, LAYOUT_HEIGHT/2);
			
			var c:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				c = new Circle(10);				
				_wave.addToLayout(c, false);
				addChild(c);
			}
			_wave.updateAndRender();
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			
			/*
			* This property will align each node to fit the path in terms of its rotation (in either a parallel 
			* or perpendicular manner.
			*/
			_wave.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);

		}
		
		private function updateLayout():void
		{
			
			var width:Number=500+Math.random()*200;
			var height:Number=200+Math.random()*200;
			
			var x:Number=(LAYOUT_WIDTH-width)/2;
			var y:Number=(LAYOUT_HEIGHT/2)+(Math.random()*50*((Math.random()>.5)?1:-1));
			
			var frequency:Number=Math.random()*5;
			
			/*
			* When updating multiple properties such as the example below, it is best to set the layout's
			* 'updateMethod' to 'LayoutUpdateMode.NONE'. If it is set to LayoutUpdateMode.UPDATE_AND_RENDER',
			* both 'update()' and 'render()' will be called with each change of a property. This normally is fine,
			* but for layouts with large numbers of linked DisplayObjects, this can begin to eat off a bit of the CPU.
			*
			* The example below is a more CPU-friendly manner of handling this situation by setting the 
			* 'updateMethod' to 'LayoutUpdateMode.NONE' and then calling 'updateAndRender()' after all the 
			* properties have been set to their new values.  
			*/
			_wave.x=x, _wave.y=y, _wave.width=width, _wave.height=height, _wave.frequency=frequency
			
			_wave.updateAndRender();
			
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			updateLayout();
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