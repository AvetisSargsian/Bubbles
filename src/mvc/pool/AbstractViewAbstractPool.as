package mvc.pool
{
	import mvc.view.BaseView;
	
	import starling.events.Event;

	public class AbstractViewAbstractPool
	{
		private var poolVec:Vector.<BaseView>
		
		public function AbstractViewAbstractPool()
		{
			poolVec = new Vector.<BaseView>();
		}
		
		public function fillUp(count:int):void
		{
			for (var i:int = 0; i < count; ++i) 
			{
				poolVec[poolVec.length] = createView();
			}
		}
		
		public function take():BaseView
		{
			var view:BaseView;
			if (poolVec.length > 0)
			{
				view = poolVec.pop();
			}else
			{
				view = createView();
			}
			view.addEventListener(Event.REMOVED_FROM_STAGE, returnToPool);
			return view;
		}
		
		public function put(view:BaseView):void
		{
			poolVec[poolVec.length] = view;
		}
		
		public function flush():void
		{
			for (var i:int = 0,len:int = poolVec.length; i < len; ++i) 
			{
				poolVec[i].dispose();
				poolVec[i] = null;
			}
			poolVec.length = 0;
		}
		
		public function dispose():void
		{
			poolVec = null;
		}
		
		protected function createView():BaseView
		{
			return new BaseView(); 
		}
		
		private function returnToPool(event:Event):void
		{
			var veiw:BaseView = event.target as BaseView;
			veiw.removeEventListener(Event.REMOVED_FROM_STAGE, returnToPool);
			put(veiw);
		}
	}
}