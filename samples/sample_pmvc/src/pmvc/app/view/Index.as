//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/06/27
//
//--------------------------------------------------------------------------

package pmvc.app.view
{
	import caurina.transitions.Tweener;

	import jp.progression.data.getResourceById;

	import pmvc.app.ApplicationConstants;
	import pmvc.app.ApplicationFacade;
	import pmvc.app.view.mediator.IndexMediator;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(backgroundColor="#000000", frameRate="30", width="997", height="437")]
	public class Index extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function Index()
		{

			addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var facade:ApplicationFacade;
		private var vc:IndexVC = new IndexVC();
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  From mediator
		//----------------------------------
		public function initialize():void
		{
			addChild(vc);
		}
		
		public function loadingEnd():void
		{
			Tweener.addTween(vc, {alpha:0, time:0.2, transition:"easeInSine", onComplete:function():void
			{
				removeChild(vc);
				addChild(getResourceById(ApplicationConstants.SWF_MAIN).toLoader().content);
			}});
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handler
		//
		//--------------------------------------------------------------------------
		private function addHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			facade = ApplicationFacade.getInstance(ApplicationFacade.KEY);
			facade.registerMediator(new IndexMediator(this));
		}
	}
}
