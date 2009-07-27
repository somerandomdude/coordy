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
	import com.somerandomdude.coordy.nodes.threedee.INode3d;
	import com.somerandomdude.coordy.nodes.threedee.Node3d;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Snapshot3d extends Layout3d implements ILayout3d
	{
		/**
		 * 
		 * Records the x, y & z coordinates of all DisplayObjects added to the layout
		 * 
		 * @param target		DisplayObjectContainer which parents all objects in the layout
		 * 
		 */		
		public function Snapshot3d(target:DisplayObjectContainer):void
		{
			super(target);
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */	
		override public function toString():String { return LayoutType.SNAPSHOT_3D; }
		
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
			var node:Node3d = new Node3d(object,object.x,object.y,object.z);
			this.addNode(node);
			
			if(moveToCoordinates) this.render();
			if(addToStage) this._target.addChild(object);
			
			return node;
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */
		override public function update():void
		{
			for(var i:int=0; i<this._size; i++)
			{
				this._nodes[i].x=this._nodes[i].link.x;
				this._nodes[i].y=this._nodes[i].link.y;
				this._nodes[i].z=this._nodes[i].link.z;
			}
		}	
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return Snapshot3d clone of object
		*/
		override public function clone():ILayout3d
		{
			return new Snapshot3d(this._target);
		}
	}
}