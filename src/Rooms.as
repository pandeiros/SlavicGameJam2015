package
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import punk.fx.graphics.*;

	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Rooms
	{
		public static const roomCount:int = 5;
		public static var positions:Array = new Array(0, (142 + 3) * GameWorld.globalScale, (142 + 3) * GameWorld.globalScale * 2, (142 + 3) * GameWorld.globalScale * 3, (142 + 3) * GameWorld.globalScale * 4, (142 + 3) * GameWorld.globalScale * 5);

		public static const dogPos:Point = new Point((142 + 3) * GameWorld.globalScale * 2 - 150, FP.height - 15 * GameWorld.globalScale);

		public static const bananaPos:Point = new Point((142 + 3) * GameWorld.globalScale * 3 - 150, FP.height - 9 * GameWorld.globalScale);

		public static const doorPos:Point = new Point((142 * 1.5 + 3) * GameWorld.globalScale, FP.height - 27 * GameWorld.globalScale);

		public static function setFloor(floor:PhysicalEntity, index:int):void
		{
			floor.graphic = new FXImage(Assets.FLOOR);
			floor.isStatic = true;
			floor.width = 142 * GameWorld.globalScale;
			floor.height = 4 * GameWorld.globalScale;

			if (index > 0)
				floor.visible = false;
			floor.type = "solid";
			(floor.graphic as Image).scale = GameWorld.globalScale;
		}

		public static function setRoom(room:Entity, index:int):void
		{

			if (index == 0)
				room.graphic = new FXImage(Assets.ROOM_JUSTIN);
			if (index == 1)
				room.graphic = new FXImage(Assets.ROOM_1);
			if (index == 2)
				room.graphic = new FXImage(Assets.ROOM_2);
			if (index == 3)
				room.graphic = new FXImage(Assets.ROOM_3);
			if (index == 4)
				room.graphic = new FXImage(Assets.KITCHEN);

			if (index > 0)
				room.visible = false;

			room.x = positions[index];
			room.y = FP.height - 41 * GameWorld.globalScale;
			(room.graphic as Image).scale = GameWorld.globalScale;
		}

		public static function setDoor(door:Entity, index:int):void
		{
			door.graphic = new FXImage(Assets.DOOR_SIDE);
			if (index > 0)
				door.visible = false;

			door.x = positions[index + 1] - 8 * GameWorld.globalScale;
			door.y = FP.height - 27 * GameWorld.globalScale;
			door.width = 5 * GameWorld.globalScale;
			door.height = 27 * GameWorld.globalScale;
			door.type = "door";
			(door.graphic as Image).scale = GameWorld.globalScale;
		}
	}

}