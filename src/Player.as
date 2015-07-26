package
{
	import flash.filters.DropShadowFilter;
	import net.flashpunk.*;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.fx.graphics.*;
	import punk.fx.graphics.FXSpritemap;

	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Player extends PhysicalEntity
	{
		private var spritePlayer:FXSpritemap = new FXSpritemap(Assets.PLAYER, 14, 18);
		private const playerSpeed:int = 5;

		private const crouchSpeed:int = 2;

		public var isCrouching:Boolean = false;
		private var isFacingRight:Boolean = true;
		private var isMoving:Boolean = false;
		public var isHidden:Boolean = false;
		public var isSlipped:Boolean = false;
		private var currentSpeed:int = 0;

		public var filter:DropShadowFilter = new DropShadowFilter(10, 45, 0, 1, 0, 0, 1, 1);

		public function Player()
		{
			Input.define("JUMP", Key.UP);
			Input.define("LEFT", Key.LEFT);
			Input.define("RIGHT", Key.RIGHT);
			Input.define("CROUCH", Key.CONTROL);
			Input.define("HID", Key.UP);
			Input.define("REVEAL", Key.DOWN);
			Input.define("ACTION", Key.SPACE);

			x = 200;
			y = 500;

			var scale:int = GameWorld.globalScale;
			setHitbox(14 * scale, 18 * scale, 7 * scale, 9 * scale);
			jumpSpeed = 6;

			spritePlayer.add("IDLE", [0, 0, 0, 0, 0, 13], 4, true);
			spritePlayer.add("JUMP", [2, 3], 3, true);
			spritePlayer.add("RUN", [4, 5, 0], 8, true);
			spritePlayer.add("CROUCH", [10], 8, true);
			spritePlayer.add("SNEAK", [11, 12, 10], 4, true);
			graphic = spritePlayer;
			//spritePlayer.effects.add(filter);
			(graphic as Image).centerOrigin();
			(graphic as Image).scale = GameWorld.globalScale;

			spritePlayer.play("IDLE");
			canJump = true;
		}

		override public function update():void
		{
			super.update();

			currentSpeed = playerSpeed;

			if (Input.check("CROUCH"))
			{
				currentSpeed = crouchSpeed;
				isCrouching = true;
			}

			if (Input.released("CROUCH"))
			{
				isCrouching = false;
			}

			isMoving = true;
			if ((FP.world as GameWorld).isCaughtByMom)
				isMoving = false;
			else if (isHidden || isSlipped)
				isMoving = false;
			else if (Input.check("LEFT"))
			{
				x -= currentSpeed;
				isFacingRight = false;
			}
			else if (Input.check("RIGHT"))
			{
				x += currentSpeed;
				isFacingRight = true;
			}
			else
			{
				isMoving = false;
			}

			filter.angle += 1;
			FP.camera.x = location.x - FP.width / 2;
			FP.camera.y = location.y - FP.height / 2;

			checkCollision();
			if (!isSlipped)
				updateAnim();
			else
			{
				var img:Image = graphic as Image;
				img.angle += 10;
				x -= 5;
			}
		}

		public function checkCollision():void
		{

		}

		public function updateAnim():void
		{
			if (!canJump)
			{
				spritePlayer.play("JUMP");
			}
			else if (!isCrouching)
			{
				if (isMoving)
					spritePlayer.play("RUN");
				else
					spritePlayer.play("IDLE");
			}
			else
			{
				if (isMoving)
					spritePlayer.play("SNEAK");
				else
					spritePlayer.play("CROUCH");
			}

			if (!isFacingRight)
			{
				(graphic as Image).flipped = true;
			}
			else
			{
				(graphic as Image).flipped = false;
			}
		}
	}
}