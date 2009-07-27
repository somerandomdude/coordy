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
		
		public function UpdateLayoutProperties()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_wave = new Wave(this, 300, 300, 150, 150);
			
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();				
				_wave.addToLayout(s, false);
			}
			_wave.updateAndRender();
			_wave.updateMethod=LayoutUpdateMode.MANUAL_UPDATE;
			_wave.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function updateLayout():void
		{
			var x:Number=Math.random()*50;
			var y:Number=Math.random()*50;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var frequency:Number=Math.random()*5;
			
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

internal class Square extends Shape
{
	public function Square():void
	{
		graphics.lineStyle(1);
		graphics.beginFill(0xffffff, .7);
		graphics.drawRect(0, 0, 20, 20);
		graphics.endFill();
	}
}