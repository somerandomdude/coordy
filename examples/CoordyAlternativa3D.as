package
{
	import alternativa.engine3d.controllers.CameraController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Scene3D;
	import alternativa.engine3d.display.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.primitives.Plane;
	
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class CoordyAlternativa3D extends Sprite
	{
		private var scene:Scene3D;
		private var view:View;
		private var camera:Camera3D;
		private var cameraController:CameraController; 
		private var _angle:Number=0;
		private var _angle2:Number=0;
		private var _angle3:Number=0;
		private var _wave:Wave3d;
		
		public function CoordyAlternativa3D()
		{
			super();
			
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_wave = new Wave3d(700, 700, 300);
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			_wave.x=-350;
			
			scene = new Scene3D();
			scene.root = new Object3D();
			var plane:Plane = new Plane();
			plane.y=-100;
			var box:Box;
			for (var i:int = 0; i < 30; i++)
			{
				box = new Box(30, 30, 30, 1, 1, 1);
				box.cloneMaterialToAllSurfaces(new FillMaterial(0xff1e00));
				
				_wave.addToLayout(box, true);
				scene.root.addChild(box);
			}
			
			camera = new Camera3D();
			camera.x = 700;
			camera.y = 700;
			camera.z = 700;
			scene.root.addChild(camera);
			
			view = new View();
			addChild(view);
			view.camera = camera;

			cameraController = new CameraController(stage);
			cameraController.camera = camera;
			cameraController.setDefaultBindings();
			cameraController.checkCollisions = false;
			cameraController.lookAt(plane.coords);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
			
		}
		
		private function onEnterFrame(e:Event):void {
			
			_angle+=2;
			_angle2+=1;
			_angle3+=2.5;
			
			_wave.rotation=Math.cos(_angle3*Math.PI/180)*360;
			_wave.height=400+Math.sin(_angle2*Math.PI/180)*160;
			_wave.depth=400+Math.sin(_angle2*Math.PI/180)*160;
			
			_wave.jitterX=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterY=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterZ=Math.cos(_angle*Math.PI/180)*90;
			_wave.frequency=1.5+Math.sin(_angle*Math.PI/180)*.25;
			
			_wave.updateAndRender();
			
			scene.calculate();
			
		}
		
	}
}