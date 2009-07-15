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
	import com.somerandomdude.coordy.nodes.threedee.INode3d;
	import com.somerandomdude.coordy.nodes.threedee.ScatterNode3d;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Scatter3d extends Layout3d implements ILayout3d
	{
		
		private var _jitter:Number;
		private var _jitterRotation:Boolean;
		
		/**
		 * Mutator/accessor for jitter property
		 *
		 * @return	Global jitter value of scatter layout   
		 */
		public function get jitter():Number { return this._jitter; } 
		public function set jitter(value:Number):void
		{
			this._jitter=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for property determining whether the layout's nodes' rotation is randomly jittered
		 *
		 * @return Boolean value of jitter rotation state 	  
		 */
		public function get jitterRotation():Boolean { return this._jitterRotation; } 
		public function set jitterRotation(value:Boolean):void
		{
			this._jitterRotation=value;
			this._updateFunction();
		}
		
		/**
		 * Distributes nodes in a scattered fashion in all 3 dimensions.
		 * 
		 * @param target			DisplayObjectContainer which parents all objects in the layout
		 * @param width 			Width of the scatter
		 * @param height 			Height of the scatter
		 * @param depth 			Depth of the scatter
		 * @param jitter 			Jitter multiplier of scatter
		 * @param x 				x position of the scatter
		 * @param y 				y position of the scatter
		 * @param z 				z position of the scatter
		 * @param jitterRotation	Boolean determining if nodes are randomly rotated
		 * 
		 */		
		public function Scatter3d(target:DisplayObjectContainer, 
								width:Number, 
								height:Number, 
								depth:Number, 
								jitter:Number=1, 
								x:Number=0, 
								y:Number=0, 
								z:Number=0, 
								jitterRotation:Boolean=false):void
		{
			super(target);
			this._width = width;
			this._height = height;
			this._depth=depth;
			this._x = x;
			this._y = y;
			this._z = z;
			this._jitter=jitter;
			this._jitterRotation=jitterRotation;
			this._nodes = new Array();
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */
		override public function toString():String { return LayoutType.SCATTER_3D; }
			
		/**
		 * Adds DisplayObject to layout in next available position
		 *
		 * @param  object  DisplayObject to add to organizer
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
		 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
		 * 
		 * @return newly created node object containing a link to the object
		 */	
		override public function addToLayout(object:DisplayObject, moveToCoordinates:Boolean=true, addToStage:Boolean=true):INode3d
		{
			var p:int = (Math.round(Math.random())) ? -1:1;
			var xPos:Number = (_width/2+((Math.random()*_width*_jitter)/2)*p)+_x;
			p = (Math.round(Math.random())) ? -1:1;
			var yPos:Number = (_height/2+((Math.random()*_height*_jitter)/2)*p)+_y;
			p = (Math.round(Math.random())) ? -1:1;
			var zPos:Number = (_depth/2+((Math.random()*_depth*_jitter)/2)*p)+_z;
			var node:ScatterNode3d = new ScatterNode3d(object,xPos,yPos,zPos,(_jitterRotation)?(Math.random()*p*360):0);
			node.xRelation=(node.x-this._width/2)/this._width/2;
			node.yRelation=(node.y-this._height/2)/this._height/2;
			node.zRelation=(node.z-this._depth/2)/this._depth/2;
			
			this.addNode(node);
			
			if(addToStage) this._target.addChild(node.link);
			if(moveToCoordinates) node.link.x=node.x,node.link.y=node.y, node.link.z=node.z;
			
			return node;
		}
		
		/**
		 * Applies all layout property values to all cells/display objects in the collection
		 *
		 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
		 */
		override public function render():void
		{
			for(var i:int=0; i<this._size; i++)
			{
				this._nodes[i].link.x=this._nodes[i].x;
				this._nodes[i].link.y=this._nodes[i].y;
				this._nodes[i].link.z=this._nodes[i].z;
				this._nodes[i].link.rotationX=this._nodes[i].rotation;
			}
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */	
		override public function update():void
		{
			for(var i:int=0; i<this._size; i++)
			{
				_nodes[i].x=(_nodes[i].xRelation*this._width)+this._x;
				_nodes[i].y=(_nodes[i].yRelation*this._height)+this._y;
				_nodes[i].z=(_nodes[i].zRelation*this._depth)+this._z;
			}
		}
		
		/**
		 * Re-scatters layout and adjusts cell links appropriately
		 *
		 */
		public function scatter():void
		{
			var p:int;
			var xPos:Number;
			var yPos:Number;
			var zPos:Number;
			for(var i:int=0; i<this._size; i++)
			{
				p = (Math.round(Math.random())) ? -1:1;
				xPos = (_width/2+((Math.random()*_width*_jitter)/2)*p)+_x;
				p = (Math.round(Math.random())) ? -1:1;
				yPos = (_height/2+((Math.random()*_height*_jitter)/2)*p)+_y;
				p = (Math.round(Math.random())) ? -1:1;
				zPos = (_depth/2+((Math.random()*_depth*_jitter)/2)*p)+_z;
				
				this._nodes[i].x=xPos;
				this._nodes[i].y=yPos;
				this._nodes[i].z=zPos;
			}
			this._updateFunction();
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return ScatterOrganizer clone of object
		*/
		public function clone():ILayout3d
		{
			return new Scatter3d(_target, _width, _height, _depth, _jitter, _x, _y, _z, _jitterRotation);
		}
		
	}
}