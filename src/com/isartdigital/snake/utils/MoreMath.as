package src.com.isartdigital.snake.utils
{
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class MoreMath
	{
		
		static public function randomRange(pMax:Number, pMin:Number = 0):Number
		{
			return Math.random() * (pMax - pMin) + pMin;
		}
		
	}

}