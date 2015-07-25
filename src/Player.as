package
{
	import com.greensock.plugins.DropShadowFilterPlugin;
	import flash.filters.DropShadowFilter;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.fx.effects.AdjustFX;
	import punk.fx.effects.FilterFX;
	import punk.fx.effects.GlowFX;
	import punk.fx.graphics.FXImage;
	import punk.fx.graphics.FXSpritemap;

	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Player extends PhysicalEntity
	{
		private var spritePlayer:FXSpritemap = new FXSpritemap(Assets.PLAYER, 200, 200);
		private const playerSpeed:int = 5;

		public var filter : DropShadowFilter = new DropShadowFilter(10, 45, 0, 1, 0, 0, 1, 1);

		public function Player()
		{
			Input.define("JUMP", Key.UP);
			Input.define("LEFT", Key.LEFT);
			Input.define("RIGHT", Key.RIGHT);
			Input.define("CROUCH", Key.DOWN);

			x = 200;
			y = 100;

			width = 200;
			height = 200;

			spritePlayer.add("RUN_RIGHT", [0, 1, 2, 3], 8, true);
			spritePlayer.add("RUN_LEFT", [4, 5, 6, 7], 8, true);
			graphic = spritePlayer;
			spritePlayer.effects.add(filter);

			canJump = true;
		}

		override public function update():void
		{
			super.update();

			if (Input.check("JUMP"))
				jump();

			if (Input.check("LEFT"))
				x -= playerSpeed;
			if (Input.check("RIGHT"))
				x += playerSpeed;

			filter.angle += 5;

			spritePlayer.play("RUN_RIGHT");

			// Camera follow player
			FP.camera = location;
		}
	}

}