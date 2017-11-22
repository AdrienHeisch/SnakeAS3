package src.com.isartdigital.snake.game 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class GameContainer extends MovieClip 
	{
		static protected var instance: GameContainer;
		
		static public function getInstance(): GameContainer {
			if (instance == null) instance = new GameContainer();
			return instance;
		}
		
		public function GameContainer() 
		{
			super();
			
		}
		
	}

}