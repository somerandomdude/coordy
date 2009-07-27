package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	import com.somerandomdude.coordy.helpers.SimpleZSorter;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class UpdateMethods extends Sprite
	{
		private var _wave3d:Wave3d;
		private var _size:int;
		
		public function UpdateMethods()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_size=100;
			_wave3d = new Wave3d(this, 300, 300, 300, 20, 150, 0, 1);
			var s:Square;
			for(var i:int=0; i<_size; i++)
			{
				s = new Square();
				_wave3d.addToLayout(s);
				addChild(s);
			}
			SimpleZSorter.sortLayout(_wave3d);
		}
		
		private function autoUpdate():void
		{
			var x:Number=Math.random()*50;
			var y:Number=Math.random()*50;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var frequency:Number=Math.random()*5;
			
			_wave3d.updateMethod=LayoutUpdateMode.AUTO_UPDATE;
			
			_wave3d.x=x;
			_wave3d.y=y;
			_wave3d.width=width;
			_wave3d.height=height;
			_wave3d.depth=depth;
			_wave3d.frequency=frequency;
			
			SimpleZSorter.sortLayout(_wave3d);
		}
		
		private function semiAutoUpdate():void
		{
			var x:Number=Math.random()*50;
			var y:Number=Math.random()*50;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var frequency:Number=Math.random()*5;
			
			_wave3d.updateMethod=LayoutUpdateMode.SEMI_AUTO_UPDATE;
			
			_wave3d.x=x;
			_wave3d.y=y;
			_wave3d.width=width;
			_wave3d.height=height;
			_wave3d.depth=depth;
			_wave3d.frequency=frequency;
			
			_wave3d.render();
			
			SimpleZSorter.sortLayout(_wave3d);
		}
		
		private function manualUpdate():void
		{
			var x:Number=Math.random()*50;
			var y:Number=Math.random()*50;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var frequency:Number=Math.random()*5;
			
			_wave3d.updateMethod=LayoutUpdateMode.MANUAL_UPDATE;
			
			_wave3d.x=x;
			_wave3d.y=y;
			_wave3d.width=width;
			_wave3d.height=height;
			_wave3d.depth=depth;
			_wave3d.frequency=frequency;
			
			_wave3d.updateAndRender();
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