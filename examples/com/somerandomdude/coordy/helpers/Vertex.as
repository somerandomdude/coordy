/**
* ...
* @author nicoptere
* @version 0.1
*/

package com.somerandomdude.coordy.helpers
{

	public class Vertex 
	{
		
		public var x:Number;//position
		public var y:Number;
		public var z:Number;
		
		public var screenX:int;//toSreen position
		public var screenY:int;
				public var depth:Number;
		public var ratio:Number;
		public var color:uint;
		
		public function Vertex( X:Number = 0, Y:Number = 0, Z:Number = 0, C:uint = 0xFF000000 ) 
		{
			
			x = X;
			y = Y;
			z = Z;
			color = C;
			
			screenX = screenY = ratio = depth = 0;
			
		}
		
		public function clone():Vertex
		{
			return new Vertex( x, y, z, color );
		}
		
	}
	
}
