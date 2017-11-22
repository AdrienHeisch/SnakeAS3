package src.com.isartdigital.snake.game.objects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class GameObject extends MovieClip 
	{
		
		public function GameObject(pX: Number, pY: Number) 
		{
			super();
			
			x = pX;
			y = pY;
		}
		
		public function destroy() : void {
			//trace(parent);
			parent.removeChild(this);
		}
		
	}

}