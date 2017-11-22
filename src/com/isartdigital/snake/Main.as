package src.com.isartdigital.snake 
{
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	import src.com.isartdigital.snake.game.GameManager;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Main extends MovieClip 
	{
		static protected var instance: Main;
		
		static public function getInstance(): Main {
			return instance;
		}
		
		public var sharedData:SharedObject;
		
		public function Main() 
		{
			super();
			
			sharedData = SharedObject.getLocal("snake_data");
			
			instance = this;
			
			GameManager.init();
			
		}
		
	}

}