package navigation.model
{
	import mvc.mediator.IMediator;
	import mvc.model.AbstractModel;
	import mvc.view.BaseView;
	
	public class NavigationModel extends AbstractModel
	{	
		private var _curentMediator:IMediator;
		private var _nextMediator:IMediator;
		private var canvas:BaseView;
		private static var _instance:NavigationModel;
		
		public static function get instance( ):NavigationModel
		{
			if (_instance == null)
			{
				_instance = new NavigationModel (new PrivateClass());		
			}
			return _instance;
		}
				
		public function NavigationModel(pvt:PrivateClass)
		{
			super();
		}
		
		public function init(displayObject:BaseView):void
		{
			if (canvas == null)
				canvas = displayObject;
		}
		
		public function get nextSceneMediator():IMediator
		{
			return _nextMediator;
		}
		
		public function set nextSceneMediator(value:IMediator):void
		{
			_nextMediator = value;
		}

		public function get curentSceneMediator():IMediator
		{
			return _curentMediator;
		}

		public function set curentSceneMediator(mediator:IMediator):void
		{
			if (_curentMediator)
				_curentMediator.dispose();
			
			_curentMediator = mediator;
			_curentMediator.addToParent(canvas); 
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) {}
}