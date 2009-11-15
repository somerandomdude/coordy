package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.twodee.Scatter;
	import com.somerandomdude.coordy.nodes.twodee.INode2d;
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
		private var _caption:Text;
		
		public function TweenLayoutItems()
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
			_scatter = new Scatter(400, 400, 0, 0, 1, true);
			_scatter.updateMethod=LayoutUpdateMethod.NONE;
			
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();
				_scatter.addToLayout(s);
				addChild(s);
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
			
			_caption = new Text();
			_caption.text='A basic example of tweening a layout\'s nodes individually. Click anywhere to tween the layout randomly';
			_caption.y=400;
			addChild(_caption);
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