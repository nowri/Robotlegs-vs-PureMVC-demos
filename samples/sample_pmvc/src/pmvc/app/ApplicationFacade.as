//--------------------------------------------------------------------------
//	
//	
//  @author : nowri.ka
//  @date : 2012/06/27
//
//--------------------------------------------------------------------------
package pmvc.app
{
	import pmvc.app.controller.commands.BroadCastCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import pmvc.app.controller.commands.LoadModuleCommand;
	import pmvc.app.controller.commands.MainCommand;
	import pmvc.app.model.LoadModuleProxy;
	import pmvc.app.model.MainProxy;
	
	

	public class ApplicationFacade extends Facade implements IFacade
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		public static const KEY:String="ApplicationFacade";
		
		//command
		public static const EXE_LOAD_MODULE:String="EXE_LOAD_MODULE";
		public static const EXE_MAIN:String="EXE_MAIN";
		public static const EXE_BROAD_CAST:String="EXE_BROAD_CAST";
		
		//notification
		public static const NOTE_LOAD_MAIN:String="NOTE_LOAD_MAIN";
		public static const NOTE_LOAD_IMAGES:String="NOTE_LOAD_IMAGES";
		public static const NOTE_SET_SLIDE_NEXT_TIMER:String="NOTE_SET_SLIDE_NEXT_TIMER";
		
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		public static function getInstance( key : String ) : ApplicationFacade 
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ] = new ApplicationFacade(key);
			return instanceMap[ key ] as ApplicationFacade;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ApplicationFacade( key : String )
		{
			super(key);
		}
		

		//--------------------------------------------------------------------------
		//
		//  Override methods
		//
		//--------------------------------------------------------------------------
		override protected function initializeController() : void
		{
			super.initializeController();
			registerCommand(ApplicationFacade.EXE_LOAD_MODULE, LoadModuleCommand);
			registerCommand(ApplicationFacade.EXE_MAIN, MainCommand);
			registerCommand(ApplicationFacade.EXE_BROAD_CAST, BroadCastCommand);
		}
		
		override protected function initializeModel() : void
		{
			super.initializeModel();
			registerProxy(new LoadModuleProxy());
			registerProxy(new MainProxy());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * broadcast(noteName, body, type)<br>または<br>broadcast(note:Notification)<br>で全てのfacadeに通知可能
		 */
		public function broadcast(...noteAr:Array):void
		{
			if(noteAr[0] is INotification)
			{
				var note:INotification = noteAr[0] as INotification;
				_broadcast(note.getName(), note.getBody(), note.getType());
			}
			else
			{
				_broadcast(noteAr[0], noteAr[1], noteAr[2]);
			};
		}
		
		private function _broadcast( notificationName:String, body:Object, type:String ):void
		{
			for(var i:String in instanceMap)
			{
				var facade:IFacade = instanceMap[i] as IFacade;
				if(!facade || facade==this)
				{
					continue;
				};
				facade.sendNotification(notificationName, body, type);
			};
		}
	}
}
