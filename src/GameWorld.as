package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.fx.effects.FX;
	import punk.fx.effects.PixelateFX;
	import punk.fx.graphics.FXImage;

	/**
	 * ...
	 * @author daltostronic
	 */
	public class GameWorld extends World
	{
		public var player : Player = new Player();
		public var rooms : Array = new Array();
		public var doors : Array = new Array();
		public var floor : PhysicalEntity;
		public static var globalScale : int = 4;

		public function GameWorld()
		{
			super();

			floor = new PhysicalEntity(0, FP.height);
			Rooms.setFloor(floor);

			add(floor);
			add(player);
		}

		override public function render():void
		{
			super.render();
			if (Input.check(Key.H))
			{
				var o:Array = new Array();
				getAll(o);
				for each (var e:Entity in o)
				{
					Draw.hitbox(e, true, 0xFF0000, 0.5);
				}
			}
		}

		override public function update():void
		{
			super.update();
			if (Input.check(Key.F5))
			{
				FP.world = new GameWorld;
			}
			//if (Input.pressed(Key.ANY))
			//{
				//FP.screen.color = Math.random() < 0.5 ? 0xFFFFFF : 0x000000;
			//}

			FP.screen.color = FP.colorLerp(FP.screen.color, 0x55B0FF, FP.elapsed * 5);
		}

	}

}