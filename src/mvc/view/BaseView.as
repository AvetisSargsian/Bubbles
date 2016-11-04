package mvc.view
{
	import loading.model.AssetsModel;
	
	import mvc.disposeble.IDisposeble;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BaseView extends Sprite implements IDisposeble
	{
		private var _assetManager:AssetsModel;
		private var _onAddedToStage:Function;
		private var _onRemoveFromStage:Function;
		
		public function BaseView() 
		{
			super();
			
			_assetManager = AssetsModel.instance;
		}
		
		public function set onRemoveFromStage(value:Function):void
		{
			_onRemoveFromStage = value;
			if (_onRemoveFromStage != null)
				addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			else
				removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		
		public function set onAddedToStage(value:Function):void
		{
			_onAddedToStage = value;
			if (_onAddedToStage != null)
				addEventListener(Event.ADDED_TO_STAGE,onAdded);
			else
				removeEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		override public function dispose():void
		{
			_assetManager = null;
			_onRemoveFromStage = null;
			_onAddedToStage = null;
//			removeChildren(0,-1, true);
			super.dispose();
		}
		
		protected final function get assetManager():AssetsModel
		{
			return _assetManager;
		}
		
		private function onRemove():void
		{
			if (_onRemoveFromStage != null)
				_onRemoveFromStage();
		}
		
		private function onAdded():void
		{
			if(_onAddedToStage != null)
				_onAddedToStage();
		}
	}
}