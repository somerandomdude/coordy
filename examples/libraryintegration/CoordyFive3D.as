package libraryintegration
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	
	import five3D.display.DynamicText3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import five3D.geom.Point3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CoordyFive3D extends Sprite
	{
		public static const SIZE:int=100;
		
		private var _scene3d:Scene3D;
		private var _wave:Wave3d;
		private var _angle:Number=0;
		private var _angle2:Number=0;
		private var _angle3:Number=0;
		
		public function CoordyFive3D()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			_scene3d = new Scene3D();
			_scene3d.ambientLightIntensity=4;
			
			_scene3d.ambientLightVector=new Point3D(20, 20, 20);
			_scene3d.x = 300;
			_scene3d.y = 300;
			_scene3d.z=300;
			addChild(_scene3d);
			
			_wave = new Wave3d(1400, 700, 700);
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			_wave.x=-700;
		
			var sign:Sprite3D = new Sprite3D();
			var text:DynamicText3D;
			for(var i:int=0; i<SIZE; i++)
			{
				sign = new Sprite3D();
				sign.graphics3D.beginFill(0x5d504f);
				sign.graphics3D.drawRoundRect(-10, -10, 20, 20, 6, 6);
				
				sign.graphics3D.endFill();
			
				_wave.addToLayout(sign, true);
				_scene3d.addChild(sign);
				
			}
		
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
		}
		
		private function enterFrameHandler(event:Event):void
		{
			_angle+=2;
			_angle2+=1;
			_angle3+=2.5;
			
			_scene3d.rotationZ=_angle;
			
			_wave.rotation=Math.cos(_angle3*Math.PI/180)*360;
			_wave.height=400+Math.sin(_angle2*Math.PI/180)*160;
			_wave.depth=400+Math.sin(_angle2*Math.PI/180)*160;
			
			_wave.jitterX=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterY=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterZ=Math.cos(_angle*Math.PI/180)*90;
			_wave.frequency=1.5+Math.sin(_angle*Math.PI/180)*.25;
			
			_wave.updateAndRender();
			
		}
	}
}
