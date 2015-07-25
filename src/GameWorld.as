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
		
		public var sfxDoorOpen:Sfx = new Sfx(Assets.SFX_DOOR_OPEN);
		public var sfxWhoosh:Sfx = new Sfx(Assets.SFX_WHOOSH);
		
		public var doorShadow:Door;

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
			
			doorShadow = new Door((142 * 1.5 + 3) * GameWorld.globalScale,
				FP.height - 27 * GameWorld.globalScale);
			doorShadow.visible = true;
			
			add(doorShadow);
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
			
			if (Input.check("HID"))
			{
				if (doorShadow.isHidingEnabled)
				{
					doorShadow.hide(true);
					player.visible = false;
					sfxWhoosh.play();
				}
				else
					player.jump();
			}
			
			if (Input.check("REVEAL") && doorShadow.isHidden)
			{
					doorShadow.hide(false);
					player.visible = true;
					sfxWhoosh.play();
			}

			player.resetJump();

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
			
		
			var ds:Door = player.collide("door_shadow", player.x, player.y) as Door;
		
			if (ds)
				doorShadow.isHidingEnabled = true;
			else
				doorShadow.isHidingEnabled = false;
		}
		
		public function openDoor():void
		{
			doorsOpen++;
			if (doorsOpen >= Rooms.roomCount)
				return;
			
			doorShadow.visible = true;
			rooms[doorsOpen].visible = true;
			floors[doorsOpen].visible = true;
			doors[doorsOpen].visible = true;
			sfxDoorOpen.play();
		}
	}

}