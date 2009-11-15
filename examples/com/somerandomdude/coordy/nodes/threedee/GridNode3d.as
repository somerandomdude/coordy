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
	
	public class GridNode3d extends Node3d implements INode3d
	{
		
		private var _row:int;
		private var _column:int;
		private var _layer:int;
		
		/**
		 * Mutator/accessor for node's column
		 * 
		 * @return value The column of the grid in which the node resides
		 * 
		 */
		public function get column():int { return _column; }
		public function set column(value:int):void { this._column=value; } 
		 
		/**
		 * Mutator/accessor for node's row
		 * 
		 * @return value The row of the grid in which the node resides
		 * 
		 */ 
		public function get row():int { return _row; }
		public function set row(value:int):void { this._row=value; }
		
		/**
		 * Mutator/accessor for node's layer
		 * 
		 * @return value The layer of the grid in which the node resides
		 * 
		 */
		public function get layer():int { return _layer; }
		public function set layer(value:int):void { this._layer=value; }
		
		/**
		 * Node used for Grid3d layouts
		 * 
		 * @see com.somerandomdude.coordy.layouts.threedee.Grid3d
		 * 
		 * @param link The node's target DisplayObject
		 * @param column The column in which the node resides
		 * @param row The row in which the node resides
		 * @param layer The layer in which the node resides
		 * @param x Node's x position
		 * @param y Node's y position
		 * @param z Node's z position
		 * @param rotation Node's rotational value
		 * @param jitterX Node's x-jitter value
		 * @param jitterY Node's y-jitter value
		 * @param jitterZ Node's z-jitter value
		 * 
		 */	
		public function GridNode3d(link:Object=null, column:int=-1, row:int=-1, layer:int=-1, x:Number=0, y:Number=0, z:Number=0, jitterX:Number=0, jitterY:Number=0, jitterZ:Number=0)
		{
			super(link, x, y, z, jitterX, jitterY, jitterZ);
			this._row=row;
			this._column=column;
			this._layer=layer;
		}
		
		/**
		 * Creates an exact copy of node with link and position properties carried over
		 * 
		 * @return Cloned node
		 * 
		 */
		override public function clone():INode3d 
		{ 
			var n:GridNode3d = new GridNode3d(link, column, row, layer, x, y, z, jitterX, jitterY, jitterZ);
			return n; 
		}
		
		/**
		 * Packages the node as a generic object - mainly used for exporting layout data.
		 *
		 * @return Generic object containing all the node's layout properties
		*/
		override public function toObject():Object
		{
			return {row:_row, column:_column, layer:_layer, x:_x, y:_y, z:_z};
		}
		
	}
}