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
package com.somerandomdude.coordy.nodes
{
	
	import flash.display.DisplayObject;
	
	public class Node implements INode
	{
		protected var _link:DisplayObject;
		
		/**
		 * Core class for all 2d and 3d nodes
		 * 
		 * @see com.somerandomdude.coordy.twodee.Node2d
		 * @see com.somerandomdude.coordy.threedee.Node3d
		 * 
		 * @param link DisplayObject to which the node reflects coordinate data
		 * 
		 */		
		public function Node(link:DisplayObject=null)
		{
			this._link=link;
		}
		
		/**
		 * Mutator/accessor for the node's DisplayObject link
		 * @return DisplayObject to which the node reflects coordinate data
		 * 
		 */			
		public function get link():DisplayObject { return _link; }
		public function set link(value:DisplayObject):void { this._link=value; }
			
		/**
		 * Packages the node as a generic object - mainly used for exporting layout data.
		 *
		 * @return Generic object containing all the node's layout properties
		*/	
		public function toObject():Object
		{
			throw(new Error('Method must be called in Node descendant'));
			return null;
		}
	}
}