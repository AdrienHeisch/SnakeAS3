package src.com.isartdigital.snake.game.objects 
{
	import src.com.isartdigital.snake.game.objects.GameObject;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Food extends GameObject 
	{
		static public var list: Vector.<Food> = new Vector.<Food>();
		
		public function Food(pX:Number, pY:Number) 
		{
			super(pX, pY);
			
			list.push(this)
		}
		
		override public function destroy():void 
		{
			list.splice(list.indexOf(this), 1);
			
			super.destroy();
		}
		
	}

}