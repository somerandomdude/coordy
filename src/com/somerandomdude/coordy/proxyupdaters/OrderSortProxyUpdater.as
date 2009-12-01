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
package com.somerandomdude.coordy.proxyupdaters
{
	import com.somerandomdude.coordy.constants.StackOrder;
	import com.somerandomdude.coordy.layouts.IOrderedLayout;
	import com.somerandomdude.coordy.nodes.twodee.OrderedNode;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class OrderSortProxyUpdater implements IProxyUpdater
	{
		public static const NAME:String='orderSortUpdaterProxy';
		
		public function get name():String { return NAME; }
		
		private var _target:DisplayObjectContainer;
		private var _layout:IOrderedLayout;
		
		
		/**
		 * Modifies a layout's update method to set the child index of a DisplayObjectContainer's children according
		 * to the order of nodes in the specified layout 
		 * 
		 * @param target 		DisplayObjectContainer containing the items to stack
		 * @param layout 		The layout containing references to the target's children
		 * 
		 */
		public function OrderSortProxyUpdater(target:DisplayObjectContainer, layout:IOrderedLayout)
		{
			_target=target;
			_layout=layout;
		}
		
		public function update():void
		{
			if(!_layout.size) return;
			_layout.nodes.sortOn("order", Array.NUMERIC);
			if(_layout.order==StackOrder.DESCENDING) _layout.nodes.reverse();
			var n:OrderedNode;
			for(var i:int=0; i<_layout.size; i++)
			{
				n=_layout.nodes[i];
				if(!n.link||!n.link is DisplayObject) continue;
				_target.setChildIndex(_layout.nodes[i].link, i);
			}
		}

	}
}