package
{

	/**
	 * ...
	 * @author daltostronic
	 */
	public class Assets
	{
		// --- GFX ENTITIES ---
		[Embed(source='../assets/gfx/justin.png')]
		public static const PLAYER:Class;
		[Embed(source='../assets/gfx/fall.png')]
		public static const FALL:Class;

		[Embed(source='../assets/gfx/piesel.png')]
		public static const DOG:Class;

		[Embed(source='../assets/gfx/banan.png')]
		public static const BANANA:Class;

		[Embed(source='../assets/gfx/dymek.png')]
		public static const TEXT:Class;

		[Embed(source='../assets/gfx/mama_glowa.png')]
		public static const MOM_HEAD:Class;

		// --- GFX ROOMS ---
		[Embed(source='../assets/gfx/podloga.png')]
		public static const FLOOR:Class;

		[Embed(source='../assets/gfx/pokoj_4.png')]
		public static const ROOM_JUSTIN:Class;

		[Embed(source='../assets/gfx/pokoj_1_back.png')]
		public static const ROOM_1:Class;

		[Embed(source='../assets/gfx/pokoj_2.png')]
		public static const ROOM_2:Class;

		[Embed(source='../assets/gfx/pokoj_3.png')]
		public static const ROOM_3:Class;

		[Embed(source='../assets/gfx/kuchnia.png')]
		public static const KITCHEN:Class;

		[Embed(source='../assets/gfx/drzwi_bok.png')]
		public static const DOOR_SIDE:Class;

		[Embed(source='../assets/gfx/drzwi_otwarte.png')]
		public static const DOOR_OPEN:Class;

		[Embed(source='../assets/gfx/drzwi_cien.png')]
		public static const DOOR_SHADOW:Class;

		[Embed(source='../assets/gfx/drzwi_ukryty.png')]
		public static const DOOR_HIDDEN:Class;

		// --- SOUNDS ----
		[Embed(source='../assets/sounds/door_open.mp3')]
		public static const SFX_DOOR_OPEN:Class;

		[Embed(source='../assets/sounds/whoosh.mp3')]
		public static const SFX_WHOOSH:Class;

		[Embed(source='../assets/sounds/door_open_silent.mp3')]
		public static const SFX_DOOR_OPEN_SILENT:Class;

		[Embed(source='../assets/sounds/ekhm.mp3')]
		public static const SFX_EKHM:Class;

		[Embed(source='../assets/sounds/bark.mp3')]
		public static const SFX_BARK:Class;
	}

}