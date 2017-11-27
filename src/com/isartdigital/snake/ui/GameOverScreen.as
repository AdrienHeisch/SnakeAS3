package src.com.isartdigital.snake.ui 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import src.com.isartdigital.snake.Main;
	import src.com.isartdigital.snake.game.GameManager;
	import src.com.isartdigital.snake.network.NetworkManager;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class GameOverScreen extends MovieClip 
	{
		public var txtScore: TextField;
		public var txtInput: TextField;
		public var txtEnterUsername: TextField;
		public var btnRetry: SimpleButton;
		
		protected var myFont: Font;
		protected var myFormat: TextFormat;
		
		protected var leaderboard: XML;
		protected var leaderboardPage: uint;
		protected var textList: Vector.<TextField> = new Vector.<TextField>();
		
		public function GameOverScreen() 
		{
			super();
			
			txtScore.text = "Your score : " + GameManager.score;
			if (Main.getInstance().sharedData.data.username == null) {
				btnRetry.visible = false;
				startTextInput();
			}
			else {
				txtEnterUsername.visible = false;
				txtInput.visible = false;
				NetworkManager.getLeaderboard(this, Main.getInstance().sharedData.data.username, GameManager.score);
				btnRetry.addEventListener(MouseEvent.CLICK, onBtnRetry);
			}
		}
		
		protected function startTextInput(): void {
			var stage:Stage = Main.getInstance().stage;
			txtInput.type = TextFieldType.INPUT;
			stage.focus = txtInput;
			txtInput.setSelection(0, 0);
			txtInput.addEventListener(TextEvent.TEXT_INPUT, function():void{});
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function():void{ stage.focus = txtInput; });
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stopCapture);
		}
		
		protected function stopCapture(pEvent:KeyboardEvent): void {
			if (pEvent.keyCode == Keyboard.ENTER) {
				Main.getInstance().sharedData.data.username = txtInput.text;
				txtInput.removeEventListener(TextEvent.TEXT_INPUT, function():void{});
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, function():void{ stage.focus = txtInput; });
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, stopCapture);
				txtInput.type = TextFieldType.DYNAMIC;
				NetworkManager.getLeaderboard(this, Main.getInstance().sharedData.data.username, GameManager.score);
			}
		}
		
		public function leaderboardSetup(): void {
			removeChild(txtInput);
			removeChild(txtEnterUsername);
			btnRetry.visible = true;
			btnRetry.addEventListener(MouseEvent.CLICK, onBtnRetry);
			
			var lLeaderboard: Leaderboard;
			addChild(lLeaderboard = new Leaderboard());
			lLeaderboard.x = stage.stageWidth / 2;
			lLeaderboard.y = stage.stageHeight / 2;
		}
		
		protected function onBtnRetry(pEvent:Event): void {
			btnRetry.addEventListener(MouseEvent.CLICK, onBtnRetry);
			
			var stage:Stage = Main.getInstance().stage;
			UIManager.stopGameOver();
			stage.focus = stage;
			GameManager.init();
		}
		
	}

}