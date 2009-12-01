package conceptsbasic
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
		public static const SIZE:int=60;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _stack:Stack;
		private var _verticalLine:VerticalLine;
		private var _horizontalLine:HorizontalLine;
		
		private var _size:int;
		
		private var _stackButton:LayoutButton;
		private var _verticalLineButton:LayoutButton;
		private var _horizontalLineButton:LayoutButton;
		
		public function SwapLayouts()
		{
			init();
		}
		
		private function init():void
		{
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_stack = new Stack(135, 6, 500, 50);
			_verticalLine = new VerticalLine(3, LAYOUT_WIDTH/2, 0);
			_horizontalLine = new HorizontalLine(3, 0, LAYOUT_HEIGHT/2);
			
			var c:Circle;
			for(var i:int=0; i<SIZE; i++)
			{
				c = new Circle(10);
				
				/*
				* The more layout instances that are having items added to themselves, the 
				* greater the performance will be hampered by automatically calculating the
				* new node's position. It is advised to set the 'moveToCoordinates' property 
				* to 'false'.
				*/
				_stack.addNode(c, false);
				_verticalLine.addNode(c, false);
				_horizontalLine.addNode(c, false);
				addChild(c);
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
			_stackButton.x=20, _stackButton.y=20;
			_verticalLineButton.x=20, _verticalLineButton.y=50;
			_horizontalLineButton.x=20, _horizontalLineButton.y=80;
			
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