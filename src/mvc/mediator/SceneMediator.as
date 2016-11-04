package mvc.mediator
{
	import flash.ui.Keyboard;
	
	import mvc.view.BaseView;
	import mvc.view.Scene;
	
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class SceneMediator extends AbstractMediator
	{
		public function SceneMediator(thisView:BaseView = null)
		{
			super(thisView);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			nativeVIew.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		override public function dispose():void
		{
			nativeVIew.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			super.dispose();
		}
		
		override protected function setNativeVIew():BaseView
		{
			return new Scene();
		}
		
		protected function onKeyboardBACK():void {}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.ESCAPE:
				case Keyboard.BACK:
					onKeyboardBACK();
					event.preventDefault();
					break;
				default:
					break;
			}
		}
	}
}