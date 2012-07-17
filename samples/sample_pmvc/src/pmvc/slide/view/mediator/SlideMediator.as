//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/03
//
//--------------------------------------------------------------------------

package pmvc.slide.view.mediator 
{
	import flash.events.Event;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	import org.libspark.betweenas3.tweens.ITween;
	import org.libspark.betweenas3.easing.Quadratic;
	import org.libspark.betweenas3.BetweenAS3;
	import pmvc.slide.view.component.Photo;
	import pmvc.slide.SlideFacade;
	import pmvc.slide.view.Slide;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class SlideMediator extends Mediator
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		public static const NAME : String = "SlideMediator";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function SlideMediator(viewComponent : Object = null)
		{
			super(SlideMediator.NAME, viewComponent);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var current:int = -1;
		
		
		//--------------------------------------------------------------------------
		//
		//  Accessors
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  view
		//----------------------------------
		protected function get view():Slide
		{
			return viewComponent as Slide;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function listNotificationInterests():Array
		{
			return [
				SlideFacade.NOTE_UPDATE
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch(note.getName())
			{
				case SlideFacade.NOTE_UPDATE:
					update();
					break;
			}
		}
		
		override public function onRegister() : void
		{
			setResize();
		}

		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		private function update():void
		{
			var targ:Photo;
			if(current!=view.photos.length-1)
			{
				++current;
			}
			else
			{
				current=0;
			}
			targ = view.photos[current];
			targ.maskParam = 0;
			view.addChild(targ);
			resizeHandler();
			var tw:ITween = BetweenAS3.to(targ, {maskParam:1}, 1, Quadratic.easeOut);
			tw.onComplete = function(targ:Photo):void
			{
				var vec:Vector.<Photo> = view.photos.concat();
				var ph:Photo;
				while(vec.length)
				{
					ph = vec.shift();
					if(ph.parent&& ph!=targ)
					{
						ph.parent.removeChild(ph);
					}
				}
				sendNotification(SlideFacade.EXE_APP_FACADE, new Notification("NOTE_SET_SLIDE_NEXT_TIMER"));
			};
			tw.onCompleteParams = [targ];
			tw.play();
		}
		
		private function setResize():void
		{
			view.stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		private function resizeHandler(e:Event=null):void
		{
			for each (var photo:Photo in view.photos) 
			{
				if(photo.parent)
				{
					photo.width = int(view.stage.stageWidth)*1.1;
					photo.scaleY = photo.scaleX;
				}
			}
		}
	}
}

