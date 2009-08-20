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
package com.somerandomdude.coordy.layouts
{
	import com.serialization.json.JSON;
	import com.somerandomdude.coordy.nodes.INode;
	
	import flash.display.DisplayObject;
	
	public class Layout
	{
		
		protected var _nodes:Array;
		protected var _size:int;
		
		/**
		 * Returns the number of nodes currently stored and managed
		 *
		 * @return  Total number of nodes   
		 */
		public function get size():int { return this._size; }
		
		/**
		 * Returns an array of node objects
		 *
		 * @return	Array containing all node objects     
		 */
		public function get nodes():Array { return this._nodes; }
		
		/**
		 * The most base-level class for all layouts. Cannot be instantiated as is.
		 * 
		 */		
		public function Layout()
		{
			this._size=0;
		}
		
		public function toString():String { return ""; }
		
		/**
		 * Serializes the layout data of each node as a JSON string. Includes the 'type', 'size' and 'nodes' properties.
		 *
		 * @return JSON representation of the layout's composition
		*/
		public function toJSON():String
		{
			var nodes:Array = new Array();
			var layout:Object = new Object();
			
			for(var i:int=0; i<_size; i++)
			{
				nodes.push(_nodes[i].toObject());
			}
			
			layout.type=toString();
			layout.size=_size;
			layout.nodes=nodes;
			
			return JSON.serialize(layout);
		}
		
		/**
		 * Generates XML for the layout's properties.
		 *
		 * @return XML representation of the layout's composition
		*/
		public function toXML():XML
		{			
			var xml:XML = <layout></layout>;
			xml.@type = toString();
			xml.@size = _size;
			for(var i:int=0; i<_size; i++)
			{
				var node:XML = <node />
				var obj:Object=_nodes[i].toObject();
				for(var j:String in obj)
				{
					node[String('@'+j)] = obj[j];
				}
    
    			xml.appendChild(node);
			}
			
			return xml;
		}
		
		/**
		 * Returns node object by specified display object
		 *
		 * @param  link  an absolute URL giving the base location of the image
		 * @return      the node object which the display object is linked to
		 * @see         INode
		 */
		public function getNodeByLink(link:DisplayObject):INode
		{
			for(var i:int;i<this._nodes.length;i++)
			{
				if(this._nodes[i].link==link) return this._nodes[i];
			}
			return null;
		}
		
		/**
		 * Returns specified node object's index in the collection 
		 *
		 * @param  node  Node object from layout organizer
		 * @return      Index of node object in the collection of nodes
		 * @see         INode
		 */
		public function getNodeIndex(node:INode):uint
		{
			for(var i:int=0; i<this._nodes.length; i++)
			{
				if(this._nodes[i]==node) return i;
			}
			return null;
		}
		
		/**
		 * Returns node object at specified index of collection
		 *
		 * @param  index  Index of item in the collection of nodes
		 * @return      Node object at the specified location in the collection
		 * @see         Node
		 */
		public function getNodeAt(index:uint):INode
		{
			return this._nodes[index];
		}
		
		/**
		 * Swaps links of two node objects
		 *
		 * @param  nodeTo  
		 * @param  nodeFrom
		 */
		public function swapNodeLinks(nodeTo:INode, nodeFrom:INode):void
		{
			var tmpLink:DisplayObject = nodeTo.link;
			nodeTo.link = nodeFrom.link;
			nodeFrom.link = tmpLink;
		}
		
		/**
		 * Removes all links between nodes and display objects 
		 *
		 */
		public function removeLinks():void
		{
			for(var i:int=0; i<_nodes.length; i++) _nodes[i].link=null;
		}
		
		/**
		 * Removed the link between the node and display object at the specified index
		 *
		 * @param  index  index in collection of item to be removed
		 */
		public function removeLinkAt(index:uint):void
		{
			_nodes[index].link=null;
		}
		
		/**
		 * Removes specified node object from layout organizer
		 *
		 * @param  node	specified Node object to remove
		 */
		public function removeNode(node:INode):void
		{
			_nodes.splice(getNodeIndex(node), 1);
			this._size--;
		}
		
		public function removeAllNodes():void
		{
			this.clearNodes();
			this._size=0;
		}
		
		/**
		 * Adds a link between the specified display object to the node object at the specified index
		 *
		 * @param  object	item to add to collection
		 * @param  index		position where to add the item
		 */
		public function addLinkAt(object:DisplayObject, index:uint):void
		{
			_nodes[index].link=object;
		}
		
		/**
		 * @protected 
		 */		
		protected function addNode(node:INode):int
		{
			if(!this._nodes) this._nodes=new Array();
			this._nodes.push(node);
			this._size++;
			return size;
		}
		
		/**
		 * @protected 
		 */			
		protected function getNextAvailableNode():INode
		{
			for(var i:int=0; i<this._nodes.length; i++)
			{
				if(!this._nodes[i].link) 
				{
					return this._nodes[i];
				}
			}
			return null;
		}
		
		/**
		 * @protected 
		 */	
		protected function clearNodes():void
		{
			if(this._nodes)
			{
				for(var i:String in this._nodes)
				{
					delete this._nodes[i];
					this._nodes[i]=null;
				}
			}
			this._nodes=new Array();
		}

	}
}