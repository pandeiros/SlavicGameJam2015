package
{
	import net.flashpunk.utils.*;
	import net.flashpunk.*;
	/**
	 * ...
	 * @author daltostronic
	 */
	public class PhysRect extends PhysicalEntity
	{
		public var color:uint = 0xFFFFFF;
		public function PhysRect(x:Number=0, y:Number=0, width:Number=0, height:Number=0)
		{
			super(x, y);
			this.width = width;
			this.height = height;

			type = "solid";
		}

		override public function render():void
		{
			Draw.rect(x, y, width, height, color);
		}

	}

}