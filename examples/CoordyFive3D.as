package {
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.threedee.Ellipse3d;
	import com.somerandomdude.coordy.layouts.threedee.Grid3d;
	import com.somerandomdude.coordy.layouts.threedee.Scatter3d;
	import com.somerandomdude.coordy.layouts.threedee.Snapshot3d;
	import com.somerandomdude.coordy.layouts.threedee.Spheroid3d;
	import com.somerandomdude.coordy.layouts.threedee.Spiral3d;
	import com.somerandomdude.coordy.layouts.threedee.Stack3d;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	import com.somerandomdude.coordy.layouts.threedee.WaveEllipse3d;
	
	import five3D.display.DynamicText3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import five3D.geom.Point3D;
	import five3D.typography.HelveticaBold;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CoordyFive3D extends Sprite
	{
		private var _scene3d:Scene3D;
		private var _wave:Wave3d;
		private var _angle:Number=0;
		private var _angle2:Number=0;
		private var _angle3:Number=0;
		
		public function CoordyFive3D()
		{
			
			_scene3d = new Scene3D();
			_scene3d.ambientLightIntensity=4;
			
			_scene3d.ambientLightVector=new Point3D(20, 20, 20);
			_scene3d.x = 300;
			_scene3d.y = 200;
			_scene3d.z=200;
			addChild(_scene3d);
			
			// We create a new Sprite3D named "sign", draw a rounded rectangle inside and add it to the "scene" display list.
			
			_wave = new Wave3d(700, 700, 300);
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			_wave.x=-350
		
			var sign:Sprite3D = new Sprite3D();
			var text:DynamicText3D;
			for(var i:int=0; i<90; i++)
			{
				sign = new Sprite3D();
				sign.graphics3D.beginFill(0xff1e00);
				sign.graphics3D.drawRoundRect(-15, -15, 30, 30, 6, 6);
				
				sign.graphics3D.endFill();
			
				_wave.addToLayout(sign, true);
				_scene3d.addChild(sign);
				
			}
		
			this.addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		private function onRenderTick(event:Event=null):void
		{
			_angle+=2;
			_angle2+=1;
			_angle3+=2.5;
			
			_scene3d.rotationZ+=2;
			
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
