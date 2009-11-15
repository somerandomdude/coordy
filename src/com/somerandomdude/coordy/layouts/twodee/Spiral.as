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
	import com.somerandomdude.coordy.constants.PathAlignType;
	import com.somerandomdude.coordy.nodes.twodee.INode2d;
	import com.somerandomdude.coordy.nodes.INode;
	import com.somerandomdude.coordy.nodes.twodee.Node2d;
	
	import flash.display.*;

	public class Spiral extends Layout2d implements ILayout2d
	{		
		private static const PI:Number=Math.PI;
		private var _alignType:String;
		private var _alignAngleOffset:Number;
		private var _circumference:Number;
		private var _angleDelta:Number;
		private var _spiralConstant:Number;
		
		public function get angleDelta():Number { return this._angleDelta; }
		public function set angleDelta(value:Number):void
		{
			this._angleDelta=value;
			this._updateFunction();
		}
		
		public function get spiralConstant():Number { return this._spiralConstant; }
		public function set spiralConstant(value:Number):void
		{
			this._spiralConstant=value;
			this._updateFunction();
		}
		
		public function get circumference():Number { return this._circumference; }
		public function set circumference(value:Number):void
		{
			this._circumference=value;
			this._updateFunction();
		}
		
		override public function set height(value:Number):void 
		{
			_height=value;
			_circumference=value;
			_updateFunction();
		}
		
		override public function set width(value:Number):void 
		{
			_width=value;
			_circumference=value;
			_updateFunction();
		}
		
		/**
		 * The additional angle offset of each node from it's original path-aligned angle (in degrees)
		 * @return Angle in degrees
		 * 
		 */		
		public function get alignAngleOffset():Number { return this._alignAngleOffset; }
		public function set alignAngleOffset(value:Number):void
		{
			this._alignAngleOffset=value;
			this._updateFunction();
		}
		
		/**
		 * The type of path alignment each node executes (parallel or perpendicular)
		 * 
		 * @see com.somerandomdude.coordy.layouts.PathAlignType
		 * 
		 * @return String value of the path alignment type
		 * 
		 */		
		public function get alignType():String { return this._alignType; }
		public function set alignType(value:String):void
		{
			this._alignType=value;
			this._updateFunction();
		}
		
		/**
		 * Distributes nodes in a spiral.
		 * 
		 * @param target			DisplayObjectContainer which parents all objects in the layout
		 * @param circumference		Circumference of the spiral
		 * @param x					x position of the ellipse
		 * @param y					y position of the ellipse
		 * @param rotation			Rotation of the ellipse
		 * @param jitterX			Jitter multiplier for the layout's nodes on the x axis
		 * @param jitterY			Jitter multiplier for the layout's nodes on the y axis
		 * @param alignType			Method in which nodes align to the path of the ellipse
		 * @param alignOffset		The additional offset angle of each node's path alignment
		 * 
		 */		
		public function Spiral(circumference:Number,
								x:Number=0, 
								y:Number=0, 
								angleDelta:Number=30,
								spiralConstant:Number=.15,
								rotation:Number=0, 
								jitterX:Number=0, 
								jitterY:Number=0, 
								alignType:String=PathAlignType.NONE, 
								alignOffset:Number=0):void
		{
			this._circumference=circumference;
			this._x=x;
			this._y=y;
			this._jitterX=jitterX;
			this._jitterY=jitterY;
			this._rotation=rotation;
			this._angleDelta=angleDelta;
			this._spiralConstant=spiralConstant;
			this._alignType=alignType;
			this._alignAngleOffset=alignOffset;
		}
		
		/**
		 * Returns the type of layout in a string format
		 * 
		 * @see com.somerandomdude.coordy.layouts.LayoutType
		 * @return Layout's type
		 * 
		 */
		override public function toString():String { return LayoutType.ELLIPSE; }
		
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
			var node:Node2d = new Node2d(object,0,0,((Math.random()>.5)?-1:1)*Math.random(),((Math.random()>.5)?-1:1)*Math.random());
			this.addNode(node);
			
			this.update();
			
			if(moveToCoordinates) this.render();
			
			return node;
		}
		
		/**
		 * Renders all layout property values of a specified node
		 * @param node
		 * 
		 */	
		override public function renderNode(node:INode2d):void
		{
			super.renderNode(node);
			node.link.rotation=node.rotation;
		}
		
		/**
		 * Applies all layout property values to all cells/display objects in the collection
		 *
		 */
		override public function render():void
		{
			var c:Node2d;
			for(var i:int=0; i<this._size; i++)
			{
				c=this._nodes[i];
				c.link.x=c.x;
				c.link.y=c.y;
				c.link.rotation=(_alignType==PathAlignType.NONE)?0:c.rotation;
			}
		}
		
		/**
		* Clones the current object's properties (does not include links to DisplayObjects)
		* 
		* @return Ellipse clone of object
		*/
		override public function clone():ILayout2d
		{
			return new Ellipse(_width, _height, _x, _y, _rotation, _jitterX, _jitterY, _alignType, _alignAngleOffset);
		}
		
		/**
		 * Updates the nodes' virtual coordinates. <strong>Note</strong> - this method does not update
		 * the actual objects linked to the layout.
		 * 
		 */	
		override public function update():void
		{
			var w:Number = this._width/2;
			var h:Number = this._height/2;
			var rOffset:Number = _rotation*(PI/180);
			var rad:Number;
			var c:Node2d;
			
			var phi:Number;
			
			for(var i:int=0; i<this._size; i++)
			{	
				c = this._nodes[i];
				
				phi = _angleDelta*i*PI/180;
				
				c.x = _x +  _circumference * Math.exp(_spiralConstant*phi) * Math.cos(phi)
				c.y = _y + _circumference * Math.exp(_spiralConstant*phi) * Math.sin(phi)
				
				c.rotation = Math.atan2((_y)-c.y, (_x)-c.x)*(180/PI);
				if(this._alignType==PathAlignType.ALIGN_PERPENDICULAR) c.rotation+=90; 
				c.rotation+=this._alignAngleOffset;
				
			}
		}
		
		/**
		 *
		 * @private
		 */
		public function rotateCellToTop(cell:INode2d):Number
		{
			var xR:Number = cell.link.x-(_x+_width/2);
			var yR:Number = cell.link.y-(_y+_height/2);
			
			var rads:Number = Math.atan2(yR*(_width/_height), xR);
			//rotation of individual object
			var a:Number = rads*(180/PI)+90;
			
			this.rotation=rotation-a;
			return a;
		}
	}

}