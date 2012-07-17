package pmvc.app.controller.commands 
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import pmvc.app.model.MainProxy;
	
	
	/**
	 * 
	 *
	 * @author     shake
	 */
	public class MainCommand extends SimpleCommand implements ICommand
	{
		public static const NAME: String = "MainCommand";
		
		public static const SET_USER_NAME:String = "SET_USER_NAME";
		public static const SET_ICON:String = "SET_ICON";
		public static const SET_PHOTO_LIST:String = "SET_PHOTO_LIST";
		
		
		override public function execute(note: INotification) : void
		{
			var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
			switch(note.getType())
			{
				case SET_USER_NAME:
				{
					proxy.userName = note.getBody()as String;
					break;
				}
					
				case SET_ICON:
				{
					proxy.icon = note.getBody()as String;
					break;
				}
					
				case SET_PHOTO_LIST:
				{
					proxy.photoList = note.getBody()as Vector.<String>;
					break;
				}
			}
		}
	}
}