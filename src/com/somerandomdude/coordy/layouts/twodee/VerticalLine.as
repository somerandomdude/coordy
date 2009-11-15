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
	import com.somerandomdude.coordy.constants.LayoutType;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.twodee.INode2d;
	import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
	
	import flash.display.DisplayObjectContainer;

	public class VerticalLine extends Layout2d implements ILayout2d
	{
		
		private var _vPadding:Number;
		
		/**
		 * Mutator/accessor for horizontal padding between nodes in the line
		 * 
		 * @return Padding value
		 * 
		 */
		public function get vPadding():Number { return this._vPadding; };
		public function set vPadding(value:Number):void
		{
			this._vPadding=value;
			this._updateFunction();
		}
		
		/**
		 * Distributes nodes in a vertical line
		 * 
		 * @param vPadding			Vertical padding between each node in the line
		 * @param x					x position of the vertical line
		 * @param y					y position of the vertical line
		 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
		 * 
		 */	
		public function VerticalLine(vPadding:Number=0, 
									x:Number=0, 
									y:Number=0, 
									jitterX:Number=0, 
									jitterY:Number=0):void
		{
			this._vPadding=vPadding;
			this._x=x;
			this._y=y;
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
		override public function toString():String { return LayoutType.VERTICAL_LINE; }
			
		 /**
		 * Adds object to layout in next available position
		 *
		 * @param  object  DisplayObject to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:Object,  moveToCoordinates:Boolean=true):INode
		{
			if(!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "rotation"');
			if(linkExists(object)) return null;
			var node:OrderedNode = new OrderedNode(object, this._size);
			this.cleanOrder();
			this.addNode(node);
			
			this.update();
			
			if(moveToCoordinates) this.render();
			
			return node;
		}
		
		/**
		 * Adds object to layout in the specified order within the layout
		 *
		 * @param  object  Object to add to layout
		 * @param  order   Order in which the DisplayObject is put in the layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * 
		 * @return newly created node object containing a link to the object
		 */	
		public function addToLayoutAt(object:Object, order:int, moveToCoordinates:Boolean=true):INode2d
		{
			if(!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "rotation"');
			if(linkExists(object)) return null;
			if(!_nodes) _nodes = new Array;
			var node:OrderedNode = new OrderedNode(object,order,0,0);
			
			if(order>=0&&order<this._size) this._nodes.splice(order, 0, node);
			else this._nodes.push(node);
			this.cleanOrder();
			this.update();
			
			if(moveToCoordinates)
			{
				this.render();
			}
			
			return node;
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return VerticalLine clone of object
		*/
		override public function clone():ILayout2d
		{
			return new VerticalLine(_vPadding, _x, _y, _jitterX, this._jitterY);
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */	
		override public function update():void
		{
			if(_size==0) return;
			var node:OrderedNode;
			
			this._nodes.sortOn("order", Array.NUMERIC);
			
			var yPos:Number=0;
			
			for(var i:int=0; i<this._size; i++)
			{	
				node = this._nodes[i];
				node.y=yPos+_y+(node.jitterY*this._jitterY);
				yPos+=node.link.height+_vPadding;
				node.x = this._x+(node.jitterX*this._jitterX);
			}
		}
		
		/**
		 * Cleans out duplicates and gaps
		 * @private 
		 * 
		 */		
		private function cleanOrder():void
		{
			if(!this._nodes) return;
			this._nodes.sortOn("order", Array.NUMERIC);
			for(var i:int=0; i<this._size; i++)
			{
				this._nodes[i].order=i;
			}
		}
		
	}
}