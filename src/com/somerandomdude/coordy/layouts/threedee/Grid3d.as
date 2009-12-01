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
	import com.somerandomdude.coordy.events.CoordyNodeEvent;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.threedee.GridNode3d;

	public class Grid3d extends Layout3d implements ILayout3d
	{
		
		private var _rows:uint;
		private var _columns:uint;
		private var _layers:uint;
		private var _hPadding:Number=0;
		private var _yPadding:Number=0;
		private var _zPadding:Number=0;
		private var _maxNodes:int;
		
		/**
		 * Accessor for columns property
		 *
		 * @return	Column length   
		 */
		public function get columns():uint { return _columns; }
		
		/**
		 * Accessor for rows property
		 *
		 * @return	Row length   
		 */
		public function get rows():uint { return _rows; }
		
		/**
		 * Accessor for layers property
		 *
		 * @return	Layer length   
		 */
		public function get layers():uint { return _layers; }
		
		/**
		 * Mutator for x padding property
		 *
		 * @param	value	X padding of grid nodes in the layout    
		 */
		public function set paddingX(value:Number):void
		{
			this._hPadding=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator for y padding property
		 *
		 * @param	value	Y padding of grid nodes in the layout    
		 */
		public function set paddingY(value:Number):void
		{
			this._yPadding=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator for z padding property
		 *
		 * @param	value	Z padding of grid nodes in the layout    
		 */
		public function set paddingZ(value:Number):void
		{
			this._zPadding=value;
			this._updateFunction();
		}
		
		/**
		 * Accessor for x padding property
		 *
		 * @return	X padding of grid nodes in the layout   
		 */
		public function get paddingX():Number { return this._hPadding; }
		
		/**
		 * Accessor for y padding property
		 *
		 * @return	Y padding of grid nodes in the layout    
		 */
		public function get paddingY():Number { return this._yPadding; }
		
		/**
		 * Accessor for z padding property
		 *
		 * @return	Z padding of grid nodes in the layout    
		 */
		public function get paddingZ():Number { return this._zPadding; }
		
		/**
		 * Accessor for cell width property
		 *
		 * @return	Width dimension of layout node   
		 */
		public function get cellWidth():Number { return this._nodes[0].width; }
		
		/**
		 * Accessor for cell height property
		 *
		 * @return	Height dimension of layout node   
		 */
		public function get cellHeight():Number { return this._nodes[0].height; }
		
		/**
		 * Distributes nodes in a 3d grid.
		 * 
		 * @param width 		Width of the grid
		 * @param height 		Height of the grid
		 * @param depth 		Depth of the grid
		 * @param columns 		Total columns in the grid
		 * @param rows 			Total rows in the grid
		 * @param layers 		Total layers in the grid
		 * @param paddingX 		Padding of each grid cell in the x-axis
		 * @param paddingY 		Padding of each grid cell in the y-axis
		 * @param paddingZ 		Padding of each grid cell in the z-axis
		 * @param x				x position of the grid
		 * @param y				y position of the grid
		 * @param x				z position of the grid
		 * @param jitterX		Jitter multiplier for the layout's nodes on the x axis 
		 * @param jitterY		Jitter multiplier for the layout's nodes on the y axis 
		 * @param jitterZ		Jitter multiplier for the layout's nodes on the z axis 
		 * 
		 */		
		public function Grid3d(width:Number, 
								height:Number, 
								depth:Number, 
								columns:uint, 
								rows:uint, 
								layers:uint, 
								paddingX:Number=0, 
								paddingY:Number=0, 
								paddingZ:Number=0, 
								x:Number=0, 
								y:Number=0, 
								z:Number=0, 
								jitterX:Number=0, 
								jitterY:Number=0, 
								jitterZ:Number=0)
		{
			
			this._width=width;
			this._height=height;
			this._depth=depth;
			this._rows=rows;
			this._columns=columns;
			this._layers=layers;
			this._maxNodes=_rows*_columns*_layers;
			this._hPadding=paddingX;
			this._yPadding=paddingY;
			this._zPadding=paddingZ;
			this._x=x;
			this._y=y;
			this._z=z;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			this._jitterZ=jitterZ;
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */	
		override public function toString():String { return LayoutType.GRID_3D; }

		/**
		 * Get node objects by column index
		 *
		 * @param  column  cell index of grid
		 * @return      an array of node objects by column index
		 */
		public function getColumn(column:uint):Array
		{
			var c:Array = new Array();
			for(var i:int=0; i<_rows; i++)
			{
				c.push(_nodes[(i*_columns)+column]);
			}
			return c;
		}
		
		/**
		 * Get node objects by row index
		 *
		 * @param  row  row index of grid
		 * @return      an array of node objects by row index
		 */
		public function getRow(row:uint):Array
		{
			var c:Array = new Array();
			for(var i:int=row*_columns; i<(row*_columns)+_columns; i++);
			{
				c.push(_nodes[i]);
			}
			return c;
		}
		
		/**
		 * Get node objects by layer index
		 *
		 * @param  layer  layer index of grid
		 * @return      an array of node objects by layer index
		 */
		public function getLayer(layer:uint):Array
		{
			return new Array();
		}
		
		/**
		 * Removes node link of DisplayObject at specified grid coordinates
		 *
		 * @param  column  column index of grid
		 * @param  row  row index of grid
		 */
		public function removeItemAt(column:uint, row:uint):void
		{
			this.getNodeFromCoordinates(column, row).link=null;
		}
		
		/**
		 * Returns node at specified grid coordinates
		 *
		 * @param  column  column index of grid
		 * @param  row  row index of grid
		 * @return GridCell object from specified coordinates
		 */
		public function getNodeFromCoordinates(column:uint, row:uint):GridNode3d
		{
			return this._nodes[(row*_columns)+column];
		}
		
		/**
		 * Adds object to layout in next available position.
		 *
		 * @param  object  Object to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding nodes's coordinates
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addNode(object:Object=null, moveToCoordinates:Boolean=true):INode
		{
			if(object&&!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"');
			if(object&&linkExists(object)||_size>=_maxNodes) return null;
		
			var w:Number=(_width-((_columns-1)*_hPadding))/_columns;
			var h:Number=(_height-((_rows-1)*_yPadding))/_rows;
			var d:Number=(_depth-((_layers-1)*_zPadding))/_layers;
			
			var c:int = _size%_columns;
			var r:int = Math.floor(_size/(_rows))%_rows;
			var l:int = Math.floor(_size/(_rows*_columns));
				
			var node:GridNode3d = new GridNode3d(object,c,r,l,((w*c)+(c*_hPadding)+_x),((h*r)+(r*_yPadding)+_y),((d*l)+(l*_zPadding)+_z));
			storeNode(node);
			
			if(object&&moveToCoordinates) object.x=node.x, object.y=node.y, object.z=node.z;
			
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
		}
		
		/**
		 * Adds object to layout in next available position <strong>This method is depreceated.</strong>
		 *
		 * @param  object  Object to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:Object, moveToCoordinates:Boolean=true):INode
		{
			if(!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "z", "rotationX", "rotationY", "rotationZ"');
			if(object&&linkExists(object)||_size>=_maxNodes) return null;
		
			var w:Number=(_width-((_columns-1)*_hPadding))/_columns;
			var h:Number=(_height-((_rows-1)*_yPadding))/_rows;
			var d:Number=(_depth-((_layers-1)*_zPadding))/_layers;
			
			var c:int = _size%_columns;
			var r:int = Math.floor(_size/(_rows))%_rows;
			var l:int = Math.floor(_size/(_rows*_columns));
				
			var node:GridNode3d = new GridNode3d(object,c,r,l,((w*c)+(c*_hPadding)+_x),((h*r)+(r*_yPadding)+_y),((d*l)+(l*_zPadding)+_z));
			storeNode(node);
			if(moveToCoordinates) object.x=node.x, object.y=node.y, object.z=node.z;
			
			dispatchEvent(new CoordyNodeEvent(CoordyNodeEvent.ADD, node));
			
			return node;
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return Grid3d clone of object
		*/
		override public function clone():ILayout3d
		{
			return new Grid3d(_width, _height, _depth, _columns, _rows, _layers, paddingX, paddingY, paddingZ, _x, _y, _z, _jitterX, _jitterY, _jitterZ);
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */		
		override public function update():void
		{
			var total:int = _columns*_rows*_layers;
			
			var _w:Number=(_width-((_columns-1)*_hPadding))/_columns;
			var _h:Number=(_height-((_rows-1)*_yPadding))/_rows;
			var _d:Number=(_depth-((_layers-1)*_zPadding))/_layers;
			
			var c:int;
			var r:int;
			var l:int;
			var node:GridNode3d;
			for(var i:int=0; i<_size; i++)
			{
				node = this._nodes[i];
				
				c = i%_columns;
				r = ((i/(_rows))>> 0)%_rows;
				l = (i/((_rows*_columns))) >> 0;
								
				node.x = ((_w*c)+(c*_hPadding)+_x)+(node.jitterX*this._jitterX);
				node.y = ((_h*r)+(r*_yPadding)+_y)+(node.jitterY*this._jitterY);
				node.z = ((_d*l)+(l*_zPadding)+_z)+(node.jitterZ*this._jitterZ);
				
			}
		}
	}
}