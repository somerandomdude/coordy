package libraryintegration
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
	import flash.events.Event;
	
	public class CoordyAlternativa3D extends Sprite
	{
		public static const SIZE:int=70;
		
		private var _scene:Scene3D;
		private var _view:View;
		private var _camera:Camera3D;
		private var _cameraController:CameraController; 
		private var _angle:Number=0;
		private var _angle2:Number=0;
		private var _angle3:Number=0;
		private var _wave:Wave3d;
		
		public function CoordyAlternativa3D()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			_wave = new Wave3d(1400, 700, 300);
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			_wave.x=-700;
			
			_scene = new Scene3D();
			_scene.root = new Object3D();
			var plane:Plane = new Plane();
			plane.y=-100;
			var box:Box; 
			for (var i:int = 0; i < SIZE; i++)
			{
				box = new Box(20, 20, 20, 1, 1, 1);
				box.cloneMaterialToAllSurfaces(new FillMaterial(0x5d504f));
				
				_wave.addToLayout(box, true);
				_scene.root.addChild(box);
			}
			
			_camera = new Camera3D();
			_camera.x = 700;
			_camera.y = 700;
			_camera.z = 700;
			_scene.root.addChild(_camera);
			
			_view = new View();
			addChild(_view);
			_view.camera = _camera;

			_cameraController = new CameraController(stage);
			_cameraController.camera = _camera;
			_cameraController.setDefaultBindings();
			_cameraController.checkCollisions = false;
			_cameraController.lookAt(plane.coords);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			_view.width = 750;
			_view.height = 350;
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
		}
		
		private function enterFrameHandler(event:Event):void {
			
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
			
			_scene.calculate();
		}
	}
}

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.text.AntiAliasType;

internal class Text extends TextField
{
	private var _format:TextFormat;
	
	public function Text()
	{
		_format = new TextFormat();
		_format.font='Arial';
		_format.size=11;
	
		textColor=0x333333;
		antiAliasType=AntiAliasType.ADVANCED;
		wordWrap=true;
		multiline=true;
		autoSize=TextFieldAutoSize.LEFT;
		width=400;
		defaultTextFormat=_format;
	}
}