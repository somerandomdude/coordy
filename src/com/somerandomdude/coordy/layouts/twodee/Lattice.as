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
package com.somerandomdude.coordy.layouts.twodee {
	import com.somerandomdude.coordy.constants.LatticeAlternationPattern;
	import com.somerandomdude.coordy.constants.LatticeOrder;
	import com.somerandomdude.coordy.constants.LatticeType;
	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.twodee.GridNode;
	import com.somerandomdude.coordy.nodes.twodee.INode2d;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Lattice extends Layout2d implements ILayout2d
	{
		
		protected var _order:String;
		protected var _rows:uint;
		protected var _columns:uint;
		protected var _paddingX:Number=0;
		protected var _paddingY:Number=0;
		protected var _columnWidth:Number;
		protected var _rowHeight:Number;
		private var _latticeType:String=LatticeType.SQUARE;
		private var _alternate:String=LatticeAlternationPattern.ALTERNATE_HORIZONTALLY;
		private var _allowOverflow:Boolean;
		private var _maxCells:uint;
		
		/**
		 * Mutator/accessor for lattice type property
		 * 
		 * @see com.somerandomdude.coordy.constants.LatticeType
		 * 
		 * @return Lattice type in string format 
		 * 
		 */		
		public function get latticeType():String { return _latticeType; }
		public function set latticeType(value:String):void
		{
			_latticeType=value;
			_updateFunction();
		}
		
		/**
		 * Mutator/accessor for alternate property
		 *
		 * @return	the alternating order in which the diagonal lattice is created (horizontal or vertical)   
		 */
		public function get alternate():String { return this._alternate; }
		public function set alternate(value:String):void
		{
			this._alternate=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for order property
		 *
		 * @return 	the order in which elements are put in the lattice (horizonal or vertical)   
		 */
		public function get order():String { return _order; }
		public function set order(value:String):void
		{
			this._order=value;
			this.adjustLattice();
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for allowOverflow property
		 *
		 * @param	value	Boolean value determining whether overflow is allowed    
		 */
		public function get allowOverflow():Boolean { return this._allowOverflow; }
		public function set allowOverflow(value:Boolean):void
		{
			this._allowOverflow=value;
		}
		
		/**
		 * Mutator/accessor for width property
		 *
		 * @param	value	Global width dimension of layout organizer   
		 */
		override public function get width():Number { return _columnWidth*_columns; }
		override public function set width(value:Number):void
		{
			this._width=value;
			this._columnWidth = value/_columns;
			this._updateFunction();
		}

		/**
		 * Mutator/accessor for height property
		 *
		 * @param	value	Global height dimension of layout organizer   
		 */
		override public function get height():Number { return _rowHeight*_rows; }
		override public function set height(value:Number):void
		{
			
			this._height=value;
			this._rowHeight = value/_rows;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for paddingY property
		 *
		 * @return	X padding of grid nodes for layout   
		 */
		public function get paddingX():Number { return _paddingX; }
		public function set paddingX(value:Number):void
		{
			this._paddingX=value;
			this._updateFunction();
		}

		/**
		 * Mutator/accessor for paddingY property
		 *
		 * @return	Y padding of grid nodes for layout   
		 */
		public function get paddingY():Number { return _paddingY; }
		public function set paddingY(value:Number):void
		{
			this._paddingY=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for columnWidth property
		 *
		 * @return	column width of each individual node  
		 */
		public function get columnWidth():Number { return this._columnWidth; }
		public function set columnWidth(value:Number):void
		{
			this._columnWidth=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for rowHeight property
		 *
		 * @return	row height of each individual node   
		 */
		public function get rowHeight():Number { return this._rowHeight; }
		public function set rowHeight(value:Number):void
		{
			this._rowHeight=value;
			this._updateFunction();
		}
		
		/**
		 * Mutator/accessor for rows property
		 *
		 * @return	Row length   
		 */
		public function get rows():uint { return _rows; }
		public function set rows(value:uint):void
		{
			this._rows=value;
			this._order=LatticeOrder.ORDER_VERTICALLY;
			this.adjustLattice();
			this._updateFunction();
			this._maxCells=_rows*_columns;
		}
		
		/**
		 * Mutator/accessor for columns property
		 *
		 * @return	Column length   
		 */
		public function get columns():uint { return _columns; }
		public function set columns(value:uint):void
		{
			this._columns=value;
			this._order=LatticeOrder.ORDER_HORIZONTALLY;
			this.adjustLattice();
			this._updateFunction();
			this._maxCells=_rows*_columns;
		}
		
		/**
		 * Distributes nodes in a lattice.
		 * 
		 * @param target			DisplayObjectContainer which parents all objects in the layout
		 * @param width				Width of the lattice
		 * @param height			Height of the lattice
		 * @param columns			Number of columns in the lattice
		 * @param rows				Number of rows in the lattice
		 * @param allowOverflow		Determines whether nodes beyond the total number of lattice cells are added to the lattice
		 * @param order				The order in which the lattice nodes are laid out
		 * @param hPadding			Horizontal padding between columns
		 * @param vPadding			Vertical padding between rows
		 * @param x					x position of the grid
		 * @param y					x position of the grid
		 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
		 * 
		 */		
		public function Lattice(target:DisplayObjectContainer, 
								width:Number, 
								height:Number, 
								columns:uint=1, 
								rows:uint=1, 
								allowOverflow:Boolean=true, 
								order:String=LatticeOrder.ORDER_HORIZONTALLY, 
								hPadding:Number=0, 
								vPadding:Number=0, 
								x:Number=0, 
								y:Number=0, 
								jitterX:Number=0, 
								jitterY:Number=0):void
		{
			
			super(target);
			this._paddingX=hPadding;
			this._paddingY=vPadding;
			this._x=x;
			this._y=y;
			this._columns=columns;
			this._rows=rows;
			this._columnWidth=width/columns;
			this._rowHeight=height/rows;
			this._width=width;
			this._height=height;
			this._maxCells=_rows*_columns;
			this._allowOverflow=allowOverflow;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */
		override public function toString():String { return LayoutType.LATTICE; }
		
		/**
		 * Adds DisplayObject to layout in next available position
		 *
		 * @param  object  DisplayObject to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:DisplayObject, moveToCoordinates:Boolean=true, addToStage:Boolean=true):INode2d
		{
			if(!_allowOverflow&&size>=_maxCells) return null;
			
			var c:uint = (_order==LatticeOrder.ORDER_VERTICALLY) ? (size)%_columns:(size)%Math.floor(((size)/_rows));
			var r:uint = (_order==LatticeOrder.ORDER_VERTICALLY) ? Math.floor((size)/_columns):(size)%_rows;
			var node:GridNode = new GridNode(object, c,r);
			//trace(c,r);
			node.link=object;

			this.addNode(node);
			this.adjustLattice();
			this.update();
			
			if(moveToCoordinates) this.render();
			if(addToStage) this.target.addChild(object);
			
			if(_order==LatticeOrder.ORDER_VERTICALLY) this._columns = Math.ceil(this._size/_rows);
			else if(_order==LatticeOrder.ORDER_HORIZONTALLY) this._rows = Math.ceil(this._size/_columns);
			
			return node;
			
		}
		
		/**
		 * Removes specified cell and its link from layout organizer and adjusts layout appropriately
		 *
		 * @param  cell  cell object to remove
		 */
		override public function removeNode(node:INode):void
		{
			super.removeNode(node);
			this.adjustLattice();
			this._updateFunction();
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */			
		override public function update():void
		{
			var node:GridNode;
			for(var i:int=0; i<this._size; i++)
			{
				node = this._nodes[i];
				if(!node) break;
							
				node.x = (node.column*(_columnWidth+_paddingX))+_x+(node.jitterX*this._jitterX);
				node.y = (node.row*(_rowHeight+_paddingY))+_y+(node.jitterY*this._jitterY);
				
				if(_latticeType == LatticeType.DIAGONAL&&_alternate == LatticeAlternationPattern.ALTERNATE_VERTICALLY&&node.row%2) node.x+=_columnWidth/2;
				else if(_latticeType == LatticeType.DIAGONAL&&_alternate == LatticeAlternationPattern.ALTERNATE_HORIZONTALLY&&node.column%2) node.y+=_rowHeight/2;	
			}
			
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return SquareLatticeOrganizer clone of object
		*/
		public function clone():ILayout2d
		{
			return new Lattice(_target, _width, _height, _columns, _rows, _allowOverflow, _order, _paddingX, _paddingY, _x, _y, _jitterX, _jitterY);
		}
		
		/**
		 * 
		 * @protected
		 * 
		 */		
		protected function adjustLattice():void
		{
			var c:uint;
			var r:uint;
			var node:GridNode;
			var i:int; 
			
			if(_order==LatticeOrder.ORDER_HORIZONTALLY)
			{
				for(i=0; i<this._size; i++)
				{
					node = this._nodes[i];
					if(!node) break;
					
					c = i%_columns;
					r = Math.floor(i/_columns);
									
					node.column=c;
					node.row=r;
				}
			} else
			{
				for(i=0; i<this._size; i++)
				{
					node = this._nodes[i];
					if(!node) break;
					
					c = Math.floor(i/_rows);
					r = i%_rows;
									
					node.column=c;
					node.row=r;
				}
			}
			
			if(_order==LatticeOrder.ORDER_VERTICALLY) this._columns = Math.ceil(size/_rows);
			else if(_order==LatticeOrder.ORDER_HORIZONTALLY) this._rows = Math.ceil(size/_columns);
		}				
	}
}