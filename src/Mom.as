package 
{
	import net.flashpunk.Entity;
	import punk.fx.graphics.*;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Mom extends Entity 
	{
		private var spriteMom:FXSpritemap = new FXSpritemap(Assets.MOM, 12, 24);
		
		public function Mom() 
		{
			
			spriteMom.add("IDLE", [2, 3], 4, true);
			graphic = spriteMom;
			spriteMom.play("IDLE");
			(graphic as Image).scale = GameWorld.globalScale;
			
			x = (142 + 3) * GameWorld.globalScale * 5 - 170;
			y = FP.height - 24 * GameWorld.globalScale;
		}
		
	}

}