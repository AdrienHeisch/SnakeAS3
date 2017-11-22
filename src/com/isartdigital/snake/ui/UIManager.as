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
		static protected var _font: Font;
		static protected var _format: TextFormat;
		
		static public function get font(): Font {
			if (_font == null) _font = new Font1();
			return _font;
		}
		
		static public function get format(): TextFormat {
			if (_format == null) {
				_format = new TextFormat();
				_format.font = _font.fontName;
				_format.align = TextFormatAlign.CENTER;
				_format.size = 25;
				_format.color = 0x333333;
			}
			return _format;
		}
		
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
		
		static public function leaderboardSetup(): void {
			if (gameOverScreen != null) gameOverScreen.leaderboardSetup();
		}
		
		static public function stopGameOver(): void {
			gameOverScreen.parent.removeChild(gameOverScreen);
			gameOverScreen = null;
		}
		
	}

}