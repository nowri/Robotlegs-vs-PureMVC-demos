package robotlegs.app.controller.commands 
{
	import robotlegs.app.controller.events.MainEvent;
	import org.robotlegs.mvcs.Command;
	import robotlegs.app.model.MainModel;
	
	/**
	 * 
	 *
	 * @author     shake
	 */
	public class MainCommand extends Command
	{
		[Inject]
		public var event : MainEvent;
		[Inject]
		public var model : MainModel;
		
		override public function execute() : void
		{
			switch(event.type)
			{
				case MainEvent.SET_USER_NAME:
				{
					model.userName = event.body as String;
					break;
				}
					
				case MainEvent.SET_ICON:
				{
					model.icon = event.body as String;
					break;
				}
					
				case MainEvent.SET_PHOTO_LIST:
				{
					model.photoList = event.body as Vector.<String>;
					break;
				}

			}
		}
	}
}