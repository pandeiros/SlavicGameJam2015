package
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	/**
	 * ...
	 * @author daltostronic
	 */
	public class PhysicalEntity extends Entity
	{
		public var velocity:Point = new Point(0, 0);
		public var gravity:Point = new Point(0, 0.098);
		public var friction:Point = new Point(0.98, 0.98);
		public var bounciness:Point = new Point(0.2, 0.2);
		public var direction:int = 1;
		public var speed:Number = 3;
		public var jumpSpeed:Number = 5;
		
		private var onGround:Boolean = false;
		private var initialized:Boolean = false;

		public function grounded():Boolean
		{
			return onGround;
		}

		private var onWall:Boolean = false;

		public function touchesWall():Boolean
		{
			return onWall;
		}

		public var canJump:Boolean = false;

		public var isStatic:Boolean = false;

		public var precision:Number = .5;

		//[Embed(source = '/assets/sfx/weee.mp3')]
		//public const WEEE_MP3 : Class;
		//public var weee : Sfx = new Sfx(WEEE_MP3);

		public function PhysicalEntity(x:Number = 0, y:Number = 0)
		{
			super(x, y);

		}

		override public function update():void
		{
			location.x = x;
			location.y = y;
			
			super.update();
			if (!initialized) {
				initialized = true;
				onGameInit();
			}

			if (!isStatic)
			{
				resetStates();
				applyGravity();
				applyVelocity();
				applyFriction();

				resetJump();

				if (velocity.x)
					direction = FP.sign(velocity.x);
			}
		}

		public function onGameInit() : void
		{
		
		}

		private function resetStates():void
		{
			// apply states
			onWall = false;
			onGround = false;
		}

		private function applyGravity():void
		{
			// apply gravity
			velocity.x += gravity.x;
			velocity.y += gravity.y;
		}

		private function applyVelocity():void
		{
			var i:Number = 0;
			var other:Entity = null;

			// apply velocity x
			for (i = 0; i < Math.abs(velocity.x); i += precision)
			{
				other = collide("solid", x + FP.sign(velocity.x) * precision, y);
				if (other)
				{
					onCollision(other);
					velocity.x = -velocity.x * bounciness.x;
					onWall = true;
					break;
				}
				else
					x += FP.sign(velocity.x) * precision;
			}

			// apply velocity y
			for (i = 0; i < Math.abs(velocity.y); i += precision)
			{
				other = collide("solid", x, y + FP.sign(velocity.y) * precision) as Entity;
				if (other && other.y + other.height / 2 > y + height / 2) // velocity.y > 0 &&
				{
					onCollision(other);
					if (FP.sign(velocity.y) == FP.sign(gravity.y))
						onGround = true;
					velocity.y = -velocity.y * bounciness.y;
					break;
				}
				else
					y += FP.sign(velocity.y) * precision;
			}
		}

		private function applyFriction():void
		{
			if (onWall && friction.y)
			{
				if (velocity.y > 0)
				{
					velocity.y -= friction.y;
					if (velocity.y < 0)
						velocity.y = 0;
				}
				if (velocity.y < 0)
				{
					velocity.y += friction.y;
					if (velocity.y > 0)
						velocity.y = 0;
				}
			}

			if (onGround && friction.x)
			{
				if (velocity.x > 0)
				{
					velocity.x -= friction.x;
					if (velocity.x < 0)
						velocity.x = 0;
				}
				if (velocity.x < 0)
				{
					velocity.x += friction.x;
					if (velocity.x > 0)
						velocity.x = 0;
				}
			}
		}

		public function resetJump():void
		{
			canJump = canJump || onGround; // || onWall;
		}

		public function jump():void
		{
			if (canJump)
			{
				//weee.play();
				velocity.y = -jumpSpeed;
				if (touchesWall())
					velocity.x = -direction * speed;
			}

			canJump = false;
		}

		public function onCollision(other:Entity):void
		{

		}

	}

}