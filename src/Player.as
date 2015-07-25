package
{
	import flash.filters.DropShadowFilter;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.fx.graphics.FXSpritemap;

	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Player extends PhysicalEntity
	{
		private var spritePlayer:FXSpritemap = new FXSpritemap(Assets.PLAYER, 200, 200);
		private const playerSpeed:int = 5;

		private const crouchSpeed:int = 2;

		private var isCrouching:Boolean = false;
		private var isFacingRight:Boolean = true;
		private var currentSpeed:int = 0;

		public var filter:DropShadowFilter = new DropShadowFilter(10, 45, 0, 1, 0, 0, 1, 1);

		public function Player()
		{
			Input.define("JUMP", Key.UP);
			Input.define("LEFT", Key.LEFT);
			Input.define("RIGHT", Key.RIGHT);
			Input.define("CROUCH", Key.CONTROL);

			x = 100;
			y = 100;

			type = "player";
			setHitbox(200, 200, 100, 100);

			spritePlayer.add("RUN", [0, 1, 2, 3], 8, true);
			//spritePlayer.add("RUN_LEFT", [4, 5, 6, 7], 8, true);
			graphic = spritePlayer;
			spritePlayer.effects.add(filter);
			(graphic as Image).centerOrigin();

			canJump = true;
		}

		override public function update():void
		{
			super.update();

			if (Input.check("JUMP"))
				jump();

			resetJump();

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

			if (Input.check("LEFT"))
			{
				x -= currentSpeed;
				isFacingRight = false;
			}
			if (Input.check("RIGHT"))
			{
				x += currentSpeed;
				isFacingRight = true;
			}

			filter.angle += 5;
			FP.camera.x = location.x - FP.width / 2;
			FP.camera.y = location.y - FP.height / 2;

			updateAnim();
		}

		public function updateAnim():void
		{
			if (!isFacingRight)
			{
				(graphic as Image).scaleX = -1;
			}
			else
			{
				(graphic as Image).scaleX = 1;
			}

			if (!isCrouching)
				spritePlayer.play("RUN");
		}
	}

}