package pmvc.app.model
{

	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import flash.display.BitmapData;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import jp.progression.commands.Command;
	import jp.progression.commands.CommandList;
	import jp.progression.commands.Func;
	import jp.progression.commands.Wait;
	import jp.progression.commands.lists.LoaderList;
	import jp.progression.commands.lists.ParallelList;
	import jp.progression.commands.net.LoadBitmapData;
	import jp.progression.commands.net.LoadCommand;
	import jp.progression.commands.net.LoadSWF;
	import jp.progression.data.Resource;
	import jp.progression.data.getResourceById;
	
	
	public class LoadModuleProxy extends Proxy 
	{
		public static const LOAD_COMPLETE : String = "LOAD_COMPLETE";
		public static const LOAD_PROGRESS : String = "LOAD_PROGRESS";
		public static var NAME:String = 'LoadModuleProxy';
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Properties
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		private static const PARALLEL_WAIT_TIME : Number = 0;
		private static const PARALLEL_LOAD_NUM : Number = 1;
		private var loadList : LoaderList;
		private var parallelList : ParallelList;
		private var _groupId : String;
		private var dataDic : Dictionary;
		private var _parallelNum : uint;
		private var _parallelWaitTime : Number;
		private var _noteName : String;
		
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// Public Methods
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		public function LoadModuleProxy()
		{
			super(NAME);
			loadList = new LoaderList();
			loadList.onComplete = loadComplete;
			loadList.onProgress = loadProgress;
			loadList.catchError = function(target : Object, error : Error) : void
			{
				trace("loaderListのエラーです", target, error);
			};
			loadList.onError = function() : void
			{
			};
			
			dataDic = new Dictionary(true);
			
			parallelList = new ParallelList();
			parallelList.onComplete = loadComplete;
			parallelList.catchError = function() : void
			{
				trace("parallelListのエラーです", (this as CommandList));
			};
			parallelList.onError = function() : void
			{
			};
		}
		
		public function load(noteName : String,
			urlAr : Array, groupId : String = "", isCache : Boolean = true, parallelNum : int = -1, parallelWaitTime : Number = -1) : void
		{
			_parallelNum = (parallelNum == -1) ? PARALLEL_LOAD_NUM : parallelNum;
			if (_parallelNum >= 2)
			{
				if (parallelWaitTime === -1)
				{
					_parallelWaitTime = PARALLEL_WAIT_TIME;
				}
				else
				{
					_parallelWaitTime = parallelWaitTime;
				}
				;
				loadModuleParallel(noteName, urlAr, groupId, isCache, _parallelNum);
				return;
			}
			_noteName = noteName;
			_groupId = (groupId) ? groupId : "group_" + (new Date().getTime());
			var len : uint = urlAr.length;
			for (var i : uint = 0; i < len; i++)
			{
				var url : String = urlAr[i];
				var cmd : LoadCommand = getLoadCommand(url, isCache, _groupId);
				loadList.addCommand(cmd, new Func(function(/*noteName : String, */
					groupId : String) : void
				{
					 _noteName = noteName;
					
					if (!dataDic[_groupId]) dataDic[_groupId] = [];
					var rsc : Resource = getResourceById(LoadCommand(Command(this).previous).url);
					if (rsc)
					{
						rsc = getResourceById(LoadCommand(Command(this).previous).url);
					}
					else
					{
						rsc = new Resource(LoadCommand(Command(this).previous).url, null);
					}
					if (Resource(rsc).data is BitmapData)
					{
						dataDic[_groupId].push(Resource(rsc).toBitmapData());
					}
					else
					{
						dataDic[_groupId].push(Resource(rsc));
					}
				}, [groupId]));
			}
			;
			loadList.execute();
		}
		
		// getter
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// Internal Methods
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		private function loadProgress(num : int = -1) : void
		{
			var _num : uint = (num == -1) ? uint(loadList.percent) : num;
			sendNotification(_noteName, _num, LOAD_PROGRESS);
		}
		
		private function loadComplete() : void
		{
			loadList.clearCommand(true);
			sendNotification(_noteName, null, LOAD_COMPLETE);
			_groupId = "";
			_noteName = "";
		}
		
		private function loadModuleParallel(noteName : String, 
			urlAr : Array, groupId : String, isCache : Boolean, parallelNum : uint) : void
		{
			_noteName = noteName;
			_groupId = (groupId) ? groupId : "group_" + (new Date().getTime());
			var groupParentAr : Array = urlAr.concat();
			var groupAr : Array = [];
			while (groupParentAr.length)
			{
				var pool : uint = parallelNum;
				var ar : Array = [];
				while (pool)
				{
					ar.push(groupParentAr.shift());
					if (!groupParentAr.length)
					{
						break;
					}
					pool--;
				}
				if (ar.length) groupAr.push(ar);
			}
			var len : uint = groupAr.length;
			for (var i : uint = 0; i < len; i++)
			{
				loadList.addCommand(function() : void
				{
					loadProgress(uint(100 * loadList.position / loadList.commands.length));
				});
				var pcmdl : ParallelList = new ParallelList();
				var ar2 : Array = groupAr[i];
				var len2 : uint = ar2.length;
				for (var j : int = 0; j < len2; j++)
				{
					pcmdl.addCommand(getLoadCommand(ar2[j], isCache, _groupId));
				}
				loadList.addCommand(pcmdl, new Wait(_parallelWaitTime));
			}
			loadList.addCommand(new Func(function(
				groupId : String) : void
			{
				_noteName = noteName;
				if (!dataDic[_groupId]) dataDic[_groupId] = [];
				var len3 : uint = urlAr.length;
				for (var k : uint = 0; k < len3; k++)
				{
					var rsc : Resource = getResourceById(urlAr[k]);
					if (rsc)
					{
						if (rsc.data)
						{
							if (rsc.data is BitmapData)
							{
								dataDic[_groupId].push(rsc);
							}
							else if (rsc.data)
							{
								dataDic[_groupId].push(rsc);
							}
						}
						else
						{
							dataDic[_groupId].push(null);
						}
					}
					else
					{
						throw new Error("Resourceがありません。", getResourceById(urlAr[i]));
					}
				}
				loadProgress(100);
			}, [groupId]));
			loadList.execute();
		}
		
		private function getLoadCommand(url : String, isCache : Boolean, groupId : String) : LoadCommand
		{
			var cmd : LoadCommand;
			var typeAr : Array = url.split("/");
			var type : String = typeAr[typeAr.length - 1].split(".")[1];
			switch(type)
			{
				case "swf":
					cmd = new LoadSWF(new URLRequest(url), null, {resGroup:groupId, context:new LoaderContext(false, ApplicationDomain.currentDomain)});
					break;
				case "jpg":
				case "gif":
				case "png":
				default:
					cmd = new LoadSWF(new URLRequest(url), null, {resGroup:groupId, context:new LoaderContext(false, ApplicationDomain.currentDomain)});
					break;
			}
			cmd.preventCache = !isCache;
			cmd.catchError = function() : void
			{
				trace("エラーです", (this as LoadCommand));
				(this as LoadCommand).data = null;
				(this as LoadCommand).executeComplete();
			};
			cmd.onError = function() : void
			{
			};
			return cmd;
		}
	}
}