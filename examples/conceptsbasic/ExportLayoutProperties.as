package conceptsbasic
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Ellipse;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ExportLayoutProperties extends Sprite
	{
		public static const SIZE:int=20;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		private var _ellipse:Ellipse;
		private var _output:Output;
		
		public function ExportLayoutProperties()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_ellipse = new Ellipse(200, 200, 120, 120);
			
			var c:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				c = new Circle(10);				
				_ellipse.addNode(c, false);
				addChild(c);
			}
			_ellipse.updateAndRender();
			_ellipse.updateMethod=LayoutUpdateMethod.NONE;
			
			/*
			* This property will align each node to fit the path in terms of its rotation (in either a parallel 
			* or perpendicular manner.
			*/
			_ellipse.alignType=PathAlignType.ALIGN_PARALLEL;
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		
			_output = new Output();
			_output.width=300;
			_output.height=300;
			_output.x=LAYOUT_WIDTH-320, _output.y=(LAYOUT_HEIGHT-_output.height)/2
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
			var width:Number=100+Math.random()*200;
			var height:Number=100+Math.random()*200;
			var x:Number=20+width/2;
			var y:Number=20+height/2;
			
			
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
		
		private function addedToStageHandler(event:Event):void
		{
			init();
		}

	}
}

import flash.display.Shape;	
import flash.text.TextField;
import flash.text.TextFormat
import flash.text.AntiAliasType;

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