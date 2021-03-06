package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.debug.Console;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.debug.Console;
	import flash.system.System;
	import net.flashpunk.*;

	public class Main extends Engine
	{
		public var sfxTheme:Sfx = new Sfx(Assets.SFX_THEME);
		
		public function Main()
		{
			super(1024, 768, 60, false);
			FP.world = new GameWorld;
			sfxTheme.play(0.75);
			sfxTheme.loop();
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