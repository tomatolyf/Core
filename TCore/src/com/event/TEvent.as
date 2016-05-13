package com.event
{
	import flash.events.Event;
	
	public class TEvent extends Event
	{
		private var _data : *;
		
		public function TEvent(type:String,data : *, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get Data():*
		{
			return _data;
		}
	}
}