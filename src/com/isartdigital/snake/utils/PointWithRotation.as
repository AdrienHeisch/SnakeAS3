package src.com.isartdigital.snake.utils 
{
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class PointWithRotation 
	{
		
		public var x: Number = 0;
		public var y: Number = 0;
		public var rotation: Number = 0;
		
		public function PointWithRotation(pX: Number, pY: Number, pRotation: Number)
		{
			x = pX;
			y = pY;
			rotation = pRotation;
		}
		
		public function toString(): String {
			return String(x + ", " + y + ", " + rotation);
		}
		
	}

}