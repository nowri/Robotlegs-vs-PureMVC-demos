package robotlegs.slide.controller.events
{
	import robotlegs.abstract.controller.events.AbstractEvent;
	import flash.events.Event;

	public class SlideEvent extends AbstractEvent
	{
		// command
		public static const UPDATE : String = "UPDATE";

		public function SlideEvent(type : String, body : * = null)
		{
			super(type, body);
		}

		override public function clone() : Event
		{
			return new SlideEvent(type, _body);
		}
	}
}
