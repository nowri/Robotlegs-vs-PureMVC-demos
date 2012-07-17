package robotlegs.app.view.mediator.btn
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import fl.text.TLFTextField;
	import robotlegs.app.model.MainModel;
	import flash.display.Sprite;
	import robotlegs.abstract.view.btn.BaseBtnMediator;


	//=================================================================================================================================================
	//
	//=================================================================================================================================================
	public class LinkBtnMediator extends BaseBtnMediator
	{
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		[Inject]
		public var view:Sprite;
		
		[Inject]
		public var model:MainModel;
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------

		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		override public function onRegister() : void
		{
			_btn = view;
			super.onRegister();
		}
		
		/**
		 * constructor
		 * 
		 */
		public function LinkBtnMediator() 
		{
		}

	
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		override protected function onOut() : void
		{
			view.alpha=1;
		}
		
		override protected function onClick():void 
		{
			var tlf:TLFTextField = view as TLFTextField;
			var url:String;
			switch(view.name)
			{
				case "link1":
				case "link2":
				case "link3":
					url = "./?user="+tlf.text.split(".")[0];
					break;
					
				case "title":
				case "user":
				case "photo":
					url = "http://"+model.userName+".tumblr.com";
					break;
				
			}
			navigateToURL(new URLRequest(url), "_self");
		}
		

		override protected function onOver():void 
		{
			view.alpha=0.7;
		}
	}

}