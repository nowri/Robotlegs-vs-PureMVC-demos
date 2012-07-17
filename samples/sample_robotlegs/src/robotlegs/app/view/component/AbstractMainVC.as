//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/06/22
//
//--------------------------------------------------------------------------

package robotlegs.app.view.component
{
	import fl.text.TLFTextField;
	
	import flash.display.Sprite;
	
	public class AbstractMainVC extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function AbstractMainVC()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public var photo:Sprite;
		public var lines:Sprite;
		public var slash:Sprite;
		public var user:TLFTextField;
		public var link3:TLFTextField;
		public var link2:TLFTextField;
		public var link1:TLFTextField;
		public var title:TLFTextField;
		public var linkBg:Sprite;
	}
}