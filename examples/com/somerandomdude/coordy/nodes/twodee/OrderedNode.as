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
package com.somerandomdude.coordy.nodes.twodee
{
	import flash.display.DisplayObject;

	public class OrderedNode extends Node2d
	{
		private var _order:int;
		
		/**
		 * Mutator/accessor for the node's order in the layout. Works in ascending order
		 * @return Integer for node's order in layout
		 * 
		 */		
		public function get order():Number { return this._order; }
		public function set order(value:Number):void { this._order=value; }
		
		/**
		 * Node used for HorizontalLine, VerticalLine and Stack layouts
		 * 
		 * @see com.somerandomdude.coordy.layouts.twodee.HorizontalLine
		 * @see com.somerandomdude.coordy.layouts.twodee.VerticalLine
		 * @see com.somerandomdude.coordy.layouts.twodee.Stack
		 * 
		 * @param link 			The node's target DisplayObject
		 * @param order			Node's order in the layout
		 * @param x 			Node's x position
		 * @param y 			Node's y position
		 * @param jitterX 		Node's x-jitter value
		 * @param jitterY 		Node's y-jitter value
		 * 
		 */		
		public function OrderedNode(link:DisplayObject=null, order:int=0, x:Number=0, y:Number=0, jitterX:Number=0, jitterY:Number=0)
		{
			super(link, x, y, jitterX, jitterY);
			this._order=order;
		}
		
		/**
		 * Creates an exact copy of node with link and position properties carried over
		 * 
		 * @return Cloned node
		 * 
		 */	
		override public function clone():INode2d { return new OrderedNode(_link, _order, _x, _y, _jitterX, _jitterY); }
		
	}
}