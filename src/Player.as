package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	
	
	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Player extends PhysicalEntity 
	{
		[Embed(source='../assets/player.png')]
		private const PLAYER:Class;
		private var spritePlayer:Spritemap = new Spritemap(PLAYER, 200, 200);
		
		private const playerSpeed:int = 5;
		private const crouchSpeed:int = 2;
		
		private var isCrouching:Boolean = false;
		private var isFacingRight:Boolean = true;
		private var currentSpeed:int = 0;
		
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
				
			updateAnim();
		}		
		
		public function updateAnim ():void
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