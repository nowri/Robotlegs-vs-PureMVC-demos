package pmvc.slide
{
	import pmvc.slide.controller.commands.NoteAppFacadeCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class SlideFacade extends Facade implements IFacade
	{
		public static const KEY:String="SlideFacade";
		
		//command
		public static const EXE_APP_FACADE:String="EXE_APP_FACADE";
		
		//notification
		public static const NOTE_UPDATE:String="NOTE_UPDATE";
		
		
		public function SlideFacade( key : String )
		{
			super(key);
		}
		
		public static function getInstance(key:String) : SlideFacade 
		{
			if(instanceMap[key]==null)
			{
				instanceMap[key] = new SlideFacade(key);
			}
			return instanceMap[key] as SlideFacade;
		}
		
		override protected function initializeController() : void
		{
			super.initializeController();
			registerCommand(EXE_APP_FACADE, NoteAppFacadeCommand);
		}
	}
}
