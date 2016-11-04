package mvc.command
{
	import mvc.command.interfaces.IAsyncCmmand;
	import mvc.disposeble.IDisposeble;

	public class AbstractAsyncCommand implements IAsyncCmmand, IDisposeble
	{
		protected var _callBack:Function;
		
		public function AbstractAsyncCommand()
		{
		}
		
		public function execute():void	{}
		
		public function dispose():void 
		{
			_callBack = null;
		}
		
		public function addCompleteCallback(callback:Function):void
		{
			_callBack = callback;
		}
		
		public function complete():void
		{
			if (_callBack != null)
				_callBack();
		}
	}
}