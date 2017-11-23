package src.com.isartdigital.snake.game.objects.player 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import src.com.isartdigital.snake.Main;
	import src.com.isartdigital.snake.game.GameContainer;
	import src.com.isartdigital.snake.game.GameManager;
	import src.com.isartdigital.snake.game.objects.Food;
	import src.com.isartdigital.snake.game.objects.GameObject;
	import src.com.isartdigital.snake.ui.UIManager;
	import src.com.isartdigital.snake.utils.PointWithRotation;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class PlayerHead extends GameObject
	{
		static protected var instance: PlayerHead;
		static protected var canCreate: Boolean = true;
		
		static public function getInstance(): PlayerHead {
			if (instance == null) instance = new PlayerHead(0,0);
			return instance;
		}
		
		static protected var initSpeed: Number = 5;
		static protected var multSpeed: Number = 30/1500;
		
		protected var pressedKeys:Vector.<Boolean> = new Vector.<Boolean>(4, true); //UP, DOWN, LEFT, RIGHT
		protected var distanceSinceDirectionChange: Number = 0;
		protected var velocity: Point = new Point(speed, 0);
		
		public var speed: Number = 0;
		public var previousPositions: Vector.<PointWithRotation> = new Vector.<PointWithRotation>();
		
		public var mcHitbox:MovieClip;
		
		public function PlayerHead(pX: Number, pY: Number) 
		{
			super(pX, pY);
			
			if (instance != null) throw new Error(this + "is a Singleton !");
			else canCreate = false;
			
			instance = this;
			
			mcHitbox.visible = false;
			
			speed = initSpeed + GameManager.score * multSpeed;
			trace(speed);
			//speed = initSpeed + GameManager.lvlNumber * addSpeed;
			velocity.setTo(speed, 0);
			
			var stage: Stage = Main.getInstance().stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, registerKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, unregisterKey);
			
			addEventListener(Event.ADDED_TO_STAGE, createFirstPlayerBody);
		}
		
		protected function createFirstPlayerBody(pEvent:Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, createFirstPlayerBody);
			
			parent.addChild(new PlayerBody());
		}
		
		public function gameLoop():void 
		{
			var lNKeys:uint;
			for (var i = pressedKeys.length - 1; i >= 0; i--)
				if (pressedKeys[i]) lNKeys++;
			if (lNKeys == 1 && distanceSinceDirectionChange > width)
			{
				if (pressedKeys[0] && velocity.y != speed && y >= 3 * height/2) velocity.setTo(0, -speed); //UP
				else if (pressedKeys[1] && velocity.y != -speed && y <= stage.stageHeight - 3 * height/2) velocity.setTo(0, speed); //DOWN
				else if (pressedKeys[2] && velocity.x != speed && x >= 3 * width/2) velocity.setTo(-speed, 0); //LEFT
				else if (pressedKeys[3] && velocity.x != -speed && x <= stage.stageWidth - 3 * width/2) velocity.setTo(speed, 0); //RIGHT
				distanceSinceDirectionChange = 0;
			}
			//else if (lNKeys == 0) velocity.setTo(0, 0); //STOP
			
			var lHalfWidth = width / 2;
			var lHalfHeight = height / 2;
			
			if (x < lHalfWidth || x > stage.stageWidth - lHalfWidth) {
				velocity.x = 0
				
				if (y <= 3 * lHalfHeight) velocity.y = speed;
				else if (y >= stage.stageHeight - 3 * lHalfHeight) velocity.y = -speed;
				else velocity.y = Math.random() < 0.5 ? -speed : speed;
				
				if (x <= lHalfWidth) x = lHalfWidth;
				if (x >= stage.stageWidth - lHalfWidth) x = stage.stageWidth - lHalfWidth;
				distanceSinceDirectionChange = 0;
			}
			
			if (y < lHalfHeight || y > stage.stageHeight - lHalfHeight) {
				velocity.y = 0;
				
				if (x <= 3 * lHalfWidth) velocity.x = speed;
				else if (x >= stage.stageWidth - 3 * lHalfWidth) velocity.x = -speed;
				else velocity.x = Math.random() < 0.5 ? -speed : speed;
				
				if (y <= lHalfHeight) y = lHalfHeight;
				if (y >= stage.stageHeight - lHalfHeight) y = stage.stageHeight - lHalfHeight;
				distanceSinceDirectionChange = 0;
			}
			
			if (velocity.length != 0) previousPositions.push(new PointWithRotation(x, y, rotation));
			
			if (velocity.x != 0) rotation = velocity.x > 0 ? 0 : 180;
			if (velocity.y != 0) rotation = velocity.y > 0 ? 90 : 270;
			
			x += velocity.x;
			y += velocity.y;
			
			distanceSinceDirectionChange += speed;
			
			var lFood: Food;
			for (i = Food.list.length - 1; i >= 0; i--) {
				lFood = Food.list[i];
				if (hitTestObject(lFood)) {
					UIManager.refreshScore(++GameManager.score);
					lFood.destroy();
					parent.addChild(new PlayerBody());
				}
			}
		}
		
		override public function destroy(): void {
			instance = null;
			super.destroy();
		}
		
		protected function registerKey(pEvent:KeyboardEvent):void
		{
			if (pEvent.keyCode == Keyboard.UP) pressedKeys[0] = true;
			else if (pEvent.keyCode == Keyboard.DOWN) pressedKeys[1] = true;
			else if (pEvent.keyCode == Keyboard.LEFT) pressedKeys[2] = true;
			else if (pEvent.keyCode == Keyboard.RIGHT) pressedKeys[3] = true;
		}
		
		protected function unregisterKey(pEvent:KeyboardEvent):void
		{
			if (pEvent.keyCode == Keyboard.UP) pressedKeys[0] = false;
			else if (pEvent.keyCode == Keyboard.DOWN) pressedKeys[1] = false;
			else if (pEvent.keyCode == Keyboard.LEFT) pressedKeys[2] = false;
			else if (pEvent.keyCode == Keyboard.RIGHT) pressedKeys[3] = false;
		}
		
	}

}