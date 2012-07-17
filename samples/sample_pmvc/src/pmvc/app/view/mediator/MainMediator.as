//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/02
//
//--------------------------------------------------------------------------
package pmvc.app.view.mediator 
{
	import fl.text.TLFTextField;

	import inn.nowri.ka.external.URLUtils;
	import inn.nowri.ka.utils.VectorUtils;

	import jp.progression.data.getResourceById;

	import pmvc.app.ApplicationConstants;
	import pmvc.app.ApplicationFacade;
	import pmvc.app.controller.commands.LoadModuleCommand;
	import pmvc.app.controller.commands.MainCommand;
	import pmvc.app.model.LoadModuleProxy;
	import pmvc.app.model.MainProxy;
	import pmvc.app.view.Main;
	import pmvc.app.view.mediator.btn.LinkBtnMediator;
	import pmvc.slide.view.Slide;

	import com.adobe.serialization.json.JSONDecoder;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.patterns.observer.Notification;

	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class MainMediator extends Mediator
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		public static const NAME : String = "MainMediator";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function MainMediator(viewComponent : Object = null)
		{
			super(MainMediator.NAME, viewComponent);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var slide:Slide;
		

		//--------------------------------------------------------------------------
		//
		//  Accessors
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  view
		//----------------------------------
		protected function get view() : Main
		{
			return viewComponent as Main;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override public function listNotificationInterests() : Array
		{
			return [
				ApplicationFacade.NOTE_LOAD_IMAGES,
				ApplicationFacade.NOTE_SET_SLIDE_NEXT_TIMER
			];
		}
		
		override public function handleNotification(note : INotification) : void
		{
			switch( note.getName() )
			{
				case ApplicationFacade.NOTE_LOAD_IMAGES:
					switch(note.getType())
					{
						case LoadModuleProxy.LOAD_COMPLETE:
						{
							setImages();
							startSlide();
							break;
						}
					}
					break;
				
				case ApplicationFacade.NOTE_SET_SLIDE_NEXT_TIMER:
					setSlideNextTimer();
					break;
			}
		}
		
		override public function onRegister() : void
		{
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
			sendNotification(ApplicationFacade.EXE_MAIN, userName, MainCommand.SET_USER_NAME);
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
			var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
			var url:String = ApplicationConstants.API_URL.replace("{base-hostname}", proxy.userName+".tumblr.com");
			url = url.replace("{key}", ApplicationConstants.TUMBLR_CONSUMER_KEY);
			url = url.replace("[optional-params=]", "&type=photo");
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, urlLoaderHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoaderHandler);
		}
		
		private function setLabelView(description:String):void
		{
			var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
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
			view.stage.addChild(tlf);
			tlf = new TLFTextField();
			tlf.htmlText = proxy.userName+".tumblr.com";
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
			tlf.y = view.stage.stageHeight-tlf.height;
			view.stage.addChild(tlf);
			view.stage.addEventListener(Event.RESIZE, function():void{
				tlf.y = view.stage.stageHeight-tlf.height;
			});
		}
		
		private function loadImages():void
		{
			var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
			sendNotification(ApplicationFacade.EXE_LOAD_MODULE,
				[ApplicationFacade.NOTE_LOAD_IMAGES, [proxy.icon].concat(VectorUtils.toArray(proxy.photoList))], 
				LoadModuleCommand.LOAD
			);
		}
		
		private function setMouseListener():void
		{
			var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
			for (var i:int=1; i<=3; i++) 
			{
				var txt:TLFTextField = view.vc["link"+i];
				var user:String = ApplicationConstants.USER_NAMES[int(Math.random()*ApplicationConstants.USER_NAMES.length)];
				var url:String = user+".tumblr.com";
				txt.text = url;
				url="./?user="+user;
				facade.registerMediator(new LinkBtnMediator(user+"Med", txt, url));
			}
			var userLink:String = "http://"+proxy.userName+".tumblr.com";
			facade.registerMediator(new LinkBtnMediator(view.vc.title.name+"Med1", view.vc.title, userLink));
			facade.registerMediator(new LinkBtnMediator(view.vc.user.name+"Med2", view.vc.user, userLink));
			facade.registerMediator(new LinkBtnMediator(view.vc.photo.name+"Med3", view.vc.photo, userLink));
		}
		
		private function setImages():void
		{
			var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
			var bmp:Bitmap = getResourceById(proxy.icon).toLoader().content as Bitmap;
			var photos:Vector.<String> = proxy.photoList;
			view.vc.photo.addChild(bmp);
			var vec:Vector.<Bitmap> = Vector.<Bitmap>([]);
			for each(var str:String in photos)
			{
				vec.push(getResourceById(str).toLoader().content as Bitmap);
			}
			slide = new Slide(vec);
			slide.y = 132;
			view.vc.addChildAt(slide, view.vc.getChildIndex(view.vc.lines));
		}
		
		private function startSlide():void
		{
			sendNotification(ApplicationFacade.EXE_BROAD_CAST, new Notification("NOTE_UPDATE"));
		}
		
		private function setSlideNextTimer():void
		{
			var timer:Timer = new Timer(5000, 1);
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void
			{
				sendNotification(ApplicationFacade.EXE_BROAD_CAST, new Notification("NOTE_UPDATE"));
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
					var proxy:MainProxy = facade.retrieveProxy(MainProxy.NAME)as MainProxy;
					sendNotification(ApplicationFacade.EXE_MAIN, photoList, MainCommand.SET_PHOTO_LIST);
					sendNotification(ApplicationFacade.EXE_MAIN, ApplicationConstants.API_AVATAR.replace("{base-hostname}", proxy.userName+".tumblr.com"), MainCommand.SET_ICON);
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
	}
}



