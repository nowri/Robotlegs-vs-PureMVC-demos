package robotlegs.abstract.view.btn
{
	import fl.text.TLFTextField;

	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.core.easing.IEasing;
	import org.libspark.betweenas3.easing.Expo;
	import org.libspark.betweenas3.easing.Sine;
	import org.libspark.betweenas3.tweens.ITween;
	import org.robotlegs.mvcs.Mediator;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	//=================================================================================================================================================
	//
	//=================================================================================================================================================
	public class BaseBtnMediator extends Mediator
	{
		// --------------------------------------------------------------------------
		//
		// Constructor
		//
		// --------------------------------------------------------------------------
		public function BaseBtnMediator()
		{

		}

		// --------------------------------------------------------------------------
		//
		// Variables
		//
		// --------------------------------------------------------------------------
		public var _btn : Sprite;
		protected var enableBaseHoverTween:Boolean=true;
		private var flgOver : Boolean;
		private var twHover : ITween;

		// --------------------------------------------------------------------------
		//
		// Override methods
		//
		// --------------------------------------------------------------------------
		override public function onRegister() : void
		{
			initialize();
		}

		override public function onRemove() : void
		{
			trace(_btn.hasEventListener(MouseEvent.CLICK));
		}

		// --------------------------------------------------------------------------
		//
		// Methods
		//
		// --------------------------------------------------------------------------
		private function initialize() : void
		{
			eventMap.mapListener(_btn, MouseEvent.CLICK, mouseEventHandler);
			eventMap.mapListener(_btn, MouseEvent.ROLL_OVER, mouseEventHandler);
			eventMap.mapListener(_btn, MouseEvent.ROLL_OUT, mouseEventHandler);
			_btn.buttonMode = true;
			
			if(_btn is TLFTextField)return;
			if (_btn["hit"] && (_btn["hit"]is Sprite))
			{
				_btn.mouseChildren = false;
				_btn.hitArea = _btn["hit"];
			}
			
			if(!enableBaseHoverTween)return;

			if (_btn["ov"] && (_btn["ov"] is DisplayObject))
			{
				flgOver = true;
				_btn["ov"].alpha = 0;
			}
		}

		private function mouseEventHandler(event : MouseEvent) : void
		{
			switch(event.type)
			{
				case MouseEvent.ROLL_OVER:
				{
					if (flgOver) tweenHover(true);
					onOver();
					break;
				}
				case MouseEvent.ROLL_OUT:
				{
					if (flgOver) tweenHover(false);
					onOut();
					break;
				}
				case MouseEvent.CLICK:
				{
					onClick();
					break;
				}
			}
		}

		protected function tweenHover(bool : Boolean) : void
		{
			if (twHover)
			{
				twHover.stop();
			}

			var time : Number;
			var easing : IEasing;
			var obj : Object;

			switch(bool)
			{
				case true:
				{
					time = 0.5;
					easing = Expo.easeOut;
					obj = {alpha:1};
					break;
				}
				case false:
				{
					time = 0.4;
					easing = Sine.easeIn;
					obj = {alpha:0};
					break;
				}
			}
			twHover = BetweenAS3.to(_btn["ov"], obj, time, easing);
			twHover.play();
		}

		// ----------------------------------
		// for override
		// ----------------------------------
		protected function onClick() : void
		{
			// TODO Auto Generated method stub
		}

		protected function onOut() : void
		{
			// TODO Auto Generated method stub
		}

		protected function onOver() : void
		{
			// TODO Auto Generated method stub
		}
	}
}