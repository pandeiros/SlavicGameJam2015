package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	/**
	 * ...
	 * @author daltostronic
	 */
	public class GameWorld extends World
	{

		public function GameWorld()
		{
			super();

			var a:PhysRect = new PhysRect(50, 50, 10, 10);
			add(a);
			var b:PhysRect = new PhysRect(0, 200, 400, 10);
			b.isStatic = true;
			add(b);
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

			Draw.text("FPS: " + Math.round(Math.random() * 10 + 55), FP.width - 75, 2.5);
		}

		override public function update():void
		{
			super.update();
			if (Input.check(Key.F5))
			{
				FP.world = new GameWorld;
			}
			if (Input.pressed(Key.ANY))
			{
				FP.screen.color = Math.random() < 0.5 ? 0xFFFFFF : 0x000000;
			}

			FP.screen.color = FP.colorLerp(FP.screen.color, 0x55B0FF, FP.elapsed * 5);
		}

	}

}