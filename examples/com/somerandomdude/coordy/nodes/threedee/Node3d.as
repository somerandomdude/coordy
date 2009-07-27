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
package com.somerandomdude.coordy.nodes.threedee
{
	import com.somerandomdude.coordy.nodes.Node;
	
	import flash.display.DisplayObject;
	
	public class Node3d extends Node implements INode3d
	{
		protected var _x:Number;
		protected var _y:Number;
		protected var _jitterX:Number;
		protected var _jitterY:Number;
		protected var _z:Number;
		protected var _jitterZ:Number;
		protected var _rotation:Number=0;
		
		/**
		 * Mutator/accessor for node's x position
		 * 
		 * @return value Virtual x position for node
		 * 
		 */
		public function get x():Number { return _x; }		
		public function set x(value:Number):void { this._x=value; }
		
		/**
		 * Mutator/accessor for node's y position 
		 * 
		 * @return value Virtual y position for node
		 * 
		 */
		public function get y():Number { return _y; }		
		public function set y(value:Number):void { this._y=value; }
		
		/**
		 * Mutator/accessor for node's z position
		 * 
		 * @return value Virtual z position for node
		 * 
		 */
		public function get z():Number { return _z; }		
		public function set z(value:Number):void { this._z=value; }
		
		/**
		 * Mutator/accessor for node's x jitter value
		 * 
		 * @return value Jitter multiplier for the x position of the node
		 * 
		 */
		public function get jitterX():Number { return _jitterX; }		
		public function set jitterX(value:Number):void { this._jitterX=Math.random()*value*((Math.random()>.5)?-1:1); }
		
		/**
		 * Mutator/accessor for node's y jitter value
		 * 
		 * @return value Jitter multiplier for the y position of the node
		 * 
		 */
		public function get jitterY():Number { return _jitterY; }		
		public function set jitterY(value:Number):void { this._jitterY=Math.random()*value*((Math.random()>.5)?-1:1); }
		
		/**
		 * Mutator/accessor for node's z jitter value 
		 * 
		 * @return value Jitter multiplier for the z position of the node
		 * 
		 */
		public function get jitterZ():Number { return _jitterZ; }		
		public function set jitterZ(value:Number):void { this._jitterZ=value; }
		
		/**
		 * Mutator/accessor for node's rotational value
		 * @return Node's rotation
		 * 
		 */		
		public function get rotation():Number { return this._rotation; }	
		public function set rotation(value:Number):void { this._rotation=value; }
		
		/**
		 * Base node for all 3D layouts. Contains basic information for recording and projecting 3D positioning. Used in Sphere3d and Snapshot3d layouts.
		 * 
		 * @see com.somerandomdude.coordy.layouts.threedee.Sphere3d
		 * @see com.somerandomdude.coordy.layouts.threedee.Snapshot3d
		 * 
		 * @param link The node's target DisplayObject
		 * @param x Node's x position
		 * @param y Node's y position
		 * @param z Node's z position
		 * @param jitterX Node's x-jitter value
		 * @param jitterY Node's y-jitter value
		 * @param jitterZ Node's z-jitter value
		 * 
		 */		
		public function Node3d(link:DisplayObject=null, x:Number=0, y:Number=0, z:Number=0, jitterX:Number=0, jitterY:Number=0, jitterZ:Number=0)
		{
			super(link);
			this._x=x;
			this._y=y;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			this._z=z;
			this._jitterZ=jitterZ;
		}
		
		/**
		 * Creates an exact copy of node with link and position properties carried over
		 * 
		 * @return Cloned node
		 * 
		 */		
		public function clone():INode3d 
		{ 
			var n:Node3d = new Node3d(link, x, y, z, jitterX, jitterY, jitterZ);
			n.rotation=_rotation;
			return n; 
		}

	}
}