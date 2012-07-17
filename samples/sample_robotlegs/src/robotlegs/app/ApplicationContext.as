package robotlegs.app
{
	import robotlegs.app.controller.commands.LoadModuleCommand;
	import robotlegs.app.controller.commands.MainCommand;
	import robotlegs.app.controller.events.LoadModuleEvent;
	import robotlegs.app.controller.events.MainEvent;
	import robotlegs.app.model.LoadModuleService;
	import robotlegs.app.model.MainModel;
	import robotlegs.app.view.mediator.IndexMediator;
	import robotlegs.app.view.mediator.MainMediator;
	import robotlegs.interfaces.model.ILoadModuleService;
	import robotlegs.interfaces.view.component.IIndex;
	import robotlegs.interfaces.view.component.IMain;
	import robotlegs.interfaces.view.component.ISlide;

	import org.robotlegs.base.ViewInterfaceMediatorMap;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;

	import flash.display.DisplayObjectContainer;

	public class ApplicationContext extends ModuleContext
	{
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup() : void
		{
			//module
			viewMap.mapType(ISlide);
			
			// command
			commandMap.mapEvent(LoadModuleEvent.EXE_LOAD, LoadModuleCommand);
			commandMap.mapEvent(MainEvent.SET_ICON, MainCommand);
			commandMap.mapEvent(MainEvent.SET_PHOTO_LIST, MainCommand);
			commandMap.mapEvent(MainEvent.SET_USER_NAME, MainCommand);
			
			// model
			injector.mapSingletonOf(ILoadModuleService, LoadModuleService);
			injector.mapSingleton(MainModel);
			
			// view
			mediatorMap.mapView(IIndex, IndexMediator);
			mediatorMap.mapView(IMain, MainMediator);
		}
		
		//
	    // Override the default mediator map with one that can map to interfaces
	    //
	    override protected function get mediatorMap():IMediatorMap
	    {
	        return _mediatorMap ||= new ViewInterfaceMediatorMap(contextView, createChildInjector(), reflector);
	    }
	}
}
