package 
{
	import net.flashpunk.FP;
	import punk.fx.graphics.FXImage;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Rooms 
	{
		public static function setFloor(floor : PhysicalEntity):void
		{
			//floor.super();
			floor.graphic = new FXImage(Assets.FLOOR);			
			floor.isStatic = true;
			floor.width = 142 * GameWorld.globalScale;
			floor.height = 4 * GameWorld.globalScale;
			floor.type = "solid";
			(floor.graphic as Image).scale = GameWorld.globalScale;
		}
	}

}