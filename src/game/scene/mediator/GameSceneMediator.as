package game.scene.mediator
{
	import game.cannon.view.mediators.CannonViewMediator;
	import game.field.controller.FieldController;
	import game.field.model.FieldModel;
	import game.field.views.mediators.PlayFieldViewMediator;
	import game.view.mediators.GameOverViewMediator;
	
	import mvc.mediator.IMediator;
	import mvc.mediator.SceneMediator;
	
	import starling.events.Event;
	
	public class GameSceneMediator extends SceneMediator
	{	
		private var playFieldMediator:IMediator;
		private var cannonMediator:IMediator;
		private var gameOverPopupMediator:IMediator
		
		public function GameSceneMediator()
		{
			super();
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			playFieldMediator.dispose();
			playFieldMediator = null;
			cannonMediator.dispose();
			cannonMediator = null;
			gameOverPopupMediator.dispose();
			gameOverPopupMediator = null;
			super.dispose();
		}
		
		override protected function onKeyboardBACK():void {}
		
		private function onAdded():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			playFieldMediator = new PlayFieldViewMediator();
			playFieldMediator.addToParent(nativeVIew);
			
			cannonMediator = new CannonViewMediator();
			cannonMediator.addToParent(nativeVIew);
			
			gameOverPopupMediator = new GameOverViewMediator();
			gameOverPopupMediator.nativeVIew.visible = false;
			gameOverPopupMediator.addToParent(nativeVIew);

			FieldController.instance.newGame();
		}
	}
}