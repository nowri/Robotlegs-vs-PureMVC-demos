//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/06/27
//
//--------------------------------------------------------------------------
package robotlegs.app.view.mediator 
{
	import robotlegs.app.ApplicationConstants;
	import robotlegs.app.controller.events.LoadModuleEvent;
	import robotlegs.interfaces.view.component.IIndex;

	import org.robotlegs.mvcs.Mediator;
	

	
	public class IndexMediator extends Mediator
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function IndexMediator()
		{
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		[Inject]
		public var view:IIndex;
		
		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function onRegister() : void
		{
			view.initialize();
			addContextListener(LoadModuleEvent.NOTE_LOAD_COMPLETE, loadModuleEventHandler);
			dispatch(new LoadModuleEvent(LoadModuleEvent.EXE_LOAD, [ApplicationConstants.SWF_MAIN]));
		}

		
		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		private function loadModuleEventHandler(e:LoadModuleEvent):void
		{
			removeContextListener(LoadModuleEvent.NOTE_LOAD_COMPLETE, loadModuleEventHandler);
			view.loadingEnd();
		}
	}
}





