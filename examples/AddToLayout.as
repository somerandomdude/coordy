package
{
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.layouts.twodee.Ellipse;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class AddToLayout extends Sprite
	{
		private var _ellipse:Ellipse;
		private var _caption:Text;
		
		public function AddToLayout()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_ellipse = new Ellipse(350, 350, 200, 200);
			
			/*
			 * 'alignType' sets the way in which each node is rotated in respect to 
			 * its position on the path of the ellipse
			*/
			_ellipse.alignType=PathAlignType.ALIGN_PERPENDICULAR;
			
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();
				
				/*
				 * By setting the 'moveToCoordinates' method to false, you can save in performance by 
				 * simply calling 'updateAndRender()' after the loop. This will allow the layout to only
				 * need to calculate and position all elements once, instead of each time through the loop.
				*/
				_ellipse.addToLayout(s, false);
				addChild(s);
			}
			
			/*
			 * Updating the layout and moving all the nodes' linked objects into their correct position
			*/
			_ellipse.updateAndRender();
			
			_caption = new Text();
			_caption.text='A basic example of populating a layout with the \'addToLayout()\' method';
			_caption.y=400;
			addChild(_caption);
			
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