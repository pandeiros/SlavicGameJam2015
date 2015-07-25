package 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import punk.fx.graphics.*;
	
	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Rooms 
	{
		public static const roomCount:int = 3;
		public static var positions:Array = new Array(0, 142 * GameWorld.globalScale, 
			142 * GameWorld.globalScale * 2, 142 * GameWorld.globalScale * 3);
			
		public static function setFloor(floor:PhysicalEntity):void
		{
			floor.graphic = new FXImage(Assets.FLOOR);			
			floor.isStatic = true;
			floor.width = 142 * GameWorld.globalScale;
			floor.height = 4 * GameWorld.globalScale;
			floor.type = "solid";
			(floor.graphic as Image).scale = GameWorld.globalScale;
		}
		
		public static function setRoom(room:Entity, index:int):void
		{
			if (index == 0)
				room.graphic = new FXImage(Assets.ROOM_1);
			if (index == 1)
				room.graphic = new FXImage(Assets.ROOM_2);
			if (index == 2)
				room.graphic = new FXImage(Assets.ROOM_3);
				
			room.x = positions[index];
			room.y = FP.height - 41 * GameWorld.globalScale;
			(room.graphic as Image).scale = GameWorld.globalScale;
		}
	}

}