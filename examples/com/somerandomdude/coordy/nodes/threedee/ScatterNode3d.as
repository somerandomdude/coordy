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
	
	import flash.display.DisplayObject;
	
	final public class ScatterNode3d extends Node3d implements INode3d
	{	
		
		private var _xRelation:Number;
		private var _yRelation:Number;
		private var _zRelation:Number;
		
		/**
		 * Mutator/accessor for node's relative x position in the scatter layout
		 * 
		 * @return value Relative x position
		 * 
		 */
		public function get xRelation():Number { return _xRelation; }
		public function set xRelation(value:Number):void { this._xRelation=value; }
		
		/**
		 * Mutator/accessor for node's relative y position in the scatter layout
		 * 
		 * @return value Relative y position
		 * 
		 */
		public function get yRelation():Number { return _yRelation; }
		public function set yRelation(value:Number):void { this._yRelation=value; }
		
		/**
		 * Mutator/accessor for node's relative z position in the scatter layout
		 * 
		 * @return value Relative z position
		 * 
		 */
		public function get zRelation():Number { return _zRelation; }
		public function set zRelation(value:Number):void { this._zRelation=value; }
		
		/**
		 * Node used for Scatter3d layouts
		 * 
		 * @see com.somerandomdude.coordy.layouts.threedee.Scatter3d
		 * 
		 * @param link The node's target DisplayObject
		 * @param x Node's x position within the scatter layout
		 * @param y Node's y position within the scatter layout
		 * @param z Node's z position within the scatter layout
		 * @param rotation Node's rotational value
		 * 
		 */		
		public function ScatterNode3d(link:DisplayObject=null, x:Number=0, y:Number=0, z:Number=0, rotation:Number=0)
		{
			super(link, x, y, z);
			this._rotation=rotation;
		}

		/**
		 * Creates an exact copy of node with link and position properties carried over
		 * 
		 * @return Cloned node
		 * 
		 */
		override public function clone():INode3d 
		{ 
			var n:ScatterNode3d = new ScatterNode3d(link, x, y, z, rotation);
			n.xRelation=_xRelation;
			n.yRelation=_yRelation;
			n.zRelation=_zRelation;
			return n; 
		}
		
	}
}