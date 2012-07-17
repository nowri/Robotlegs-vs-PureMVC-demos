package robotlegs.slide
{
	import robotlegs.interfaces.view.component.ISlide;
	import robotlegs.slide.view.Slide;
	import robotlegs.slide.view.mediator.SlideMediator;

	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;

	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;

	/**
	 * @author nowri.ka
	 */
	public class SlideContext extends ModuleContext
	{
		public function SlideContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true, parentInjector:IInjector=null, applicationDomain:ApplicationDomain=null)
		{
			super(contextView, autoStartup, parentInjector, applicationDomain);
		}
		
		override public function startup():void
		{
			// view
			mediatorMap.mapView(Slide, SlideMediator, ISlide);
		}
	}
}
