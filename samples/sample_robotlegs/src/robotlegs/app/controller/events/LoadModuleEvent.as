package robotlegs.app.controller.events
{
	import robotlegs.abstract.controller.events.AbstractEvent;
	import flash.events.Event;

	public class LoadModuleEvent extends AbstractEvent
	{
		// command
		public static const EXE_LOAD : String = "EXE_LOAD";
		// notification
		public static const NOTE_LOAD_COMPLETE : String = "NOTE_LOAD_COMPLETE";
		public static const NOTE_LOAD_PROGRESS:String="NOTE_LOAD_PROGRESS";


		public function LoadModuleEvent(type : String, body : * = null)
		{
			super(type, body);
		}

		override public function clone() : Event
		{
			return new LoadModuleEvent(type, _body);
		}
	}
}