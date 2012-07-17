//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/02
//
//--------------------------------------------------------------------------
package pmvc.app.model 
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class MainProxy extends Proxy implements IProxy
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		public static const NAME: String = "MainProxy";


		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function MainProxy(data : Object = null)
		{
			super(MainProxy.NAME, data);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _userName:String;
		private var _icon:String;
		private var _photoList:Vector.<String>;
		

		//--------------------------------------------------------------------------
		//
		//  Accessors(a-z, getter -> setter)
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  photoList
		//----------------------------------
		public function get photoList():Vector.<String>
		{
			return _photoList;
		}
		
		public function set photoList(value:Vector.<String>):void
		{
			_photoList = value;
		}
		
		//----------------------------------
		//  icon
		//----------------------------------
		public function get icon():String
		{
			return _icon;
		}
		
		public function set icon(value:String):void
		{
			_icon = value;
		}
		
		//----------------------------------
		//  userName
		//----------------------------------
		public function get userName():String
		{
			return _userName;
		}
		
		public function set userName(value:String):void
		{
			_userName = value;
		}
	}
}