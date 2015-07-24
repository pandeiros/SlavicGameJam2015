package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Spritemap;
	
	
	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Player extends PhysicalEntity 
	{
		
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
				
			spritePlayer.play("RUN_RIGHT");
		}
		
		[Embed(source='../assets/player.png')]
		private const PLAYER:Class;
		private var spritePlayer:Spritemap = new Spritemap(PLAYER, 200, 200);
		
		private const playerSpeed:int = 5;
	}

}