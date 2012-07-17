//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/05
//
//--------------------------------------------------------------------------

package robotlegs.slide.view.component
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;


	public class Photo extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function Photo(bmp:Bitmap)
		{
			this.bmp = bmp;
			this.bmp.smoothing = true;
			this.bmp.pixelSnapping = PixelSnapping.NEVER;
			addChild(bmp);
			addChild(msk);
			mskG = msk.graphics;
			bmp.mask = msk;
			maskParam=_maskParam;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var msk:Shape = new Shape();
		private var mskG:Graphics;
		private var bmp:Bitmap;
		private var _maskParam:Number=0;
		
		//--------------------------------------------------------------------------
		//
		//  Accessors
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  maskParam
		//----------------------------------
		public function get maskParam():Number
		{
			return _maskParam;
		}
		
		public function set maskParam(maskParam:Number):void
		{
			if(_maskParam == maskParam)return;
			_maskParam = maskParam;
			mskG.clear();
			mskG.beginFill(0x00,0);
			var w:int = int(bmp.width*maskParam);
			var _x:int = int(bmp.width*(1-maskParam));
			mskG.drawRect(_x, 0, w, bmp.height);
			mskG.endFill();
		}
	}
}
