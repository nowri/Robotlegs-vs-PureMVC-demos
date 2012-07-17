package pmvc.app.controller.commands 
{
	import pmvc.app.ApplicationFacade;
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	

	public class BroadCastCommand extends SimpleCommand implements ICommand
	{
		public static const NAME: String = "BroadCastCommand";
		
		override public function execute(note: INotification) : void
		{
			 var appFacade:ApplicationFacade=ApplicationFacade.getInstance(ApplicationFacade.KEY);
			 appFacade.broadcast(note.getBody());
		}
	}
}