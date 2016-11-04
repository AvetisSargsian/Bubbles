package mvc.model
{
	import flash.utils.Dictionary;
	
	import mvc.disposeble.IDisposeble;
	
	import starling.events.EventDispatcher;
	
	public class AbstractModel extends EventDispatcher implements IModel, IDisposeble
	{
		private var callBacks:Dictionary = new Dictionary();
		
		public function AbstractModel()
		{
			super();
		}
		
		public function update(str:String = null):void {}
		
		public function dispose():void
		{
			callBacks = null;
			removeEventListeners();
		}
		
		public function flushCallBacks():void
		{
			callBacks = new Dictionary();
		}
		
		public final function registerCallBack(key:String,callBack:Function):void
		{
			if (!(key in callBacks))
			{
				callBacks[key] = new Vector.<Function>();
			}
			callBacks[key][callBacks[key].length] = callBack;
		}
		
		public final function removeCallBack(key:String,callBack:Function):void
		{
			if (key in callBacks)
			{
				var vec:Vector.<Function> = callBacks[key];
				for (var i:int = vec.length-1; i >= 0; --i)
				{
					if (vec[i] == callBack)
					{
						vec.removeAt(i); 
					}
				}
			}
		}
		
		public final function invokeCallBacks(key:String):void
		{
			if (key in callBacks)
			{
				var vec:Vector.<Function> = callBacks[key];
				for (var i:int = vec.length-1; i >= 0; --i)
				{
					vec[i]();
				}
			}
		}
	}
}