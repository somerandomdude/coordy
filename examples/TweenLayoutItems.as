package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.layouts.twodee.Scatter;
	import com.somerandomdude.coordy.nodes.twodee.INode2d;
	import com.somerandomdude.coordy.nodes.twodee.ScatterNode;
	import com.somerandomdude.coordy.utils.LayoutTransitioner;
	
	import fl.motion.easing.Cubic;
	import fl.transitions.Tween;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	public class TweenLayoutItems extends Sprite
	{
		private var _scatter:Scatter;
		private var _tweens:Array;
		
		public function TweenLayoutItems()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_scatter = new Scatter(this, 400, 400, 0, 0, 1, true);
			_scatter.updateMethod=LayoutUpdateMode.MANUAL_UPDATE;
			
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();
				_scatter.addToLayout(s);
			}
			
			_scatter.updateAndRender();
			LayoutTransitioner.tweenFunction=tweenItem;
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function updateItems():void
		{
			if(_tweens) clearTweens();
			_tweens=new Array();
			_scatter.scatter();
			
			LayoutTransitioner.syncNodesTo(_scatter);
		}
		
		private function tweenItem(node:INode2d):void
		{ 
			var link:DisplayObject=node.link;
			_tweens.push(new Tween(link, 'x', Cubic.easeInOut, link.x, node.x, 1+Math.random()*2, true));
			_tweens.push(new Tween(link, 'y', Cubic.easeInOut, link.y, node.y, 1+Math.random()*2, true));
			_tweens.push(new Tween(link, 'rotation', Cubic.easeInOut, link.rotation, node.rotation, 1+Math.random()*2, true));
		}

		private function clickHandler(event:MouseEvent):void
		{
			updateItems();
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
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

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

internal class Text extends TextField
{
	private var _format:TextFormat;
	
	public function Text()
	{
		_format = new TextFormat();
		_format.font='Arial';
		_format.size=11;
	
		textColor=0x333333;
		wordWrap=true;
		multiline=true;
		autoSize=TextFieldAutoSize.LEFT;
		width=400;
		defaultTextFormat=_format;
	}
}