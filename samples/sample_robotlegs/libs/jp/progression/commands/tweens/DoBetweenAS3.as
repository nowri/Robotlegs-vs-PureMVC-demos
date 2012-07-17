package jp.progression.commands.tweens
{
	import jp.progression.commands.Command;

	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 *	BetweenAS3 を実行するコマンド
	 */
	public class DoBetweenAS3 extends Command
	{
		private var _tween:ITween;

		/**
		 *	コンストラクタ
		 */
		public function DoBetweenAS3(tween:ITween, initObject:Object=null)
		{
			super(_execute, _interrupt, initObject);

			_tween = tween;
		}

		/**
		 *	実行関数
		 */
		private function _execute():void
		{
			_tween.addEventListener(TweenEvent.COMPLETE, _completeHandler);
			_tween.play();
		}

		/**
		 *	トゥイーン完了時の処理
		 */
		private function _completeHandler(evt:TweenEvent):void
		{
			_tween.removeEventListener(TweenEvent.COMPLETE, _completeHandler);

			executeComplete();
		}

		/**
		 *	割り込み関数
		 */
		private function _interrupt():void
		{
			_tween.removeEventListener(TweenEvent.COMPLETE, _completeHandler);
			_tween.stop();
		}

		/**
		 *	クローンする
		 */
		override public function clone():Command
		{
			return new DoBetweenAS3(_tween.clone(), this);
		}
	}
}
