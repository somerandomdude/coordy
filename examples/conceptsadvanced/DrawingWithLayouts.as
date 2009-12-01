package conceptsadvanced
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.threedee.ILayout3d;
	import com.somerandomdude.coordy.layouts.twodee.Wave;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class DrawingWithLayouts extends Sprite
	{
		public static const SIZE:int=100;
		public static const LAYOUT_WIDTH:Number=750;
		public static const LAYOUT_HEIGHT:Number=350;
		
		private var _layout:Wave
		private var _angle:int=0;
		
		public function DrawingWithLayouts()
		{
			super();
			
			_layout = new Wave(LAYOUT_WIDTH, LAYOUT_HEIGHT);
			_layout.x=-50, _layout.y=LAYOUT_HEIGHT/2;
			
			/* Since we are using this layout exclusively for x/y coordinate data, we
			*  will not be adding any objects to the layout. In these situations, it is 
			*  easier to add nodes to the layout by simply calling the 'addNodes()' method
			*  with the number of nodes we would like to have.
			*
			* In addition, since there are no items in the layout to render, we are setting
			* the layout's update method to only update the node's coordinates on modification.
			* A more efficient way to handle this, however, would be to set the update method to
			* NONE and then call 'update()' after modifying all the layout's properties. Problem is, 
			* I'm kind of lazy...
			*/ 
			
			_layout.updateMethod=LayoutUpdateMethod.UPDATE_ONLY;
			_layout.addNodes(400);
			
			addEventListener(Event.ENTER_FRAME, frameHandler);
		}
		
		private function frameHandler(e:Event):void
		{
			_angle+=5;
			
			_layout.width=990+Math.cos((_angle+180)/1.5*Math.PI/180)*200;
			_layout.height=200+Math.sin(_angle/2*Math.PI/180)*50*_layout.heightMultiplier;
			_layout.frequency=4+Math.cos(_angle*1.2*Math.PI/180)*2
			_layout.heightMultiplier=.2+Math.sin((_angle+10)*Math.PI/180)*1.5
			_layout.thetaOffset=Math.sin(_angle/2*Math.PI/180)*360*_layout.frequency/3
			
			/*
			* For drawing, instead of moving items around based off a layout's node coordindate data,
			* we use it to draw segements of a line. Some layouts aren't specifically good for this 
			* method, but the Wave layout works great.
			*/
			graphics.clear();
			graphics.lineStyle(3, 0x5d504f);
			graphics.moveTo(_layout.nodes[0].x, _layout.nodes[0].y);
			for(var i:int=1; i<_layout.size; i++)
			{
				graphics.lineTo(_layout.nodes[i].x, _layout.nodes[i].y);
			}
		}
	}
}