package mvc.command.interfaces
{
	public interface ICommandExecutor
	{
		function executeCommand():void;
		function loadCommands(vec:Vector.<ICommand>):void;
	}
}