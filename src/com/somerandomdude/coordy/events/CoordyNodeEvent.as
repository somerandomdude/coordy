package com.somerandomdude.coordy.events
{
	import com.somerandomdude.coordy.nodes.INode;
	
	import flash.events.Event;

	public class CoordyNodeEvent extends Event
	{
		public static const ADD:String='coordyNodeAdd';
		public static const REMOVE:String='coordyNodeRemove';
		
		private var _node:INode;
		
		public function get node():INode { return _node; }
		
		public function CoordyNodeEvent(type:String, node:INode, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_node=node;
			super(type, bubbles, cancelable);
			
		}
		
		override public function clone():Event { return new CoordyNodeEvent(type, _node, bubbles, cancelable); }
	}
}