package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.fx.graphics.FXImage;
	import punk.fx.graphics.FXSpritemap;

	/**
	 * ...
	 * @author daltostronic
	 */
	public class GameWorld extends World
	{
		public var player:Player = new Player();
		public var dog:Dog = new Dog();
		public var banana:Banana = new Banana();

		public var rooms:Array = new Array();
		public var doors:Array = new Array();
		public var floors:Array = new Array();
		private var doorsOpen:int = 0;
		public static var globalScale:int = 4;

		public var sfxDoorOpen:Sfx = new Sfx(Assets.SFX_DOOR_OPEN);
		public var sfxWhoosh:Sfx = new Sfx(Assets.SFX_WHOOSH);
		public var sfxDoorOpenSilent:Sfx = new Sfx(Assets.SFX_DOOR_OPEN_SILENT);
		public var sfxEkhm:Sfx = new Sfx(Assets.SFX_EKHM);
		public var sfxBark:Sfx = new Sfx(Assets.SFX_BARK);

		public var doorShadow:Door;

		public var texBubbleMom:Entity = new Entity();
		public var texBubbleJustin:Entity = new Entity();
		public var momHead:Entity = new Entity();
		public var dialogue:int = 0;

		public var isCaughtByMom:Boolean = false;
		public var actionPerformed:Boolean = false;
		public var win:Boolean = false;

		public var text1:Text = new Text("What's that noise??", 0, 0, { "size":18, "color":"0x000000" } );
		public var text2:Text = new Text("Get back to your room!", 0, 0, { "size":18, "color":"0x000000" } );
		public var text3:Text = new Text("Just, do it!", 0, 0, { "size":18, "color":"0x000000" });
		public var text4:Text = new Text("Have you done\nyour homework?", 0, 0, { "size":18, "color":"0x000000" });
		public var text5:Text = new Text("Naaah....", 0, 0, { "size":18, "color":"0x000000" } );
		public var text6:Text = new Text("Nothing.", 0, 0, { "size":18, "color":"0x000000" });
		public var text7:Text = new Text("I've done it!", 0, 0, { "size":18, "color":"0x000000" } );

		public var textRandom:int = 0;

		public function GameWorld()
		{
			super();

			sfxDoorOpen.volume = 1.0;
			sfxDoorOpenSilent.volume = 0.5;
			sfxEkhm.volume = 0.0;

			for (var i:int = 0; i < Rooms.roomCount; i++)
			{
				var floor:PhysicalEntity = new PhysicalEntity(Rooms.positions[i], FP.height);
				Rooms.setFloor(floor, i);
				floors.push(floor);
				add(floor);
			}

			for (i = 0; i < Rooms.roomCount; i++)
			{
				var room:Entity = new Entity();
				Rooms.setRoom(room, i);
				rooms.push(room);
				add(room);
			}

			for (i = 0; i < Rooms.roomCount; i++)
			{
				var door:Entity = new Entity();
				Rooms.setDoor(door, i);
				doors.push(door);
				add(door);
			}

			doorShadow = new Door(Rooms.doorPos.x, Rooms.doorPos.y);
			doorShadow.visible = false;
			dog.visible = false;

			texBubbleMom.graphic = new FXImage(Assets.TEXT);
			texBubbleMom.visible = false;
			texBubbleJustin.graphic = new FXImage(Assets.TEXT);
			texBubbleJustin.visible = false;
			momHead.graphic = new FXImage(Assets.MOM_HEAD);
			momHead.visible = false;

			(texBubbleMom.graphic as Image).scale = GameWorld.globalScale * 2;
			(texBubbleMom.graphic as Image).flipped = true;
			(texBubbleJustin.graphic as Image).scale = GameWorld.globalScale;
			(momHead.graphic as Image).scale = GameWorld.globalScale * 2;
			(momHead.graphic as Image).flipped = true;

			add(doorShadow);
			add(player);
			add(dog);
			add(banana);
			texBubbleMom.layer = 10;
			add(texBubbleMom);
			add(texBubbleJustin);
			add(momHead);

			text1.visible = text2.visible = text3.visible = text4.visible = text5.visible = text6.visible = text7.visible = false;

			addGraphic(text1, -100);
			addGraphic(text2, -100);
			addGraphic(text3, -100);
			addGraphic(text4, -100);
			addGraphic(text5, -100);
			addGraphic(text6, -100);
			addGraphic(text7, -100);
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

			if (win)
			{
				texBubbleJustin.x = FP.camera.x + FP.halfWidth + 20;
				texBubbleJustin.y = FP.camera.y + FP.halfHeight - 100;
				texBubbleJustin.visible = true;

				// DALTON Text "I've done it!"

				if (Input.pressed(Key.ENTER))
					FP.world = new GameWorld;
				return;
			}

			if (isCaughtByMom)
			{
				texBubbleMom.x = FP.camera.x + FP.width - 400;
				texBubbleMom.y = FP.camera.y + 10;
				texBubbleJustin.x = FP.camera.x + FP.halfWidth + 20;
				texBubbleJustin.y = FP.camera.y + FP.halfHeight - 100;
				momHead.x = FP.camera.x + FP.width - 100;
				momHead.y = FP.camera.y + 80;
				momHead.visible = true;

				text5.x = text6.x = text7.x = FP.camera.x + FP.halfWidth + 50;
				text5.y = text6.y = text7.y = FP.camera.y + FP.halfHeight - 85;

				text1.x = text2.x = text3.x = text4.x = FP.camera.x + FP.width - 380;
				text1.y = text2.y = text3.y = text4.y = FP.camera.y + 50;

				if (Input.pressed(Key.ENTER))
					dialogue++;

				switch (dialogue)
				{
					case 0:
						if (textRandom == 0)
							text1.visible = true;
						else
							text4.visible = true;

						texBubbleMom.visible = true;
						break;
					case 1:
						if (textRandom == 0)
							text6.visible = true;
						else
							text5.visible = true;

						text1.visible = text4.visible = false;
						texBubbleMom.visible = false;
						texBubbleJustin.visible = true;
						break;
					case 2:
						if (textRandom == 0)
							text2.visible = true;
						else
							text3.visible = true;

						text6.visible = text5.visible = false;
						texBubbleMom.visible = true;
						texBubbleJustin.visible = false;
						break;
					case 3:
						FP.world = new GameWorld;
					default:
				}
				return;
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

			if (Input.pressed("ACTION"))
			{
				//if (!actionPerformed)
				//{
				//actionPerformed = true;
				sfxEkhm.play();
				//}
				if (player.isHidden)
				{
					dog.tricked = true;
					dog.spriteDog.play("RUN");
				}
			}
			else
				actionPerformed = false;

			player.resetJump();

			FP.screen.color = FP.colorLerp(FP.screen.color, 0x000000, FP.elapsed * 5);

			checkCollision();
		}

		var img:FXSpritemap;
		var time:Number = 0;

		public function checkCollision():void
		{
			var banana:Banana = player.collide("banana", player.x, player.y) as Banana;
			if (banana && !player.isSlipped)
			{
				player.isSlipped = true;
				img = new FXSpritemap(Assets.FALL, 22, 18);
				player.visible = false;
				addGraphic(img, 0, player.x, player.y);
				img.centerOrigin();
				img.scale = GameWorld.globalScale;
				img.add("fall", [0, 1, 2], 8, false);
				img.play("fall");
			}
			else if (player.isSlipped && time <= 0.75)
			{
				time += FP.elapsed;
				img.x += 5;
			}
			else if (player.isSlipped)
			{
				caughtByMom();
			}

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

			if (Math.abs(player.x - dog.x) < dog.reach && !dog.hadChased && !player.isCrouching && !player.isHidden)
			{
				dog.isChasing = true;
				dog.spriteDog.play("RUN");
			}

			if (dog.isChasing && !dog.hadChased)
			{
				if (player.x - dog.x < 0)
					dog.isRunnningLeft = true;
				else
					dog.isRunnningLeft = false;
			}

			var doggy:Dog = player.collide("dog", player.x, player.y) as Dog;
			if (doggy && !dog.tricked)
			{
				dog.hadChased = true;
				dog.spriteDog.play("HAPPY");
				dog.isChasing = false;
				caughtByMom();
				sfxBark.play();
			}
		}

		public function openDoor():void
		{
			doorsOpen++;
			if (doorsOpen >= Rooms.roomCount)
				return;

			doorShadow.visible = true;
			dog.visible = true;
			rooms[doorsOpen].visible = true;
			floors[doorsOpen].visible = true;
			doors[doorsOpen].visible = true;

			if (doorsOpen == 2)
				banana.visible = true;

			if (player.isCrouching)
				sfxDoorOpenSilent.play();
			else
			{
				caughtByMom();
				sfxDoorOpen.play();
			}

			if (doorsOpen == 5)
				win = true;
		}

		private function caughtByMom():void
		{
			if (Math.random() > 0.5)
				textRandom = 1;
			else
				textRandom = 0;

			isCaughtByMom = true;
		}
	}

}