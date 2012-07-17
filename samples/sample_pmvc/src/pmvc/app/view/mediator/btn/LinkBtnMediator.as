package pmvc.app.view.mediator.btn
{

	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import pmvc.abstract.view.btn.BaseBtnMediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import flash.events.MouseEvent;


	//=================================================================================================================================================
	//
	//=================================================================================================================================================
	public class LinkBtnMediator extends BaseBtnMediator implements IMediator
	{
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		private var link : String;
		
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		/**
		 * constructor
		 * 
		 */
		public function LinkBtnMediator(name:String, viewComponent:Object, link:String) 
		{
			super(name, viewComponent);
			this.link = link;
		}

	
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		override protected function onRollOut(event : MouseEvent) : void
		{
			super.onRollOut(event);
			view.alpha=1;
		}
		
		/**
		 * 
		 */
		override protected function onClick(event:MouseEvent):void 
		{
			navigateToURL(new URLRequest(link), "_self");
			super.onClick(event);
		}
		

		override protected function onRollOver(event:MouseEvent):void 
		{
			super.onRollOver(event);
			view.alpha=0.7;
		}



	}

}