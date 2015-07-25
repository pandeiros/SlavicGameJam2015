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
		public var floors : Array = new Array();
		private var doorsOpen : int = 0;
		public static var globalScale : int = 4;

		public function GameWorld()
		{
			super();

			for (var i:int = 0; i < Rooms.roomCount; i++)
			{
				var floor:PhysicalEntity = new PhysicalEntity(Rooms.positions[i], FP.height);
				Rooms.setFloor(floor, i);
				floors.push(floor);
				add(floor);
			}
			
			for (i = 0; i < Rooms.roomCount; i++)
			{
				var room : Entity = new Entity();
				Rooms.setRoom(room, i);
				rooms.push(room);
				add(room);
			}
			
			for (i = 0; i < Rooms.roomCount; i++)
			{
				var door : Entity = new Entity();
				Rooms.setDoor(door, i);
				doors.push(door);
				add(door);
			}
			

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

			FP.screen.color = FP.colorLerp(FP.screen.color, 0x000000, FP.elapsed * 5);
			
			checkCollision();
		}

		public function checkCollision():void
		{
			var door:Entity = player.collide("door", player.x - 10, player.y) as Entity;

			if (door)
			{
				door.graphic = new FXImage(Assets.DOOR_OPEN);
				(door.graphic as Image).scale = GameWorld.globalScale;
				openDoor();
				door.collidable = false;
			}
		}
		
		public function openDoor():void
		{
			doorsOpen++;
			if (doorsOpen >= Rooms.roomCount)
				return;
			
			rooms[doorsOpen].visible = true;
			floors[doorsOpen].visible = true;
			doors[doorsOpen].visible = true;
		}
	}

}