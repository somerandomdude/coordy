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
	import com.somerandomdude.coordy.nodes.threedee.Node3d;
	
	import flash.display.DisplayObject;

	public class OrderedNode3d extends Node3d
	{
		private var _order:int;
		
		/**
		 * Mutator/accessor for node's order in the layout
		 * @return Node's order
		 * 
		 */
		public function get order():Number { return this._order; }
		public function set order(value:Number):void { this._order=value; }
		
		/**
		 * Node used for Stack3d layouts
		 * 
		 * @see com.somerandomdude.coordy.layouts.threedee.Stack3d
		 * 
		 * @param link
		 * @param order
		 * @param x
		 * @param y
		 * @param z
		 * @param jitterX
		 * @param jitterY
		 * @param jitterZ
		 * 
		 */		
		public function OrderedNode3d(link:DisplayObject=null, order:int=0, x:Number=0, y:Number=0, z:Number=0, jitterX:Number=0, jitterY:Number=0, jitterZ:Number=0)
		{
			super(link, x, y, z, jitterX, jitterY, jitterZ);
			this._order=order;
		}
		
		/**
		 * Creates an exact copy of node with link and position properties carried over
		 * 
		 * @return Cloned node
		 * 
		 */		
		override public function clone():INode3d 
		{ 
			var n:OrderedNode3d = new OrderedNode3d(link, order, x, y, z, jitterX, jitterY, jitterZ);
			return n; 
		}
		
		/**
		 * Packages the node as a generic object - mainly used for exporting layout data.
		 *
		 * @return Generic object containing all the node's layout properties
		*/
		override public function toObject():Object
		{
			return {order:_order, x:_x, y:_y, z:_z, rotation:_rotation};
		}
		
	}
}