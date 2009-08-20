package
{
	import com.somerandomdude.coordy.constants.LatticeOrder;
	import com.somerandomdude.coordy.constants.LatticeType;
	import com.somerandomdude.coordy.layouts.twodee.Lattice;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class AddChildren extends Sprite
	{
		private var _lattice:Lattice;
		private var _caption:Text;
		
		public function AddChildren()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_lattice = new Lattice(this, 360, 360, 10, 10);
			
			/*
			 * Basic display properties (such as x, y, width, height, etc.) 
			 * are set just like any DisplayObject
			*/
			_lattice.x=20, _lattice.y=20;
			
			/*
			 * Generate DisplayObjects to add to layout
			*/
			var s:Square;
			for(var i:int=0; i<100; i++)
			{
				s = new Square();				
				addChild(s);
			}
			
			/*
			 * Some basic layout properties of how the lattice is set
			*/
			_lattice.order=LatticeOrder.ORDER_HORIZONTALLY;
			_lattice.latticeType=LatticeType.DIAGONAL;
			
			/*
			 * Add all children from the layout's target set in the constructor. 
			 * Setting the 'moveToCoordinates' parameter to 'true' will move all 
			 * the newly added nodes and their linked DisplayObjects to the appropriate
			 * coordinates.
			*/
			_lattice.addChildren(true);
			
			_caption = new Text();
			_caption.text='A basic example of populating a layout with the \'addChildren()\' method';
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