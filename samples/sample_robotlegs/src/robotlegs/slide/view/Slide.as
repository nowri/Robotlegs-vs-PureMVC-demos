//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/03
//
//--------------------------------------------------------------------------
package robotlegs.slide.view
{
	import org.robotlegs.utilities.modular.core.IModule;
	import robotlegs.interfaces.view.component.ISlide;
	import robotlegs.slide.SlideContext;

	import org.robotlegs.core.IInjector;


	import flash.display.Sprite;
	import flash.events.Event;


	[SWF(backgroundColor="#000000", frameRate="30", width="997", height="437")]
	public class Slide extends Sprite implements IModule, ISlide
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var context:SlideContext;
		

		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		public function Slide()
		{

			addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		
		/**
		 * We need to initialize our context by setting the parent
		 * injector for the module. This is actually injected by the
		 * shell, so no need to worry about it!
		 */
		[Inject]
		public function set parentInjector(value:IInjector):void
		{
			context = new SlideContext(this, true, value);
		}
		
		public function dispose():void
		{
			
		}

		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		private function addHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			if(!context)
			{
				context = new SlideContext(this);
			}
		}
	}
}

