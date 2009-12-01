package libraryintegration
{
	import away3d.containers.*;
	import away3d.core.base.*;
	import away3d.primitives.*;
	
	import com.somerandomdude.coordy.constants.LayoutUpdateMethod;
	import com.somerandomdude.coordy.layouts.threedee.Wave3d;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CoordyAway3D extends Sprite
	{
		public static const SIZE:int=100;
		
		private var _view:View3D;
		private var _wave:Wave3d;
		private var _angle:Number=0;
		private var _angle2:Number=0;
		private var _angle3:Number=0;
		private var _plane:Object3D;
		
		public function CoordyAway3D()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			_view = new View3D({x:350, y:200});
			addChild(_view);
			
			_plane = new Plane({material:"yellow#", name:"plane", y:-100, width:1000, height:1000, pushback:true});
			 
			 _plane.visible=false;
			_view.scene.addChild(_plane);
			
			_view.camera.moveTo(200, 200, 200);
			_view.camera.moveBackward(1500);
			_view.camera.moveUp(1700);
			
			_wave = new Wave3d(1400, 700, 700);
			_wave.updateMethod=LayoutUpdateMethod.NONE;
			_wave.x=-700
		
			var cube:Object3D;
			for(var i:int=0; i<SIZE; i++)
			{
				cube = new Cube({material:0x5d504f, name:"cube", x: -15, y:-15, z: -15, width:30, height:30, depth:30});

				_wave.addToLayout(cube, true);
				_view.scene.addChild(cube)
				
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
			
			_view.camera.x = Math.cos(_angle*Math.PI/180)*1300;
			_view.camera.z = Math.sin(_angle*Math.PI/180)*1300;
			_view.camera.lookAt(_plane.position);
			
			_wave.rotation=Math.cos(_angle3*Math.PI/180)*360;
			_wave.height=400+Math.sin(_angle2*Math.PI/180)*160;
			_wave.depth=400+Math.sin(_angle2*Math.PI/180)*160;
			
			_wave.jitterX=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterY=Math.cos(_angle*Math.PI/180)*90;
			_wave.jitterZ=Math.cos(_angle*Math.PI/180)*90;
			_wave.frequency=2+Math.sin(_angle*Math.PI/180);
			
			_wave.updateAndRender();
			_view.render();
		}
	}
}
