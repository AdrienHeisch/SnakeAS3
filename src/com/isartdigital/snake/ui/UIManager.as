package src.com.isartdigital.snake.ui 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import src.com.isartdigital.snake.Main;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class UIManager
	{
		static protected var stage: Stage;
		
		static protected var hud: HUD;
		static protected var gameOverScreen: GameOverScreen;
		
		static public function startGame(): void {
			stage = Main.getInstance().stage;
			
			stage.addChild(UIContainer.getInstance());
			
			UIContainer.getInstance().addChild(hud = new HUD());
		}
		
		static public function refreshScore(pScore:uint): void {
			hud.txtScore.text = "SCORE : " + String(pScore);
		}
		
		static public function stopGame(): void {
			hud.parent.removeChild(hud);
			hud = null;
		}
		
		static public function startGameOver(): void {
			UIContainer.getInstance().addChild(gameOverScreen = new GameOverScreen());
		}
		
		static public function stopGameOver(): void {
			gameOverScreen.parent.removeChild(gameOverScreen);
			gameOverScreen = null;
		}
		
	}

}