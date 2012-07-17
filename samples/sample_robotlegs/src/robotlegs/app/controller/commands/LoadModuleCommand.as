package robotlegs.app.controller.commands 
{
	import robotlegs.app.controller.events.LoadModuleEvent;
	import robotlegs.interfaces.model.ILoadModuleService;

	import org.robotlegs.mvcs.Command;
	

	public class LoadModuleCommand extends Command
	{
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		[Inject]
		public var event : LoadModuleEvent;
		[Inject]
		public var service : ILoadModuleService;

		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		override public function execute() : void
		{
			switch(event.type)
			{
				case LoadModuleEvent.EXE_LOAD:
					service.load(event.body as Array);
					break;
			}
		}
		
	}
}
