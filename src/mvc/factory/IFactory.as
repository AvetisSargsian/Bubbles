package mvc.factory
{
	import mvc.disposeble.IDisposeble;
	import mvc.view.BaseView;
	

	public interface IFactory extends IDisposeble
	{
		function produce(cellV:BaseView, data:Object):void
	}
}