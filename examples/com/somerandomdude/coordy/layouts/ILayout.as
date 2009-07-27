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

package com.somerandomdude.coordy.layouts
{
	import com.somerandomdude.coordy.nodes.INode;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public interface ILayout
	{
		function get nodes():Array;
		function get size():int;
		function get target():DisplayObjectContainer;
		
		function getNodeByLink(link:DisplayObject):INode;
		function getNodeIndex(node:INode):uint;
		function getNodeAt(index:uint):INode;
		function addChildren(moveToCoordinates:Boolean=true):void;
		function addLinkAt(object:DisplayObject, index:uint):void;
		function removeLinks():void;
		function removeLinkAt(index:uint):void;
		function removeNode(node:INode):void;
		function swapNodeLinks(nodeTo:INode, nodeFrom:INode):void;
		
		function updateAndRender():void;
		function update():void;
		function render():void;
		
		function toString():String;
		
	}
}