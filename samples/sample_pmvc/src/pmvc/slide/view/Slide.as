//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/03
//
//--------------------------------------------------------------------------
package pmvc.slide.view
{
	import pmvc.slide.SlideFacade;
	import pmvc.slide.view.component.Photo;
	import pmvc.slide.view.mediator.SlideMediator;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(backgroundColor="#000000", frameRate="30", width="997", height="437")]
	public class Slide extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public var photos:Vector.<Photo> = Vector.<Photo>([]);
		private var facade:SlideFacade;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		public function Slide(photos:Vector.<Bitmap>)
		{
			for each(var photo:Bitmap in photos)
			{
				var ph:Photo = new Photo(photo);
				this.photos.push(ph);
			}
			addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}

		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		private function addHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			facade = SlideFacade.getInstance(SlideFacade.KEY);
			facade.registerMediator(new SlideMediator(this));
		}
	}
}

