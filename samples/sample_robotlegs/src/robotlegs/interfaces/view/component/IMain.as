package robotlegs.interfaces.view.component
{
	import robotlegs.app.view.component.AbstractMainVC;
	/**
	 * @author noeri.ka
	 */
	public interface IMain extends IContextView
	{
		function initialize():void;
		function get vc():AbstractMainVC;
	}
}
