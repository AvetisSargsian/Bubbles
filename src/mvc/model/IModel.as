package mvc.model
{
	import mvc.disposeble.IDisposeble;

	public interface IModel extends IDisposeble
	{
		function invokeCallBacks(key:String):void
		function removeCallBack(key:String,callBack:Function):void
		function registerCallBack(key:String,callBack:Function):void
		function flushCallBacks():void;
		function update(str:String = null):void;
	}
}