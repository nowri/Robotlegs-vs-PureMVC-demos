//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/07/02
//
//--------------------------------------------------------------------------
package robotlegs.app.model 
{
	import org.robotlegs.mvcs.Actor;
	
	public class MainModel extends Actor
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function MainModel()
		{
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