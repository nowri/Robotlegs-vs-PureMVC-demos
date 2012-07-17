package pmvc.slide.controller.commands 
{
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	

	public class NoteAppFacadeCommand extends SimpleCommand implements ICommand
	{
		public static const NAME: String = "NoteAppFacadeCommand";
		
		override public function execute(note: INotification) : void
		{
			if(Facade.hasCore("ApplicationFacade"))
			{
				var _note:INotification = note.getBody()as INotification;
				Facade.getInstance("ApplicationFacade").sendNotification(_note.getName(), _note.getBody(), _note.getType());
			}
		}
	}
}