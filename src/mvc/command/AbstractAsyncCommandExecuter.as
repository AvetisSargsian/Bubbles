package mvc.command
{
	import mvc.command.interfaces.IAsyncCmmand;
	import mvc.command.interfaces.IAsyncCommandExecuter;
	import mvc.disposeble.IDisposeble;

	public class AbstractAsyncCommandExecuter implements IAsyncCommandExecuter, IDisposeble
	{
		protected var _commandList:Vector.<IAsyncCmmand>;
		protected var _isBusy:Boolean = false;
		
		public function AbstractAsyncCommandExecuter(commandList:Vector.<IAsyncCmmand> = null)
		{
			_commandList = Vector.<IAsyncCmmand>();
			if (commandList)
				addList(commandList);
		}
		
		public function add(command:IAsyncCmmand):void
		{
			command.addCompleteCallback(executeNext);
			_commandList[_commandList.length] = command;
		}
		
		public function addList(list:Vector.<IAsyncCmmand>):void
		{
			list.forEach(
				function myFunction(item:IAsyncCmmand, index:int, vector:Vector.<IAsyncCmmand>):void 
				{
					item.addCompleteCallback(executeNext);
				});
			_commandList.concat(list);
		}
		
		public function dispose():void
		{
			_commandList = null;
		}
		
		public function executeComands():void
		{
			attemptToExecute();
		}
		
		protected function attemptToExecute():void 
		{
			if (!_isBusy)
			{
				executeNext();
			}
		}
		
		protected function executeNext():void
		{
			_isBusy = false;
			if(_commandList && _commandList.length > 0)
			{
				_isBusy = true;
				_commandList.shift().execute();
			}
		}
	}
}