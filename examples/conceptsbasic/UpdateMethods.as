package conceptsbasic
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.helpers.SimpleZSorter;
	import com.somerandomdude.coordy.layouts.threedee.Ellipse3d;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class UpdateMethods extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _ellipse3d:Ellipse3d;
		private var _updateLabel:Label;
		
		public function UpdateMethods()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_ellipse3d = new Ellipse3d(360, 360, LAYOUT_WIDTH/2, LAYOUT_HEIGHT/2, 0, 0, 1);
			_ellipse3d.updateMethod=LayoutUpdateMethod.NONE;

			var c:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				c = new Circle(10);
				_ellipse3d.addToLayout(c, false);
				addChild(c);
			}
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
			
			_updateLabel = new Label();
			addChild(_updateLabel);
			
			updateAndRender();
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			var rand:Number=Math.round(Math.random()*3);
			switch(rand)
			{
				case 0:
					updateAndRender();
					break;
				case 1:
					updateOnly();
					break;
				default:
					manualUpdate();
			}
			
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
		}
		
		private function updateAndRender():void
		{
			/*
			* This example manages the updating rendering and z-sorting automatically - which makes
			* it the simplest and most convenient method for updating a layout. It is, unfortunately,
			* also the least efficient method since the update/render/z-sort cycle is run for each
			* property change.
			*/
			_updateLabel.text='Updated with LayoutUpdateMode.UPDATE_AND_RENDER';
			
			var width:Number=100+Math.random()*200;
			var height:Number=100+Math.random()*200;
			var depth:Number=100+Math.random()*200;
			var rotationX:Number=Math.random()*360;
			var rotationY:Number=Math.random()*360;
			var rotationZ:Number=Math.random()*360;
			
			_ellipse3d.updateMethod=LayoutUpdateMethod.UPDATE_AND_RENDER;
			
			_ellipse3d.width=width;
			_ellipse3d.depth=depth;
			_ellipse3d.rotationX=rotationX;
			_ellipse3d.rotationY=rotationY;
			_ellipse3d.rotationZ=rotationZ;	
			SimpleZSorter.sortLayout(this, _ellipse3d);		
		}
		
		private function updateOnly():void
		{
			/*
			* This example manages the only the updating of the layout automatically - rendering the
			* DisplayObjects and Z-Sorting them are done manually. It is much more efficient than the
			* fully automated approach, but there is still unnecessary CPU usage. 
			*/
			_updateLabel.text='Updated with LayoutUpdateMode.UPDATE_ONLY';
			
			var width:Number=100+Math.random()*200;
			var height:Number=100+Math.random()*200;
			var depth:Number=100+Math.random()*200;
			var rotationX:Number=Math.random()*360;
			var rotationY:Number=Math.random()*360;
			var rotationZ:Number=Math.random()*360;
			
			_ellipse3d.updateMethod=LayoutUpdateMethod.UPDATE_ONLY;
			
			_ellipse3d.width=width;
			_ellipse3d.depth=depth;
			_ellipse3d.rotationX=rotationX;
			_ellipse3d.rotationY=rotationY;
			_ellipse3d.rotationZ=rotationZ;
			
			_ellipse3d.render();
			
			SimpleZSorter.sortLayout(this, _ellipse3d);
		}
		
		private function manualUpdate():void
		{
			/*
			* This example performs all cycles (layout updating, node rendering and z-sorting) only 
			* once - after all properties have been altered. This is by far the most efficient approach
			* to changing a layout, especially if tweening the layout.
			*/
			_updateLabel.text='Updated with LayoutUpdateMode.NONE';
			
			var width:Number=100+Math.random()*200;
			var height:Number=100+Math.random()*200;
			var depth:Number=100+Math.random()*200;
			var rotationX:Number=Math.random()*360;
			var rotationY:Number=Math.random()*360;
			var rotationZ:Number=Math.random()*360;
			
			_ellipse3d.updateMethod=LayoutUpdateMethod.NONE;

			_ellipse3d.width=width;
			_ellipse3d.depth=depth;
			_ellipse3d.rotationX=rotationX;
			_ellipse3d.rotationY=rotationY;
			_ellipse3d.rotationZ=rotationZ;
			
			_ellipse3d.updateAndRender();
			SimpleZSorter.sortLayout(this, _ellipse3d);
		}
		
	}
}

import flash.display.Shape;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;	

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

internal class Text extends TextField
{
	protected var _format:TextFormat;
	
	public function Text()
	{
		_format = new TextFormat();
		_format.font='Arial';
		_format.size=11;
	
		textColor=0x333333;
		antiAliasType=AntiAliasType.ADVANCED;
		wordWrap=true;
		multiline=true;
		autoSize=TextFieldAutoSize.LEFT;
		width=400;
		defaultTextFormat=_format;
	}
}

internal class Label extends Text
{
	public function Label()
	{
		super();
		_format.size=13;
		textColor=0x000000;
	}
}