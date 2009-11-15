package
{
	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.layouts.ILayout;
	import com.somerandomdude.coordy.layouts.twodee.HorizontalLine;
	import com.somerandomdude.coordy.layouts.twodee.Stack;
	import com.somerandomdude.coordy.layouts.twodee.VerticalLine;
	import com.somerandomdude.coordy.utils.LayoutTransitioner;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	public class SwapLayouts extends Sprite
	{
		private var _stack:Stack;
		private var _verticalLine:VerticalLine;
		private var _horizontalLine:HorizontalLine;
		
		private var _size:int;
		
		private var _stackButton:LayoutButton;
		private var _verticalLineButton:LayoutButton;
		private var _horizontalLineButton:LayoutButton;
		private var _caption:Text;
		
		public function SwapLayouts()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_size=60;
			
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_stack = new Stack(135, 6, 350, 50);
			_verticalLine = new VerticalLine(3, 200, 0);
			_horizontalLine = new HorizontalLine(3, 0, 200);
			
			var s:Square;
			for(var i:int=0; i<_size; i++)
			{
				s = new Square();
				
				/*
				* The more layout instances that are having items added to themselves, the 
				* greater the performance will be hampered by automatically calculating the
				* new node's position. It is advised to set the 'moveToCoordinates' property 
				* to 'false'.
				*/
				_stack.addToLayout(s, false);
				_verticalLine.addToLayout(s, false);
				_horizontalLine.addToLayout(s, false);
				addChild(s);
			}
		
			/*
			 * Once out of the loop, the desired layout is updated and rendered so that all
			 * layout objects display in the proper placement
			*/
			_stack.updateAndRender();
			
			_stackButton = new LayoutButton('Stack');
			_verticalLineButton = new LayoutButton('Vertical Line');
			_horizontalLineButton = new LayoutButton('Horizontal Line');
			
			_stackButton.addEventListener(MouseEvent.CLICK, stackClickHandler);
			_verticalLineButton.addEventListener(MouseEvent.CLICK, verticalLineClickHandler);
			_horizontalLineButton.addEventListener(MouseEvent.CLICK, horizontalLineClickHandler);
			
			addChild(_stackButton);
			addChild(_verticalLineButton);
			addChild(_horizontalLineButton);
			
			/*
			 * Ironically, this button layout is a prime case where a VerticalLine layout could 
			 * be helpful...
			*/
			_stackButton.y=0;
			_verticalLineButton.y=30;
			_horizontalLineButton.y=60;
			
			_caption = new Text();
			_caption.text='An example of how to manage multiple layouts sharing the same DisplayObjects';
			_caption.y=400;
			addChild(_caption);
			
		}
		
		private function syncToLayout(layoutType:ILayout):void
		{
			/*
			 * Each layout has a 'toString()' method which is essentially its callsign for what
			 * type of layout it is. This is a nice way to manage multiple layouts - simply match 
			 * the layout's 'toString()' with the LayoutType constant and you'll know what you're
			 * dealing with.
			 *
			 * The LayoutTransitioner class allows for easy transitioning from one layout to another.
			 * It also supports setting a default tweening function if you want to transition the items
			 * from one layout to another in a more graceful manner.
			*/
			switch(layoutType.toString())
			{
				case LayoutType.STACK:
					LayoutTransitioner.syncNodesTo(_stack);
					break;
					
				case LayoutType.VERTICAL_LINE:
					LayoutTransitioner.syncNodesTo(_verticalLine);
					break;
					
				default:
					LayoutTransitioner.syncNodesTo(_horizontalLine);
			}
		}
		
		private function stackClickHandler(event:MouseEvent):void
		{
			syncToLayout(_stack);
		}
		
		private function verticalLineClickHandler(event:MouseEvent):void
		{
			syncToLayout(_verticalLine);
		}
		
		private function horizontalLineClickHandler(event:MouseEvent):void
		{
			syncToLayout(_horizontalLine);
		}
		
	}
}

import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.text.engine.Kerning;
import flash.text.AntiAliasType;

internal class LayoutButton extends Sprite
{
	private var _label:String;
	private var _text:TextField;
	private var _background:Shape;
	
	public function LayoutButton(label:String)
	{
		_label=label;
		init();
	}
	
	private function init():void
	{
		mouseChildren=false;
		buttonMode=true;
		
		var tf:TextFormat = new TextFormat();
		tf.font='Arial';
		
		_text=new TextField();
		_text.text=_label;
		_text.textColor=0x333333;
		_text.multiline=false;
		_text.autoSize=TextFieldAutoSize.LEFT;
		
		_text.setTextFormat(tf);
		
		_background = new Shape();
		_background.graphics.lineStyle(0, 0x333333);
		_background.graphics.beginFill(0xffffff, .8);
		_background.graphics.drawRect(0, 0, 100, _text.height+10);
		_background.graphics.endFill();
		
		addChild(_background);
		addChild(_text);
		
		_text.x=(_background.width-_text.width)/2;
		_text.y=(_background.height-_text.height)/2;
	}
}

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