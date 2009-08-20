package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Ellipse;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ExportLayoutProperties extends Sprite
	{
		private var _ellipse:Ellipse;
		private var _caption:Text;
		private var _output:Output;
		
		public function ExportLayoutProperties()
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
			_ellipse = new Ellipse(this, 200, 200, 100, 100);
			
			var s:Square;
			for(var i:int=0; i<20; i++)
			{
				s = new Square();				
				_ellipse.addToLayout(s, false);
			}
			_ellipse.updateAndRender();
			_ellipse.updateMethod=LayoutUpdateMode.NONE;
			
			/*
			* This property will align each node to fit the path in terms of its rotation (in either a parallel 
			* or perpendicular manner.
			*/
			_ellipse.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
			
			_caption = new Text();
			_caption.text='A basic example of changing a layout\'s properties. Click anywhere to tween the layout randomly';
			_caption.y=400;
			addChild(_caption);
		
			_output = new Output();
			_output.width=200;
			_output.height=400;
			_output.x=199;
			addChild(_output);
			
			/*
			* Output can be set as either XML (toXML) or JSON (toJSON). toXML() returns an XML object which you can then 
			* convert to string with XML.toString(). All properties for the nodes that are impacting the layout are added
			* to either export format.
			*/
			_output.text=_ellipse.toJSON();
		}
		
		private function updateLayout():void
		{
			var x:Number=100;
			var y:Number=100;
			var width:Number=100+Math.random()*100;
			var height:Number=100+Math.random()*100;
			
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
			_ellipse.x=x, _ellipse.y=y, _ellipse.width=width, _ellipse.height=height;
			
			_ellipse.updateAndRender();
			
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			updateLayout();
			_output.text=_ellipse.toJSON();
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

internal class Output extends TextField
{
	private var _format:TextFormat;
	
	public function Output()
	{
		_format = new TextFormat();
		_format.font='Arial';
		_format.size=10;
	
		textColor=0x333333;
		antiAliasType=AntiAliasType.ADVANCED;
		wordWrap=true;
		multiline=true;
		width=400;
		border=true;
		borderColor=0;
		background=true;
		backgroundColor=0xfefefe;
		
		defaultTextFormat=_format;
	}
}