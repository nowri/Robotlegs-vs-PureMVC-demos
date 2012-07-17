package jp.progression.commands.tweens
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import jp.asatoban.MQEffect;
	import jp.progression.commands.Command;

	
	/**
	 */
	public class DoMQEffect extends Command
	{
		private var _mqe:MQEffect;
		private var _startParam:Array;
		private var _mqsize:uint;
		private var _mc:DisplayObjectContainer;
		/**
		 *	コンストラクタ
		 */
		public function DoMQEffect(mc:DisplayObjectContainer, mqsize:uint, startParam:Array, initObject:Object=null)
		{
			super(_execute, _interrupt, initObject);
			_startParam = startParam;
			_mqe = new MQEffect(mc);
			_mqe.x=mc.x;
			_mqe.y=mc.y;
			_mqsize=mqsize;
			_mc=mc;
			mc.parent.addChild(_mqe);
		}

		/**
		 *	実行関数
		 */
		private function _execute():void
		{
			_mqe.addEventListener(Event.COMPLETE, _completeHandler);
			_mqe.changeMQEffect(_mqsize);
			_mqe.start(_startParam[0], _startParam[1]);
		}

		/**
		 */
		private function _completeHandler(evt:Event):void
		{
			_mqe.removeEventListener(Event.COMPLETE, _completeHandler);
			if(_mqe.parent)_mqe.parent.removeChild(_mqe);
			executeComplete();
		}

		/**
		 *	割り込み関数
		 */
		private function _interrupt():void
		{
			_mqe.removeEventListener(Event.COMPLETE, _completeHandler);
			if(_mqe.parent)_mqe.parent.removeChild(_mqe);
			_mqe.stop();
		}

		/**
		 *	クローンする
		 */
		override public function clone():Command
		{
			return new DoMQEffect(_mc,_mqsize,_startParam);
		}
	}
}
