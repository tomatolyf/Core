package com.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class DisplayObjectUtil
	{
		public function DisplayObjectUtil()
		{
		}
		
		public static function removeAllChild(mc : DisplayObjectContainer):void
		{
			if(mc == null)
			{
				return;
			}
			for(var i:int=0;i<mc.numChildren;i++)
			{
				mc.removeChildAt(0);
			}
		}
		
		public static function removeFromParent(mc : DisplayObject):void
		{
			if(mc == null || mc.parent == null)
			{
				return;
			}
			mc.parent.removeChild(mc);
		}
		
		
	}
}