package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;

	/**
	 * ...
	 * @author daltostronic
	 */
	public class CrazyText extends Entity
	{
		public var lifeSpan:Number = 0.5;
		public var follow:Boolean = false;

		public function CrazyText(text:String = "", x:Number = 0, y:Number = 0, time:Number = 0.5, size:Number = 24)
		{
			super(x, y);

			init(text, x, y, time, size);
		}

		public function init(text:String = "", x:Number = 0, y:Number = 0, time:Number = 0.5, size:Number = 24):void
		{
			this.x = x;
			this.y = y;

			lifeSpan = time;

			graphic = new Text(text, 0, 0, {size: size});
			Text(graphic).centerOrigin();
		}

		override public function update():void
		{
			super.update();

			lifeSpan -= FP.elapsed;
			if (lifeSpan <= 0)
				world.remove(this);

			var txt:Text = graphic as Text;
			txt.color = Math.random() > 0.5 ? 0xFFFFFF : 0x000000;
			txt.scale = 1 + Math.random() * 0.3 - 0.15;
			txt.angle += Math.random() * 4 - 2;

			if (follow)
			{
				x = FP.camera.x + FP.halfWidth;
				y = FP.camera.y + FP.halfHeight;
			}
		}
	}

}