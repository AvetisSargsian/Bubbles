package mvc.mediator
{
	import mvc.disposeble.IDisposeble;
	import mvc.view.BaseView;

	public interface IMediator extends IDisposeble
	{
		function get nativeVIew():BaseView;
		function get contextView():BaseView;
		function addToParent(parent:BaseView):void
	}
}