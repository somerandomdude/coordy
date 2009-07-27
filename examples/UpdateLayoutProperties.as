package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Wave;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	public class UpdateLayoutProperties extends Sprite
	{
		private var _wave:Wave;
		private var _caption:Text;
		
		public function UpdateLayoutProperties()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_wave = new Wave(this, 300, 300, 150, 150);
			
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();				
				_wave.addToLayout(s, false);
			}
			_wave.updateAndRender();
			_wave.updateMethod=LayoutUpdateMode.NONE;
			
			/*
			* This property will align each node to fit the path in terms of its rotation (in either a parallel 
			* or perpendicular manner.
			*/
			_wave.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
			
			_caption = new Text();
			_caption.text='A basic example of changing a layout\'s properties. Click anywhere to tween the layout randomly';
			_caption.y=400;
			addChild(_caption);
		}
		
		private function updateLayout():void
		{
			var x:Number=Math.random()*50;
			var y:Number=Math.random()*50 +125;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
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

	}
}

import flash.display.Shape;
import flash.text.TextField;
import flash.text.engine.Kerning;
import flash.text.AntiAliasType;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

internal class Square extends Shape
{
	public function Square():void
	{
		graphics.lineStyle(1);
		graphics.beginFill(0xffffff, .7);
		graphics.drawRect(-10, -10, 20, 20);
		graphics.endFill();
	}
}

internal class Text extends TextField
{
	private var _format:TextFormat;
	
	public function Text()
	{
		_format = new TextFormat();
		_format.font='Arial';
		_format.size=11;
		_format.kerning=Kerning.ON;
	
		textColor=0x333333;
		antiAliasType=AntiAliasType.ADVANCED;
		wordWrap=true;
		multiline=true;
		autoSize=TextFieldAutoSize.LEFT;
		width=400;
		defaultTextFormat=_format;
	}
}