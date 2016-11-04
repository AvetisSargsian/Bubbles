package mvc.mediator
{
	import mvc.view.BaseView;

	public class AbstractMediator implements IMediator
	{
		private var _contextView:BaseView;
		private var _nativeVIew:BaseView;
		
		public function AbstractMediator(thisView:BaseView = null) 
		{
			if (thisView)
			{
				_nativeVIew = thisView;
				if (_nativeVIew.parent)
					_contextView = _nativeVIew.parent as BaseView; 
			}
			else
				_nativeVIew = setNativeVIew();
		}
		
		public function dispose():void
		{
			_nativeVIew.removeFromParent();
			_nativeVIew.dispose();
			_contextView = null;
			_nativeVIew = null;
		}
		
		public final function get nativeVIew():BaseView	{ return _nativeVIew; }
		public final function get contextView():BaseView 
		{
			if (!_contextView && nativeVIew.parent)
				_contextView = _nativeVIew.parent as BaseView;
			return _contextView; 
		}
		
		public final function addToParent(parent:BaseView):void
		{
			if (_nativeVIew && parent && !_contextView)
			{
				_contextView = parent;
				_contextView.addChild(_nativeVIew);
			}
		}
		
		protected function setNativeVIew():BaseView
		{
			return new BaseView();
		}
	}
}