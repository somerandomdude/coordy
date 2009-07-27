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
			
			_stack = new Stack(this, 135, 6, 350, 50);
			_verticalLine = new VerticalLine(this, 3, 200, 0);
			_horizontalLine = new HorizontalLine(this, 3, 0, 200);
			
			var s:Square;
			for(var i:int=0; i<_size; i++)
			{
				s = new Square();
				
				/*
				* The more layout instances that are having items added to themselves, the 
				* greater the performance will be hampered by automatically calculating the
				* new node's position. It is advised to set the 'moveToCoordinates' property 
				* to 'false'.
				* 
				* The second parameter, 'addToStage' should always be set to 'false' when dealing
				* with multiple layouts in a loop such as this as you will just be repeatedly
				* adding the same DisplayObject to each layout's target - which is almost always
				* the same.
				*/
				_stack.addToLayout(s, false, false);
				_verticalLine.addToLayout(s, false, false);
				_horizontalLine.addToLayout(s, false, false);
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