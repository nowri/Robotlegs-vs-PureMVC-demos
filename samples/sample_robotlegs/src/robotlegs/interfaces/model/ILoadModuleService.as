package robotlegs.interfaces.model
{
	public interface ILoadModuleService
	{
		function load(urlAr : Array, groupId : String = "", isCache : Boolean = true, parallelNum : int = -1, parallelWaitTime : Number = -1) : void
	}
}