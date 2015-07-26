package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import punk.fx.graphics.*;

	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Dog extends Entity
	{
		public var spriteDog:FXSpritemap = new FXSpritemap(Assets.DOG, 26, 15);
		public const reach:int = 75 * GameWorld.globalScale;
		public var isChasing:Boolean = false;
		public var isRunnningLeft:Boolean = false;
		private var dogSpeed:int = 7;
		public var hadChased:Boolean = false;
		public var tricked:Boolean = false;

		public function Dog()
		{
			width = 24 * GameWorld.globalScale;
			height = 15 * GameWorld.globalScale;
			spriteDog.add("SLEEP", [2, 3], 3, true);
			spriteDog.add("RUN", [0, 1], 4, true);
			spriteDog.add("HAPPY", [5, 6, 7, 6, 7], 4, true);
			graphic = spriteDog;
			spriteDog.play("SLEEP");
			x = Rooms.dogPos.x;
			y = Rooms.dogPos.y;

			(graphic as Image).scale = GameWorld.globalScale;
			type = "dog";
		}

		override public function update():void
		{
			if (tricked)
			{
				x -= dogSpeed;
			}
			else if (isChasing)
			{
				if (Math.random() > 0.98)
					(FP.world as GameWorld).sfxBark.play();

				if (isRunnningLeft)
				{
					x -= dogSpeed;
					(graphic as Image).flipped = false;
				}
				else
				{
					x += dogSpeed;
					(graphic as Image).flipped = false;
				}

				if (!hadChased)
				{
					FP.world.add(new CrazyText("!", x + 20, y - 25, 0.05, 64));
				}
			}
		}
	}
}