package pmvc.app.controller.commands 
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import pmvc.app.model.LoadModuleProxy;
	
	/**
	 * 
	 *
	 * @author     ka
	 */
	public class LoadModuleCommand extends SimpleCommand
	{
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		public static const NAME: String = "LoadModuleCommand";
		public static const LOAD:String = "LOAD";

		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		override public function execute(note: INotification) : void
		{
			var loaderProxy:LoadModuleProxy = facade.retrieveProxy(LoadModuleProxy.NAME)as LoadModuleProxy;
			switch(note.getType())
			{
				case LOAD:
					var ar:Array = note.getBody()as Array;
					trace(loaderProxy,ar[0],"sdkufgh",ar[1],"sudg");
					loaderProxy.load(ar[0], ar[1]);
				break;
			}
		}
		
	}
}
