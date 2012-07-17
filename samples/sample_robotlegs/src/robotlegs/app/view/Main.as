//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/02
//
//--------------------------------------------------------------------------
package robotlegs.app.view
{
	import robotlegs.app.ApplicationConstants;
	import robotlegs.app.ApplicationContext;
	import robotlegs.app.view.component.AbstractMainVC;
	import robotlegs.interfaces.view.component.IMain;

	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;
	
	[SWF(backgroundColor="#000000", frameRate="30", width="997", height="437")]
	public class Main extends Sprite implements IMain
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _vc:AbstractMainVC = new MainVC();
		private var lineDot:BitmapData = new LineDot(0,0);
		private var bg:Graphics;
		private var context:ApplicationContext;
		
		//--------------------------------------------------------------------------
		//
		//  Accessors(a-z, getter -> setter)
		//
		//--------------------------------------------------------------------------
		public function get vc():AbstractMainVC
		{
			return _vc;
		}
				
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public function initialize():void
		{
			Security.loadPolicyFile(ApplicationConstants.TUMBLR_CROSS_DOMAIN);
			var sha:Shape = new Shape();
			bg = sha.graphics;
			addChild(sha);
			addChild(vc);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setResizeListener();
		}
		
		private function setResizeListener():void
		{
			var dio:DisplayObjectContainer;
			for(var i:int=0; i<vc.lines.numChildren; i++)
			{
				dio = vc.lines.getChildAt(i)as DisplayObjectContainer;
				while(dio.numChildren)
				{
					dio.removeChild(dio.getChildAt(0));
				}
				var sh:Shape = new Shape();
				dio.addChild(sh);
			}
			resizeHandler();
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handler
		//
		//--------------------------------------------------------------------------
		private function addHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			if(parent is Stage)
			{
				context = new ApplicationContext(this);
			}
		}
		
		protected function resizeHandler(e:Event=null):void
		{
			bg.clear();
			bg.beginFill(0x000000);
			bg.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			for(var i:int = 0; i<vc.lines.numChildren; i++) 
			{
				var sh:Shape = (vc.lines.getChildAt(i)as DisplayObjectContainer).getChildAt(0)as Shape;
				var g:Graphics = sh.graphics;
				g.clear();
				g.beginBitmapFill(lineDot);
				g.drawRect(0, 0, 1, stage.stageHeight);
				g.endFill();
			}
			vc.photo.x = stage.stageWidth-38-vc.photo.width;
			vc.linkBg.width=stage.stageWidth;
		}
	}
}


