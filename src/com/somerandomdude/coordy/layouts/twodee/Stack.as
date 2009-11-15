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
	import com.somerandomdude.coordy.constants.StackOrder;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
	
	import flash.display.DisplayObjectContainer;

	public class Stack extends Layout2d implements ILayout2d
	{
		private var _offset:Number;
		private var _angle:Number;
		private var _order:String;
		
		/**
		 * Mutator/accessor for the order in which the nodes are stacked (ascending or descending)
		 * 
		 * @see com.somerandomdude.coordy.layouts.StackOrder
		 * 
		 * @return String identifying stack order
		 * 
		 */		
		public function get order():String { return this._order; }
		public function set order(value:String):void
		{
			this._order=value;
			_updateFunction();
		}
		
		/**
		 * Mutator/accessor for the x & y offset of each node in the stack
		 * 
		 * @see #offsetAngle
		 * 
		 * @return x & y offset of nodes in stack
		 * 
		 */		
		public function get offset():Number { return this._offset; }
		public function set offset(value:Number):void
		{
			this._offset=value;
			_updateFunction();
		}
		
		/**
		 * Mutator/accessor for the angle of which the nodes are offset (in degrees)
		 * 
		 * @see #offset
		 * 
		 * @return Angle of offset
		 * 
		 */		
		public function get offsetAngle():Number { return this._angle; }
		public function set offsetAngle(value:Number):void
		{
			this._angle=value;
			_updateFunction();
		}
		
		/**
		 * Distributes nodes in a stack.
		 * 
		 * @param angle			Offset angle (in degrees)
		 * @param offset		x & y offset for each node
		 * @param x				x position of the stack
		 * @param y				y position of the stack
		 * @param order			Determines whether stack is ordered by ascending or descending
		 * @param jitterX		Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY		Jitter multiplier for the layout's nodes on the y axis
		 * 
		 */		
		public function Stack(angle:Number=45, 
							offset:Number=5, 
							x:Number=0, 
							y:Number=0, 
							order:String=StackOrder.ASCENDING, 
							jitterX:Number=0, 
							jitterY:Number=0):void
		{
			this._angle=angle;
			this._offset=offset;
			this._x=x;
			this._y=y;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			this._order=order;
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */
		override public function toString():String { return LayoutType.STACK; }
			
		 /**
		 * Adds object to layout in next available position
		 *
		 * @param  object  Object to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:Object, moveToCoordinates:Boolean=true):INode
		{
			if(!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "rotation"');
			if(linkExists(object)) return null;
			if(!_nodes) _nodes = new Array();
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
		public function addToLayoutAt(object:Object, order:int, moveToCoordinates:Boolean=true):INode
		{
			if(!validateObject(object)) throw new Error('Object does not implement at least one of the following properties: "x", "y", "rotation"');
			if(linkExists(object)) return null;
			if(!_nodes) _nodes = new Array;
			var node:OrderedNode = new OrderedNode(object,order,0,0);
			
			if(order>=0&&order<this._size) this._nodes.splice(order, 0, node);
			else this._nodes.push(node);
			this.cleanOrder();
			this.update();
			
			if(moveToCoordinates) this.render();
			
			return node;
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return Stack clone of object
		*/
		override public function clone():ILayout2d
		{
			return new Stack(_angle, _offset, _x, _y, _order, _jitterX, _jitterY);
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */	
		override public function update():void
		{
			if(!this._nodes) return;
			
			this.cleanOrder();
			this.setDepths();
			var rad:Number = this._angle*Math.PI/180;
			if(this._order==StackOrder.ASCENDING) this._nodes.sortOn("order", Array.NUMERIC|Array.DESCENDING);
			
			var node:OrderedNode;
			for(var i:int=0; i<this._size; i++)
			{
				node=this._nodes[i];
				node.x=this._x+(Math.cos(rad)*_offset*i)+(node.jitterX*this._jitterX);
				node.y=this._y+(Math.sin(rad)*_offset*i)+(node.jitterY*this._jitterY);
			}
		}
		
		/**
		 * Sets the depths of the target's children to reflect the order of the stack
		 * 
		 */		
		public function setDepths():void
		{
			this._nodes.sortOn('order');
			if(this._order==StackOrder.ASCENDING) _nodes.reverse();
		}
		
		/**
		 * Cleans out duplicates and gaps
		 * @private 
		 * 
		 */		
		private function cleanOrder():void
		{
			this._nodes.sortOn("order", Array.NUMERIC);
			for(var i:int=0; i<this._size; i++) this._nodes[i].order=i;
		}
		
	}
}