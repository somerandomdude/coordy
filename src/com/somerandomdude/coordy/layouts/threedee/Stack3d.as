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
	import com.somerandomdude.coordy.constants.StackOrder;
	import com.somerandomdude.coordy.nodes.threedee.INode3d;
	import com.somerandomdude.coordy.nodes.threedee.OrderedNode3d;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Stack3d extends Layout3d implements ILayout3d
	{
		
		private var _offset:Number;
		private var _zOffset:Number;
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
		 * Mutator/accessor for the z offset of each node in the stack
		 * @return z offset of nodes in stack
		 * 
		 */		
		public function get zOffset():Number { return this._zOffset; }
		public function set zOffset(value:Number):void
		{
			this._zOffset=value;
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
		 * Distributes nodes in a 3d stack.
		 * 
		 * @param target		DisplayObjectContainer which parents all objects in the layout
		 * @param angle			Offset angle (in degrees)
		 * @param offset		x & y offset for each node
		 * @param zOffset		z offset for each node
		 * @param x				x position of the stack
		 * @param y				y position of the stack
		 * @param z				z position of the stack
		 * @param order			Determines whether stack is ordered by ascending or descending
		 * @param jitterX		Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY		Jitter multiplier for the layout's nodes on the y axis
		 * @param jitterZ		Jitter multiplier for the layout's nodes on the z axis
		 * 
		 */		
		public function Stack3d(target:DisplayObjectContainer, 
								angle:Number=45, 
								offset:Number=5, 
								zOffset:Number=5, 
								x:Number=0, 
								y:Number=0, 
								z:Number=0, 
								order:String=StackOrder.ASCENDING, 
								jitterX:Number=0, 
								jitterY:Number=0, 
								jitterZ:Number=0):void
		{
			super(target);
			this._angle=angle;
			this._offset=offset;
			this._zOffset=zOffset;
			this._x=x;
			this._y=y;
			this._z=z;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			this._jitterZ=jitterZ;
			this._order=order;
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */
		override public function toString():String { return LayoutType.STACK_3D; }
			
		/**
		 * Adds DisplayObject to layout in next available position
		 *
		 * @param  object  DisplayObject to add to layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
		 * 
		 * @return newly created node object containing a link to the object
		 */
		override public function addToLayout(object:DisplayObject, moveToCoordinates:Boolean=true, addToStage:Boolean=true):INode3d
		{
			var node:OrderedNode3d = new OrderedNode3d(object, this._size);
			this.addNode(node);
			
			this.update();
			
			
			if(moveToCoordinates) this.render();
			if(addToStage) this._target.addChild(object);
			
			this.cleanOrder();
			
			return node;
		}
		
		/**
		 * Adds DisplayObject to layout in the specified order within the layout
		 *
		 * @param  object  DisplayObject to add to layout
		 * @param  order   Order in which the DisplayObject is put in the layout
		 * @param  moveToCoordinates  automatically move DisplayObject to corresponding node's coordinates
		 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
		 * 
		 * @return newly created node object containing a link to the object
		 */	
		public function addToLayoutAt(object:DisplayObject, order:int, moveToCoordinates:Boolean=true, addToStage:Boolean=true):void
		{
			var node:OrderedNode3d = new OrderedNode3d(object,order,0,0,0);
			
			if(order>=0&&order<this._size) this._nodes.splice(order, 0, node);
			else this.addNode(node);
			
			this.update();
			
			
			if(moveToCoordinates) this.render();
			if(addToStage) this._target.addChild(object);
			
			this.cleanOrder();
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return Stack3d clone of object
		*/
		public function clone():ILayout3d
		{
			return new Stack3d(_target, _angle, _offset, _zOffset, _x, _y, _z, _order, _jitterX, _jitterY, _jitterZ);
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
			var rad:Number = this._angle*Math.PI/180;
			if(this._order==StackOrder.ASCENDING) this._nodes.sortOn("order", Array.NUMERIC|Array.DESCENDING);
			
			var node:OrderedNode3d;
			for(var i:int=0; i<this._size; i++)
			{
				node = this._nodes[i];
				node.x=this._x+(Math.cos(rad)*_offset*i)+(node.jitterX*this._jitterX);
				node.y=this._y+(Math.sin(rad)*_offset*i)+(node.jitterY*this._jitterY);
				node.z=this._z+(_zOffset*i)+(node.jitterZ*this._jitterZ);
			}
		}
		
		/**
		 *@private 
		 * 
		 */		
		private function cleanOrder():void
		{
			this._nodes.sortOn("order", Array.NUMERIC);
			
			for(var i:int=0; i<this._size; i++) { this._nodes[i].order=i; }
		}
		
	}
}