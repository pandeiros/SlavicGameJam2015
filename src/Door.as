package 
{
	import net.flashpunk.*;
	import punk.fx.graphics.*;
	import net.flashpunk.graphics.*;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author The team with a guy with a beard.
	 */
	public class Door extends Entity
	{
		public var isHidden:Boolean = false;
		public var isHidingEnabled:Boolean = false;
		
		public function Door(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			
			graphic = new FXSpritemap(Assets.DOOR_SHADOW);	
			
			centerOrigin();
			width = 10 * GameWorld.globalScale;
			height = 27 * GameWorld.globalScale;
			setHitbox(1 * GameWorld.globalScale, 27 * GameWorld.globalScale,
				-7 * GameWorld.globalScale, 0);
			(graphic as Image).scale = GameWorld.globalScale;
			type = "door_shadow";
			visible = false;
		}
		
		override public function update():void
		{
			super.update();
			
			//if (isHidingEnabled)
				// TODO DALTON: Enable glow effect or sth

		}
		
		public function hide(hiding:Boolean):void
		{
			isHidden = hiding;
			if (hiding == true)
			{
				graphic = new FXSpritemap(Assets.DOOR_HIDDEN);
			}
			else
			{
				graphic = new FXSpritemap(Assets.DOOR_SHADOW);
			}
			
			(graphic as Image).scale = GameWorld.globalScale;
		}
		
	}

}