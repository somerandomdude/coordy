package libraryintegration
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	
	import flash.events.Event;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.BasicView;

	public class CoordyPapervision3D extends BasicView
	{
		public static const SIZE:int=100;
		
		private var _scene3d:Scene3D;
		private var _camera3d:Camera3D;
		private var _wave:Wave3d;
		private var _angle:Number=0;
		private var _angle2:Number=0;
		private var _angle3:Number=0;
		private var _container:DisplayObject3D;
		
		public function CoordyPapervision3D()
		{
			super(0, 0, true, true, "Target");
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{			
			_container = new DisplayObject3D();
			
			_wave = new Wave3d(1400, 400, 400);
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			_wave.x=-700
			
			var flatShadeMaterial:FlatShadeMaterial =new FlatShadeMaterial(new PointLight3D(), 0xFFFFFF, 0x5d504f);
 
			var materialsList:MaterialsList = new MaterialsList();
			materialsList.addMaterial(flatShadeMaterial, "all");
			 
			var cube:Cube;		
			
			scene.addChild(_container);
			for(var i:int=0; i<SIZE; i++)
			{
				cube = new Cube(materialsList, 20, 20, 20);
				_wave.addToLayout(cube, true);
				_container.addChild(cube);
				
			}

			camera.x = camera.y = camera.z = 800;
			camera.focus = 400;
			camera.zoom = 1.4;
			
			startRendering();
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			_angle+=2;
			_angle2+=1;
			_angle3+=2.5;
			camera.x = 300+Math.cos(_angle*Math.PI/180)*600;
			camera.z = Math.sin(_angle*Math.PI/180)*600;
			
			_container.rotationX+=1;
			_container.rotationY-=1;
			_container.rotationZ+=1;
			_wave.rotation=Math.cos(_angle3*Math.PI/180)*360;
			_wave.width=1000+Math.sin(_angle2*Math.PI/180)*400;
			_wave.height=400+Math.sin(_angle2*Math.PI/180)*160;
			_wave.depth=400+Math.sin(_angle2*Math.PI/180)*160;
			_wave.heightMultiplier=Math.sin(_angle2*Math.PI/180)*6;
			_wave.x=-(_wave.width/2);
			
			_wave.jitterX=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterY=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterZ=Math.cos(_angle*Math.PI/180)*90;
			_wave.frequency=1.5+Math.sin(_angle*Math.PI/180)*.25;
			
			_wave.updateAndRender();
			super.onRenderTick(event);
		}
	}
}
