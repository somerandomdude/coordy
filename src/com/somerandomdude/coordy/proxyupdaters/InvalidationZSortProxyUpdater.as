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
	import com.somerandomdude.coordy.helpers.SimpleZSorter;
	import com.somerandomdude.coordy.layouts.threedee.ILayout3d;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class InvalidationZSortProxyUpdater implements IProxyUpdater
	{
		public static const NAME:String='invalidationZSortUpdaterProxy';
		private var _target:DisplayObjectContainer;
		private var _layout:ILayout3d;
		
		/**
		 * Performs a potentially more efficent method of rendering items on a stage by using 
		 * <em>stage.invalidate()</em> when the specified layout is modified. In addition, elements 
		 * are z-sorted after render. 
		 * 
		 * @param target 		DisplayObjectContainer with reference to the stage
		 * @param layout 		The layout to apply changes to
		 * 
		 */
		public function InvalidationZSortProxyUpdater(target:DisplayObjectContainer, layout:ILayout3d)
		{
			_target=target;
			_target.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			_layout=layout;
		}
		
		public function get name():String { return NAME; }
		
		public function update():void
		{
			if(!_target.stage) 
			{		
				_layout.update();
				return;
			}
			_target.stage.addEventListener(Event.RENDER, renderHandler);
			_target.stage.invalidate();
		}
		
		/**
		 * @private 
		 */
		private function renderHandler(event:Event):void
		{
			_target.stage.removeEventListener(Event.RENDER, renderHandler);
			_layout.updateAndRender();			
			SimpleZSorter.sortLayout(_target, _layout);
		}
		
		/**
		 * @private 
		 */
		private function addedToStageHandler(event:Event):void
		{
			update();
		}

	}
}