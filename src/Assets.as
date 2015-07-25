package
{
	/**
	 * ...
	 * @author daltostronic
	 */
	public class Assets
	{
		// --- GFX ---
		[Embed(source='../assets/gfx/justin.png')]
		public static const PLAYER:Class;
		
		[Embed(source='../assets/gfx/podloga.png')]
		public static const FLOOR:Class;
		
		[Embed(source='../assets/gfx/pokoj_1.png')]
		public static const ROOM_JUSTIN:Class;
		
		[Embed(source='../assets/gfx/pokoj_1_back.png')]
		public static const ROOM_1:Class;
		
		[Embed(source='../assets/gfx/pokoj_2.png')]
		public static const ROOM_2:Class;
		
		[Embed(source='../assets/gfx/pokoj_3.png')]
		public static const ROOM_3:Class;
		
		[Embed(source='../assets/gfx/drzwi_bok.png')]
		public static const DOOR_SIDE:Class;
		
		[Embed(source='../assets/gfx/drzwi_otwarte.png')]
		public static const DOOR_OPEN:Class;
		
		[Embed(source='../assets/gfx/drzwi_cien.png')]
		public static const DOOR_SHADOW:Class;
		
		[Embed(source='../assets/gfx/drzwi_ukryty.png')]
		public static const DOOR_HIDDEN:Class;
		
		// --- SOUNDS ----
		[Embed(source = '../assets/sounds/door_open.mp3')]
		public static const SFX_DOOR_OPEN:Class;
		
		[Embed(source = '../assets/sounds/whoosh.mp3')]
		public static const SFX_WHOOSH:Class;


	}

}