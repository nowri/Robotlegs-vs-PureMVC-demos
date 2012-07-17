package robotlegs.slide.controller.events
{
	import robotlegs.abstract.controller.events.AbstractEvent;
	import flash.events.Event;

	public class NoteAppFacadeEvent extends AbstractEvent
	{
		// command
		public static const NOTE : String = "NOTE";



		public function NoteAppFacadeEvent(type : String, body : * = null)
		{
			super(type, body);
		}

		override public function clone() : Event
		{
			return new NoteAppFacadeEvent(type, _body);
		}
	}
}
