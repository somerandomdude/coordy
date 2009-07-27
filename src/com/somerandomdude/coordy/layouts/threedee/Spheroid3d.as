 /*
The MIT License

Copyright (c) 2009 P.J. Onori (pj@somerandomdude.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

//TODO - Credit sphere rotation code


  /**
 *
 *
 * @author      P.J. Onori
 * @version     0.1
 * @description
 * @url 
 */
package com.somerandomdude.coordy.layouts.threedee {
	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.helpers.Distribute;
	import com.somerandomdude.coordy.helpers.Vertex;
	import com.somerandomdude.coordy.nodes.threedee.INode3d;
	import com.somerandomdude.coordy.nodes.threedee.Node3d;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Spheroid3d extends Layout3d implements ILayout3d
	{
		
		private static const PI:Number=Math.PI;
		private static const PI_180:Number=PI/180;
		
		private var _rotationY:Number=90;
		private var _rotationZ:Number=90;
		
		private var _verts:Array;
		private var _radius:Number;
		
		/**
		 * Mutator/accessor for radius of spheroid. <strong>Note</strong> - Setting the radius will create uniform dimensions for width, height and depth
		 * @return Radius of the sphere
		 * 
		 */		
		public function get radius():Number { return this._radius; }	
		public function set radius(value:Number):void
		{
			this._radius=value;
			this._width=_radius*2;
			this._height=_radius*2;
			this._depth=_radius*2;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for rotation property along the x-axis
		 *
		 * @param	value	Global x-rotation of layout   
		 */
		public function get rotationX():Number { return this._rotation; }
		public function set rotationX(value:Number):void
		{
			this._rotation=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for rotation property along the y-axis
		 *
		 * @param	value	Global y-rotation of layout   
		 */	
		public function get rotationY():Number { return this._rotationY; }
		public function set rotationY(value:Number):void
		{
			this._rotationY=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for rotation property along the z-axis
		 *
		 * @param	value	Global z-rotation of layout   
		 */		
		public function get rotationZ():Number { return this._rotationZ; }
		public function set rotationZ(value:Number):void
		{
			this._rotationZ=value;
			this._updateFunction();
		}
		
		/**
		 * Distributes nodes in a 3d spheroid.
		 * 
		 * @param target		DisplayObjectContainer which parents all objects in the layout
		 * @param width			Width of the spheroid
		 * @param height		Height of the spheroid
		 * @param depth			Depth of the spheroid
		 * @param x				x position of the spheroid
		 * @param y				y position of the spheroid
		 * @param z				z position of the spheroid
		 * @param rotation		Rotation of the spheroid along the x-axis
		 * @param rotationY		Rotation of the spheroid along the y-axis
		 * @param rotationZ		Rotation of the spheroid along the z-axis
		 * @param jitterX		Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY		Jitter multiplier for the layout's nodes on the y axis
		 * @param jitterZ		Jitter multiplier for the layout's nodes on the z axis
		 * 
		 * @example 
		 * <pre class="prettyprint">
		 * _spheroid=new Spheroid3d(this, 150, 150, 150, 400, 400, 0);
		 * 
		 * var s:Shape;
		 * for(var i:int=0; i<100; i++)
		 * {
		 * 		s = new Shape();
		 * 		s.graphics.beginFill(0);
		 * 		s.graphics.drawCircle(0, 0, 3);
		 * 		s.graphics.endFill();
		 * 		
		 * 		_spheroid.addToLayout(s, false);
		 * }
			
		 * _spheroid.distributeNodes();
		 * _spheroid.updateAndRender();
		 * </pre>			
		 */		
		public function Spheroid3d(target:DisplayObjectContainer, 
								width:Number, 
								height:Number, 
								depth:Number, 
								x:Number=0, 
								y:Number=0, 
								z:Number=0, 
								rotation:Number=0, 
								rotationY:Number=0, 
								rotationZ:Number=0, 
								jitterX:Number=0, 
								jitterY:Number=0, 
								jitterZ:Number=0):void
		{
			
			super(target);
			
			this._nodes = new Array();
			this._width=width;
			this._height=height;
			this._depth=depth;
			this._x=x;
			this._y=y;
			this._z=z;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			this._jitterZ=jitterZ;
			this._rotation=rotation;
			this._rotationY=rotationY;
			this._rotationZ=rotationZ;
			this._radius=Math.max(this._width, this._height, this._depth);
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */
		override public function toString():String { return LayoutType.SPHEROID_3D; }
		
		/**
		 * Adds DisplayObject to layout in next available position
		 *
		 * @param  object  DisplayObject to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:DisplayObject,  moveToCoordinates:Boolean=true, addToStage:Boolean=true):INode3d
		{
			var node:Node3d = new Node3d(object,0,0,0,Math.random()*((Math.random()>.5?1:-1)), Math.random()*((Math.random()>.5?1:-1)), Math.random()*((Math.random()>.5?1:-1)));
			this.addNode(node);
			
			//this.update();
			
			if(moveToCoordinates) this.render();
			if(addToStage) this._target.addChild(object);
			
			return node;
		}
		
		/**
		 * Attempted to create an even pattern of nodes across the surface of the spheroid. The higher the number of iterations, the more accurate. 
		 * <strong>Note</strong> - The processing time increases exponentially the higher the iterations go.
		 * 
		 * @param iterations	The number of passes to create an even distribution of nodes across the spheroid
		 * 
		 */		
		public function distributeNodes(iterations:int=25):void
		{
			this._verts = new Array();
			for(var i:int =0; i<this._size; i++)
			{
				var v:Vertex = new Vertex( Math.random()-.5, Math.random()-.5,Math.random()-.5 );
				this._verts.push(v);
			}
			
			this._verts = Distribute.distribute(this._verts, iterations);
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 * Much of the code in this method was scooped up at http://reflektions.com/miniml/template_permalink.asp?id=293
		 * 
		 */			
		override public function update():void
		{
			this._radius=Math.max(this._width, this._height, this._depth)/2;
			
			var rX:Number	= this._rotation*3.6 * PI_180;		
			var rY:Number	= this._rotationY*3.6 * PI_180;
			var rZ:Number	= this._rotationZ*3.6 * PI_180;
		
		
			for(var i:int =0; i<this._size; i++)
			{
				
				var c:Node3d = this._nodes[i];
				
				c.x=(this._verts[i].x*this._width/2);
				c.y=(this._verts[i].y*this._height/2);
				c.z=(this._verts[i].z*this._depth/2);
						
				var tempX:Number = (c.x * Math.cos(rY)) - (c.z * Math.sin(rY));
				var tempZ:Number = (c.x * Math.sin(rY)) + (c.z * Math.cos(rY));
			
				var dz:Number	 =  (tempZ * Math.cos(rX)) - (c.y * Math.sin(rX));
				var tempY:Number =  (tempZ * Math.sin(rX)) + (c.y * Math.cos(rX));
		
				var dx:Number	=  (tempX * Math.cos(rZ)) + (tempY * Math.sin(rZ));
				var dy:Number	=  (tempY * Math.cos(rZ)) - (tempX * Math.sin(rZ));
				
				c.x=(_x)+dx+(c.jitterX*this._jitterX);
				c.y=(_y)+dy+(c.jitterY*this._jitterY);
				c.z=(_z)+dz+(c.jitterZ*this._jitterZ);

			}
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return Spheroid3d clone of object
		*/	
		override public function clone():ILayout3d
		{
			return new Spheroid3d(this._target, this._width, this._height, this._depth, this._x, this._y, this._z, this._rotation, this._rotationY, this._rotationZ, this._jitterX, this._jitterY, this._jitterZ);
		}

	}
}