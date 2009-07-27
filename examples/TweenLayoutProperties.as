package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Wave;
	
	import fl.motion.easing.Cubic;
	import fl.transitions.Tween;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	public class TweenLayoutProperties extends Sprite
	{
		private var _wave:Wave;
		
		public function TweenLayoutProperties()
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
			_wave.updateMethod=LayoutUpdateMode.AUTO_UPDATE;
			_wave.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function tweenLayout():void
		{
			var x:Number=Math.random()*50;
			var y:Number=Math.random()*50;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var frequency:Number=Math.random()*5;
			
			new Tween(_wave, 'x', Cubic.easeInOut, _wave.x, x, 3, true);
			new Tween(_wave, 'y', Cubic.easeInOut, _wave.y, y, 3, true);
			new Tween(_wave, 'width', Cubic.easeInOut, _wave.width, width, 3, true);
			new Tween(_wave, 'height', Cubic.easeInOut, _wave.height, height, 3, true);
			new Tween(_wave, 'frequency', Cubic.easeInOut, _wave.frequency, frequency, 3, true);
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			tweenLayout();
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