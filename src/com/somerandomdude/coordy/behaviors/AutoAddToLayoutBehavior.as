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
 
 package com.somerandomdude.coordy.behaviors
{
	import com.somerandomdude.coordy.layouts.ILayout;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class AutoAddToLayoutBehavior
	{ 
		private var _target:DisplayObjectContainer;
		private var _layout:ILayout;
		
		/**
		 * Allows for DisplayObjects to be automatically added/removed from a layout when they are added/removed 
		 * from a DisplayObjectContainer's display list.
		 * 
		 * @param target 		DisplayObjectContainer to monitor for children being added/removed
		 * @param layout 		The layout to add/remove nodes from
		 * 
		 */		
		public function AutoAddToLayoutBehavior(target:DisplayObjectContainer, layout:ILayout)
		{
			_target=target;
			_layout=layout;
			
			_target.addEventListener(Event.ADDED, addedHandler);
			_target.addEventListener(Event.REMOVED, removedHandler);
		}
		
		/**
		 * @private 
		 */
		private function addedHandler(event:Event):void
		{
			if(event.target.parent!=_target) return;
			for(var i:int=0; i<_layout.size; i++) if(event.target==_layout.nodes[i].link) return;
			_layout.addToLayout(event.target as DisplayObject, false);
			_layout.executeUpdateMethod();
		}
		
		/**
		 * @private 
		 */	
		private function removedHandler(event:Event):void
		{
			if(event.target.parent!=_target) return;
			_layout.removeNodeByLink(event.target as DisplayObject);
			_layout.executeUpdateMethod();
		}

	}
}