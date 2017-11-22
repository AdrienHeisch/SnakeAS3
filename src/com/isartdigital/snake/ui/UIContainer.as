package src.com.isartdigital.snake.ui 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import src.com.isartdigital.snake.Main;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class UIContainer extends MovieClip
	{

		/**
		 * instance unique de la classe UIContainer
		 */
		protected static var instance: UIContainer;
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): UIContainer {
			if (instance == null) instance = new UIContainer();
			return instance;
		}
		
		public function UIContainer() 
		{
			super();
			
			if (instance != null) throw new Error(this + " is a Singleton, please use getInstance().");
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			parent.removeChild(this);
			instance = null;
		}
	
	}
	
}