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
		public var dog : Dog = new Dog();
		public var banana : Banana = new Banana();

		public var rooms : Array = new Array();
		public var doors : Array = new Array();
		public var floors : Array = new Array();
		private var doorsOpen : int = 0;
		public static var globalScale : int = 4;

		public var sfxDoorOpen:Sfx = new Sfx(Assets.SFX_DOOR_OPEN);
		public var sfxWhoosh:Sfx = new Sfx(Assets.SFX_WHOOSH);
		public var sfxDoorOpenSilent:Sfx = new Sfx(Assets.SFX_DOOR_OPEN_SILENT);
		public var sfxEkhm:Sfx = new Sfx(Assets.SFX_EKHM);
		public var sfxBark:Sfx = new Sfx(Assets.SFX_BARK);

		public var doorShadow:Door;

		public var isCaughtByMom:Boolean = false;
		public var actionPerformed:Boolean = false;

		public function GameWorld()
		{
			super();

			sfxDoorOpen.volume = 1.0;
			sfxDoorOpenSilent.volume = 0.5;

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

			doorShadow = new Door(Rooms.doorPos.x, Rooms.doorPos.y);
			doorShadow.visible = true;

			add(doorShadow);
			add(player);
			add(dog);
			add(banana);
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

			if (Input.check("HID") && !doorShadow.isHidden)
			{
				if (doorShadow.isHidingEnabled && player.canJump)
				{
					doorShadow.hide(true);
					player.visible = false;
					sfxWhoosh.play();
					player.isHidden = true;
				}
				else
					player.jump();
			}

			if (Input.check("REVEAL") && doorShadow.isHidden)
			{
				doorShadow.hide(false);
				player.visible = true;
				player.isHidden = false;
				sfxWhoosh.play();
			}

			if (Input.check("ACTION"))
			{
				if (!actionPerformed)
				{
					actionPerformed = true;
					sfxEkhm.play();
				}
			}
			else
				actionPerformed = false;

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

			if (Math.abs(player.x - dog.x) < dog.reach && !dog.hadChased &&
				!player.isCrouching && !player.isHidden)
			{
				dog.isChasing = true;
				dog.spriteDog.play("RUN");
			}

			if (dog.isChasing && !dog.hadChased)
			{
				if (Math.random() > 0.98)
					sfxBark.play();

				if (player.x - dog.x < 0)
					dog.isRunnningLeft = true;
				else
					dog.isRunnningLeft = false;
			}

			var doggy:Dog = player.collide("dog", player.x, player.y) as Dog;
			if (doggy)
			{
				dog.hadChased = true;
				dog.spriteDog.play("HAPPY");
				dog.isChasing = false;
			}
		}

		public function openDoor():void
		{
			doorsOpen++;
			if (doorsOpen >= Rooms.roomCount)
				return;

			if (doorsOpen == 1)
				doorShadow.visible = true;

			doorShadow.visible = true;
			rooms[doorsOpen].visible = true;
			floors[doorsOpen].visible = true;
			doors[doorsOpen].visible = true;

			if (player.isCrouching)
				sfxDoorOpenSilent.play();
			else
			{
				caughtByMom();
				sfxDoorOpen.play();
			}

			sfxEkhm.play();
		}

		private function caughtByMom():void
		{
			isCaughtByMom = true;
		}
	}

}