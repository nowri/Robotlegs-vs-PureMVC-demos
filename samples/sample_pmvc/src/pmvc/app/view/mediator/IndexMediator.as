//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/06/27
//
//--------------------------------------------------------------------------
package pmvc.app.view.mediator 
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import pmvc.app.ApplicationConstants;
	import pmvc.app.ApplicationFacade;
	import pmvc.app.controller.commands.LoadModuleCommand;
	import pmvc.app.model.LoadModuleProxy;
	import pmvc.app.view.Index;
	
	
	public class IndexMediator extends Mediator
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		public static const NAME : String = "IndexMediator";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function IndexMediator(viewComponent : Object = null)
		{
			super(IndexMediator.NAME, viewComponent);
		}

		//--------------------------------------------------------------------------
		//
		//  Accessors
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  view
		//----------------------------------
		protected function get view() : Index
		{
			return viewComponent as Index;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function listNotificationInterests() : Array
		{
			return [
				ApplicationFacade.NOTE_LOAD_MAIN
			];
		}
		
		override public function handleNotification(note : INotification) : void
		{
			switch( note.getName() )
			{
				case ApplicationFacade.NOTE_LOAD_MAIN:
					switch(note.getType())
					{
						case LoadModuleProxy.LOAD_PROGRESS:
						{
							trace(note.getBody());
							break;
						}
							
						case LoadModuleProxy.LOAD_COMPLETE:
						{
							view.loadingEnd();
							break;
						}
					}
				break;
			}
		}
		
		override public function onRegister() : void
		{
			view.initialize();
			sendNotification(ApplicationFacade.EXE_LOAD_MODULE, [ApplicationFacade.NOTE_LOAD_MAIN, [ApplicationConstants.SWF_MAIN]], LoadModuleCommand.LOAD);
		}
	}
}
