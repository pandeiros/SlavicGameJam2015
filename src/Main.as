package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.debug.Console;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.debug.Console;
	import flash.system.System;

	public class Main extends Engine
	{
		public function Main()
		{
			super(1024, 768, 60, false);
			FP.world = new GameWorld;
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
			FP.console.enable();
			FP.console.visible = false;
			FP.log("Yo!");
		}

		override public function update():void
		{
			if (Input.pressed(Key.F1))
			{
				FP.console.visible = !FP.console.visible;
			}
			if (Input.check(Key.ESCAPE))
			{
				System.exit(0);
			}

			super.update();
		}
	}
}