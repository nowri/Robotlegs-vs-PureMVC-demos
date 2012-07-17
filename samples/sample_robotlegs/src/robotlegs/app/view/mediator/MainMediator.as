//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/02
//
//--------------------------------------------------------------------------
package robotlegs.app.view.mediator 
{
	import avmplus.getQualifiedClassName;

	import fl.text.TLFTextField;

	import inn.nowri.ka.external.URLUtils;
	import inn.nowri.ka.utils.VectorUtils;

	import jp.progression.data.getResourceById;

	import robotlegs.app.ApplicationConstants;
	import robotlegs.app.controller.events.LoadModuleEvent;
	import robotlegs.app.controller.events.MainEvent;
	import robotlegs.app.model.MainModel;
	import robotlegs.app.view.mediator.btn.LinkBtnMediator;
	import robotlegs.interfaces.view.component.IMain;
	import robotlegs.slide.controller.events.SlideEvent;
	import robotlegs.slide.view.Slide;

	import com.adobe.serialization.json.JSONDecoder;

	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;


	public class MainMediator extends ModuleMediator
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function MainMediator()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		[Inject]
		public var view:IMain;
		private var slide:Slide;

		[Inject]
		public var model:MainModel;
		

		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function onRegister() : void
		{
			// module
			eventMap.mapListener(moduleDispatcher, SlideEvent.UPDATE, slideEventHandler);
			var userName:String;
			var query:Object = URLUtils.getURLQueryObj();
			if(query&& query["user"])
			{
				userName = query["user"];
			}
			else
			{
				userName = ApplicationConstants.USER_NAMES[int(Math.random()*ApplicationConstants.USER_NAMES.length)];
			}
			dispatch(new MainEvent(MainEvent.SET_USER_NAME, userName));
			view.initialize();
			loadAPI();
		}

		
		
		override public function onRemove() : void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  Internal methods
		//----------------------------------
		private function loadAPI():void
		{
			var url:String = ApplicationConstants.API_URL.replace("{base-hostname}", model.userName+".tumblr.com");
			url = url.replace("{key}", ApplicationConstants.TUMBLR_CONSUMER_KEY);
			url = url.replace("[optional-params=]", "&type=photo");
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, urlLoaderHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoaderHandler);
		}
		private function setLabelView(description:String):void
		{
			var tlf:TLFTextField = new TLFTextField();
			tlf.htmlText = description;
			var tf:TextFormat = tlf.defaultTextFormat;
			tf.font = "_serif";
			tf.italic = true;
			tf.letterSpacing = 0;
			tf.leading = 5;
			tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.textColor = 0xffffff;
			tlf.x = 23;
			tlf.y = 250;
			tlf.textFlow.fontSize = 28;
			tlf.width=700;
			tlf.background = true;
			tlf.backgroundColor = 0x000000;
			tlf.setTextFormat(tf);
			var _view:DisplayObjectContainer = view as DisplayObjectContainer;
			_view.stage.addChild(tlf);
			tlf = new TLFTextField();
			tlf.htmlText = model.userName+".tumblr.com";
			tf = tlf.defaultTextFormat;
			tf.font = "_typewriter";
			tf.letterSpacing = 4;
			tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.textColor = 0xffffff;
			tlf.textFlow.fontSize = 10;
			tlf.width=700;
			tlf.background = true;
			tlf.backgroundColor = 0x21221B;
			tlf.setTextFormat(tf);
			tlf.x = 955-tlf.textWidth;
			tlf.y = _view.stage.stageHeight-tlf.height;
			_view.stage.addChild(tlf);
			_view.stage.addEventListener(Event.RESIZE, function():void{
				tlf.y = _view.stage.stageHeight-tlf.height;
			});
		}
		
		private function loadImages():void
		{
			addContextListener(LoadModuleEvent.NOTE_LOAD_COMPLETE, loadModuleEventHandler);
			dispatch(new LoadModuleEvent(LoadModuleEvent.EXE_LOAD, [model.icon].concat(VectorUtils.toArray(model.photoList))));
		}

		private function setMouseListener():void
		{
			mediatorMap.mapView(TLFTextField, LinkBtnMediator, Sprite, false);
			for (var i:int=1; i<=3; i++) 
			{
				var txt:TLFTextField = view.vc["link"+i];
				var user:String = ApplicationConstants.USER_NAMES[int(Math.random()*ApplicationConstants.USER_NAMES.length)];
				var url:String = user+".tumblr.com";
				txt.text = url;
				url="./?user="+user;
				mediatorMap.createMediator(txt);
			}
			mediatorMap.createMediator(view.vc.title);
			mediatorMap.createMediator(view.vc.user);
			mediatorMap.mapView(getQualifiedClassName(view.vc.photo), LinkBtnMediator, Sprite);
			mediatorMap.createMediator(view.vc.photo);
		}
		
		private function setImages():void
		{
			var bmp:Bitmap = getResourceById(model.icon).toLoader().content as Bitmap;
			view.vc.photo.addChild(bmp);
			slide = new Slide();
			slide.y = 132;
			view.vc.addChildAt(slide, view.vc.getChildIndex(view.vc.lines));
		}
		private function startSlide():void
		{
			dispatchToModules(new SlideEvent(SlideEvent.UPDATE));
		}
		
		private function setSlideNextTimer():void
		{
			var timer:Timer = new Timer(5000, 1);
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void
			{
				dispatchToModules(new SlideEvent(SlideEvent.UPDATE));
			});
			timer.start();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		protected function urlLoaderHandler(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			switch(e.type)
			{
				case Event.COMPLETE:
				{
					loader.removeEventListener(Event.COMPLETE, urlLoaderHandler);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoaderHandler);
					var jsonObj:Object = new JSONDecoder( loader.data, true ).getValue();
					var title:String = jsonObj.response.blog.title;
					var _name:String = jsonObj.response.blog.name;
					var description:String = jsonObj.response.blog.description;
					
					view.vc.title.text = title
					view.vc.user.text = _name;
					view.vc.slash.x = view.vc.title.x+view.vc.title.textWidth+10;
					view.vc.user.x = view.vc.slash.x+view.vc.slash.width;
					
					var posts:Array = jsonObj.response.posts;
					var photoList:Vector.<String>=Vector.<String>([]);
					for (var i:int=0; i<posts.length; i++)
					{
						photoList.push(posts[i].photos[0].alt_sizes[0].url);
					}
					dispatch(new MainEvent(MainEvent.SET_PHOTO_LIST, photoList));
					dispatch(new MainEvent(MainEvent.SET_ICON, ApplicationConstants.API_AVATAR.replace("{base-hostname}", model.userName+".tumblr.com")));
					setLabelView(description);
					setMouseListener();
					loadImages();
					break;
				}
				
				case IOErrorEvent.IO_ERROR:
				{
					trace(e);
					break;
				}
				
				case HTTPStatusEvent.HTTP_STATUS:
				{
					loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoaderHandler);
					break;
				}
			}
		}
		
		private function loadModuleEventHandler(e:LoadModuleEvent):void
		{
			switch(e.type)
			{
				case LoadModuleEvent.NOTE_LOAD_COMPLETE:
					removeContextListener(LoadModuleEvent.NOTE_LOAD_COMPLETE, loadModuleEventHandler);
					setImages();
					startSlide();
					break;
			}
		}
		
		private function slideEventHandler(e:SlideEvent):void
		{
			setSlideNextTimer();
		}
	}
}



