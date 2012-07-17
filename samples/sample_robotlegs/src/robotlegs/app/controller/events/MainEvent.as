//--------------------------------------------------------------------------
//	
//	
//  @author : noeri.ka
//  @date : 2012/07/05
//
//--------------------------------------------------------------------------

package robotlegs.app.controller.events
{
	import robotlegs.abstract.controller.events.AbstractEvent;
	import flash.events.Event;


	public class MainEvent extends AbstractEvent
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		//command
		//main command
		public static const SET_USER_NAME:String = "SET_USER_NAME";
		public static const SET_ICON:String = "SET_ICON";
		public static const SET_PHOTO_LIST:String = "SET_PHOTO_LIST";
		
		//notification
		public static const NOTE_SET_SLIDE_NEXT_TIMER:String="NOTE_SET_SLIDE_NEXT_TIMER";
		
		
		

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function MainEvent(type : String, body : * = null)
		{
			super(type, body);
		}
		

		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function clone() : Event
		{
			return new MainEvent(type, _body);
		}

		
	}
}




