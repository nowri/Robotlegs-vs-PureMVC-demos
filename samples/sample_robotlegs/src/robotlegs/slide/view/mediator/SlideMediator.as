//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/03
//
//--------------------------------------------------------------------------

package robotlegs.slide.view.mediator 
{
	import jp.progression.data.getResourceById;

	import robotlegs.app.controller.events.MainEvent;
	import robotlegs.app.model.MainModel;
	import robotlegs.interfaces.view.component.ISlide;
	import robotlegs.slide.controller.events.NoteAppFacadeEvent;
	import robotlegs.slide.controller.events.SlideEvent;
	import robotlegs.slide.view.component.Photo;

	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Quadratic;
	import org.libspark.betweenas3.tweens.ITween;
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class SlideMediator extends ModuleMediator
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function SlideMediator()
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		[Inject]
		public var view:ISlide;
		[Inject]
		public var model:MainModel;
		private var current:int = -1;
		private var photos:Vector.<Photo> = Vector.<Photo>([]);
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Accessors
		//
		//--------------------------------------------------------------------------
		public function get _view():DisplayObjectContainer
		{
			return view as DisplayObjectContainer;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function onRegister() : void
		{
			var _photos:Vector.<String> = model.photoList;
			for each(var str:String in _photos)
			{
				var ph:Photo = new Photo(getResourceById(str).toLoader().content as Bitmap);
				photos.push(ph);
			}
			
			addModuleListener(SlideEvent.UPDATE, update);
			setResize();
		}

		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		private function setResize():void
		{
			eventMap.mapListener(_view.stage, Event.RESIZE, resizeHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		private function resizeHandler(e:Event=null):void
		{
			for each (var photo:Photo in photos) 
			{
				if(photo.parent)
				{
					photo.width = int(_view.stage.stageWidth)*1.1;
					photo.scaleY = photo.scaleX;
				}
			}
		}
		
		private function update(e:SlideEvent):void
		{
			var targ:Photo;
			if(current!=photos.length-1)
			{
				++current;
			}
			else
			{
				current=0;
			}
			targ = photos[current];
			targ.maskParam = 0;
			_view.addChild(targ);
			resizeHandler();
			var tw:ITween = BetweenAS3.to(targ, {maskParam:1}, 1, Quadratic.easeOut);
			tw.onComplete = function(targ:Photo):void
			{
				var vec:Vector.<Photo> = photos.concat();
				var ph:Photo;
				while(vec.length)
				{
					ph = vec.shift();
					if(ph.parent&& ph!=targ)
					{
						ph.parent.removeChild(ph);
					}
				}
				
				dispatchToModules(new NoteAppFacadeEvent(NoteAppFacadeEvent.NOTE, new MainEvent(MainEvent.NOTE_SET_SLIDE_NEXT_TIMER)));
			};
			tw.onCompleteParams = [targ];
			tw.play();
		}
	}
}

