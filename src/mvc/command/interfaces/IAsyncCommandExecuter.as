package mvc.command.interfaces
{
	public interface IAsyncCommandExecuter 
	{
		function add(command:IAsyncCmmand):void;
		function addList(list:Vector.<IAsyncCmmand>):void
		function executeComands():void;
	}
}