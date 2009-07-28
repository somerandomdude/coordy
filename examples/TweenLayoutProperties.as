package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	
	import fl.motion.easing.Cubic;
	import fl.transitions.Tween;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	public class TweenLayoutProperties extends Sprite
	{
		private var _wave3d:Wave3d;
		private var _caption:Text;
		private var _tweens:Array;
		
		public function TweenLayoutProperties()
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
			_wave3d = new Wave3d(this, 400, 300, 300);
			
			/*
			 * Wave layouts are centered along the middle y axis of the wave. So setting the layout to 
			 * 0 would crop half of the wave
			*/
			_wave3d.y=200;
			
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();
				_wave3d.addToLayout(s, false);
			}
			_wave3d.updateAndRender();
			_wave3d.updateMethod=LayoutUpdateMode.UPDATE_AND_RENDER;
			_wave3d.alignType=PathAlignType.ALIGN_PARALLEL;
			
			_caption = new Text();
			_caption.text='A basic example of tweening a layout\'s properties. Click anywhere to tween the layout randomly';
			_caption.y=400;
			addChild(_caption);
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function tweenLayout():void
		{
			if(_tweens) clearTweens();
			_tweens=new Array();
			
			var width:Number=200+Math.random()*200;
			var height:Number=100+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var x:Number=Math.random()*50;
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
			_tweens.push(new Tween(_wave3d, 'x', Cubic.easeInOut, _wave3d.x, x, 3, true));
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
	}
}

import flash.display.Shape;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.text.engine.Kerning;
import flash.text.AntiAliasType;

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