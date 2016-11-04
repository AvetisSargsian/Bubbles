package mvc.command.interfaces
{
	public interface IAsyncCmmand extends ICommand
	{
		function addCompleteCallback(callback:Function):void;
		function complete():void;
	}
}