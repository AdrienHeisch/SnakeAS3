package src.com.isartdigital.snake.game.objects.player 
{
	import flash.display.MovieClip;
	import src.com.isartdigital.snake.game.GameManager;
	import src.com.isartdigital.snake.game.objects.GameObject;
	import src.com.isartdigital.snake.utils.PointWithRotation;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class PlayerBody extends GameObject 
	{
		
		static public var list: Vector.<PlayerBody> = new Vector.<PlayerBody>();
		
		protected var playerHead: PlayerHead;
		protected var positionIndexOffset: uint;
		
		public var mcHitbox:MovieClip;
		
		public function PlayerBody() 
		{
			super(-100, -100);
			
			list.push(this);
			
			mcHitbox.visible = false;
			
			playerHead = PlayerHead.getInstance();
			
			positionIndexOffset = PlayerBody.list.length * 0.75 * playerHead.width / playerHead.speed;
		}
		
		override public function destroy():void 
		{
			list.splice(list.indexOf(this), 1);
			super.destroy();
		}
		
		public function gameLoop():Boolean 
		{
			if (list.indexOf(this) > 1 && mcHitbox.hitTestObject(playerHead.mcHitbox) && Math.abs(rotation - playerHead.rotation)%180 == 90) return true;
			
			var positionIndex: int = playerHead.previousPositions.length - positionIndexOffset;
			if (positionIndex >= 0) {
				var lPointWithRotation: PointWithRotation = playerHead.previousPositions[positionIndex];
				x = lPointWithRotation.x;
				y = lPointWithRotation.y;
				rotation = lPointWithRotation.rotation;
			}
			return false;
		}
		
	}

}