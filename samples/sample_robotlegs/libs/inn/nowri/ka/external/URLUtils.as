package inn.nowri.ka.external
{
	import flash.net.LocalConnection;
	import flash.external.ExternalInterface;
	import flash.display.LoaderInfo;

	/***
	 * URLUtils.init()でLoaderInfoを渡してから使います。
	 * init()しなくてもLoaderInfo経由ではないメソッドであればそのまま使えます。
	 * 
	 */
	public class URLUtils
	{
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Properties
		//---------------------------------------------------------------------------------------------------------------------------------------------
		private static var _loaderInfo:LoaderInfo;
		private static const QUERY_STRING_PARSER:RegExp = /(?:^|&|;)([^&=;]*)=?([^&;]*)/g; // supports both ampersand and semicolon-delimted query string key/value pairs
		
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		public static function init(loader_info:LoaderInfo):void
		{
			_loaderInfo = loader_info;
		}
		
		public static function getURL():String
		{
			return getJSStr("window.location.href");
		}
		
		public static function getSWFURL():String
		{
			if(_loaderInfo)
			{
				return _loaderInfo.url;
			};
			
			try
			{
				throw new Error("URLUtil is not initialized yet. call URLUtil.init() first.");
			}
			catch(error:Error)
			{
				trace(error);
			};
			return "";
		}
		
		public static function getURLDomain():String
		{
			return getJSStr("window.location.hostName");
		}

		public static function getSWFDomain():String
		{
			return new LocalConnection( ).domain;
		}
		
		public static function getFlashVarsObj():Object
		{
			if(_loaderInfo)
			{
				return _loaderInfo.parameters.flashvars;
			};
			
			try
			{
				throw new Error("URLUtil is not initialized yet. call URLUtil.init() first.");
			}
			catch(error:Error)
			{
				trace(error);
			};
			return null;
		}
		
		public static function getURLQuery():String
		{
			return getJSStr("window.location.search");
		}
		
		public static function getURLQueryObj():Object
		{
			var obj:Object = {};
			if(!getURLQuery())
			{
				return null;
			};
			getURLQuery().substr(1).replace( QUERY_STRING_PARSER, function ( $0:String, $1:String, $2:String, $3:String, $4:String ):void
			{
				if ($1)
				{
					obj[$1] = $2;
				};
			});
			return obj;
		}
		
		public static function getSWFQuery():String
		{
			if(_loaderInfo)
			{
				return _loaderInfo.parameters.getquery;
			};
			
			try
			{
				throw new Error("URLUtil is not initialized yet. call URLUtil.init() first.");
			}
			catch(error:Error)
			{
				trace(error);
			};
			return "";
		}
		
		public static function getURLHash():String
		{
			return getJSStr("window.location.hash");
		}
		
		// getter setter
		static public function get loaderInfo():LoaderInfo
		{
			return _loaderInfo;
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Methods
		//---------------------------------------------------------------------------------------------------------------------------------------------
		
		
		//util
		private static function getJSStr(str:String):String
		{
			try
			{
			
				if(ExternalInterface.available)
				{
					return ExternalInterface.call("function(){ return " + str + "; }");
				}
				else
				{
					try
					{
						throw new Error("ExternalInterface is unavailable. then return empty String");
					}
					catch(error:Error)
					{
						return error+"";
					};
				};
			}catch(error:Error)
			{
				return error+"";
			}
			return "";
		}

	}
}
