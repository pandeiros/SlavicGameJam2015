package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import punk.fx.graphics.FXImage;

	/**
	 * ...
	 * @author daltostronic
	 */
	public class Banana extends PhysicalEntity
	{

		public function Banana(x:Number = 0, y:Number = 0)
		{
			super(Rooms.bananaPos.x + x, Rooms.bananaPos.y + y);
			var img:FXImage = new FXImage(Assets.BANANA);
			graphic = img;
			img.scale = GameWorld.globalScale;
			//img.centerOrigin();

			visible = false;
			setHitbox(11 * GameWorld.globalScale, 6 * GameWorld.globalScale, 0, 0);
			type = "banana";
		}

	}

}