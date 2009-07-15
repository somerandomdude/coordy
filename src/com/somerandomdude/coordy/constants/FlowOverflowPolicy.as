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

package com.somerandomdude.coordy.constants
{
	public class FlowOverflowPolicy
	{
		
		/**
		 * Allow all nodes within flow that are out of the layout's bounds to continue flowing.
		 * For example, a flow layout in which the <em>flowDirection</em> was <em>HORIZONTAL</em> would continue
		 * places nodes horizontally even if the bounds of the layout have been reached
		 */		
		public static const ALLOW_OVERFLOW:String="allow";
		
		/**
		 * Will simply not place nodes that do not fit within the layout's bounds.
		 */		
		public static const IGNORE_OVERFLOW:String="ignore";
		
		/**
		 * Will remove node's DisplayObject link from the target's display stack if it does not 
		 * fit within that layout's bounds.
		 */		
		public static const HIDE_OVERFLOW:String="hide";

	}
}