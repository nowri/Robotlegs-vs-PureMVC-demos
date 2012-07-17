package pmvc.abstract.view.btn
{

	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.puremvc.as3.multicore.interfaces.INotification;


	//=================================================================================================================================================
	//
	//=================================================================================================================================================
	public class BaseBtnMediator extends Mediator implements IMediator
	{
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		public static const NAME:String = "BaseButtonMediator";
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		protected var transition:String = "easeOutExpo";
		
		protected var _dynamicOnClick:Function;
		protected var _dynamicOnRollOver:Function;
		protected var _dynamicOnRollOut:Function;
		private var isRollOverAnime : Boolean;
		
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		/**
		 * constructor
		 * 
		 */
		public function BaseBtnMediator(name:String, viewComponent:Object) 
		{
			super(name, viewComponent);
			try{
				if (view["ov"])
				{
					setRollOverImage();
				};
				if (view["hit"] is Sprite)
				{
					setHitArea();
				};
			}catch(e:Error){};
			
			view.buttonMode=true;
		}
		
		override public function onRegister():void {
			view.addEventListener(MouseEvent.CLICK, onClick);
			view.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			view.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			view.addEventListener(Event.REMOVED_FROM_STAGE, removeFunc);
		}
		private function removeFunc(event : Event) : void 
		{
			view.removeEventListener(Event.REMOVED_FROM_STAGE, removeFunc);
			facade.removeMediator(mediatorName);
		}
		
		override public function onRemove():void 
		{
			view.removeEventListener(MouseEvent.CLICK, onClick);
			view.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			view.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			if(view.hasEventListener(Event.REMOVED_FROM_STAGE))view.removeEventListener(Event.REMOVED_FROM_STAGE, removeFunc);
			_dynamicOnClick=_dynamicOnRollOver=_dynamicOnRollOut=null;
		}
		
		
		/**
		 * 
		 */
		override public function listNotificationInterests():Array {
			return [];
		}
		
		/**
		 * 
		 */
		override public function handleNotification(notification:INotification):void {
			switch (notification.getName()) {
				
			}
		}
		
		// getter setter
		public function set dynamicOnClick(dynamicOnClick : Function) : void{_dynamicOnClick=dynamicOnClick;}
		public function set dynamicOnRollOver(dynamicOnRollOver:Function):void {_dynamicOnRollOver=dynamicOnRollOver;}
		public function set dynamicOnRollOut(dynamicOnRollOut : Function):void{_dynamicOnRollOut=dynamicOnRollOut;}
		
	
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		protected function onRollOut(event : MouseEvent) : void
		{
			if(!view.mouseEnabled)
			{
				return;
			}
			if(isRollOverAnime){animeRollOutImage();};
			try{_dynamicOnRollOut();}catch(e:Error){};
		}
		
		/**
		 * 
		 */
		protected function onClick(event:MouseEvent):void {
		
//			if(clickSoundID)sendNotification(ApplicationConstants.EXE_SOUND, clickSoundID, SoundCommand.PLAY);
			try{_dynamicOnClick();}catch(e:Error){};
			event.stopPropagation();
		}
		

		protected function onRollOver(event:MouseEvent):void {
//			if(rollOverSoundID)sendNotification(ApplicationConstants.EXE_SOUND, rollOverSoundID, SoundCommand.PLAY);	
			
			if(isRollOverAnime){animeRollOverImage();};
			
			try{_dynamicOnRollOver();}catch(e:Error){};
		}
		
		
		private function setRollOverImage() : void
		{
			view["ov"].alpha = 0;
			isRollOverAnime = true;
		}
		
		private function setHitArea() : void
		{
			view.hitArea = view["hit"];
			view.mouseChildren=false;
		}
		
		private function animeRollOverImage() : void
		{
			Tweener.addTween(view["ov"], {alpha:1, time:0, transition:transition});
		}
		
		private function animeRollOutImage() : void
		{
			Tweener.addTween(view["ov"], {alpha:0, time:0.4, transition:transition});
		}
		
		protected function get view():Sprite { return viewComponent as Sprite; }


	}

}