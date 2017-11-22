package src.com.isartdigital.snake.game 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import src.com.isartdigital.snake.Main;
	import src.com.isartdigital.snake.game.objects.Food;
	import src.com.isartdigital.snake.game.objects.player.PlayerBody;
	import src.com.isartdigital.snake.game.objects.player.PlayerHead;
	import src.com.isartdigital.snake.network.NetworkManager;
	import src.com.isartdigital.snake.ui.UIManager;
	import src.com.isartdigital.snake.utils.MoreMath;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class GameManager 
	{
		static public var score: uint;
		static public var lvlNumber: uint;
		
		static protected var initNFood: uint = 10;
		static protected var addNFood: uint = 5;
		static protected var nFood: uint;
		
		static protected var stage: Stage;
		
		static public function init(): void {
			stage = Main.getInstance().stage;
			
			score = 0;
			lvlNumber = 0;
			
			stage.addChild(GameContainer.getInstance());
			UIManager.startGame();
			
			startGame();
		}
		
		static protected function startGame(): void {
			nFood = initNFood + lvlNumber * addNFood;
			
			GameContainer.getInstance().addChild(new PlayerHead(stage.stageWidth / 2, stage.stageHeight / 2));
			for (var i = nFood - 1; i >= 0; i--) GameContainer.getInstance().addChild(new Food(MoreMath.randomRange(stage.stageWidth - stage.stageWidth / 10, stage.stageWidth / 10), MoreMath.randomRange(stage.stageHeight - stage.stageHeight / 10, stage.stageHeight / 10)));
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		static protected function gameLoop(pEvent: Event): void {
			PlayerHead.getInstance().gameLoop();
			for (var i = PlayerBody.list.length - 1; i >= 0; i--) {
				if (PlayerBody.list[i].gameLoop()) {
					gameOver();
					return;
				}
			}
			if (Food.list.length == 0) {
				nextLevel();
			}
		}
		
		static protected function destroyAllInstances(): void {
			for (var i = PlayerBody.list.length - 1; i >= 0; i--) {
				PlayerBody.list[i].destroy();
			}
			for (i = Food.list.length - 1; i >= 0; i--) Food.list[i].destroy();
			PlayerHead.getInstance().destroy();
		}
		
		static protected function nextLevel(): void {
			stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
			
			destroyAllInstances();
			
			lvlNumber++;
			
			startGame();
		}
		
		static public function gameOver(): void {
			stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
			
			destroyAllInstances();
			
			UIManager.stopGame();
			UIManager.startGameOver();
		}
		
	}

}