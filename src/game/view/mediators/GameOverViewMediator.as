package game.view.mediators
{
	import game.field.controller.FieldController;
	import game.field.model.FieldModel;
	import game.view.GameOverView;
	
	import mvc.animator.Animator;
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class GameOverViewMediator extends AbstractMediator
	{
		private var text:TextField;
		private var btn:Button;
		
		public function GameOverViewMediator(thisView:BaseView=null)
		{
			super(thisView);
			
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedTostage);
			FieldModel.instance.registerCallBack(FieldModel.FIELD_GAME_OVER,showGameOverPopup);
		}
	
		override public function dispose():void
		{
			btn.removeEventListener(Event.TRIGGERED,onBtnPush);
			text = null;
			btn = null
			super.dispose();
		}
		
		override protected function setNativeVIew():BaseView
		{
			return new GameOverView();
		}
		
		private function onAddedTostage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedTostage);
			text = nativeVIew.getChildByName(GameOverView.STATUS_TXT)as TextField;
			
			btn = nativeVIew.getChildByName(GameOverView.PLAY_BUTTON)as Button;
			btn.addEventListener(Event.TRIGGERED,onBtnPush);
			nativeVIew.visible = false;
		}
		
		private function showGameOverPopup():void
		{
			nativeVIew.visible = true;
			updateView();
			Animator.move(nativeVIew,0.5,nativeVIew.x,10);
		}
		
		private function onBtnPush():void
		{
			Animator.move(nativeVIew,0.25,nativeVIew.x,-nativeVIew.height,function():void{
				nativeVIew.visible = false;
				FieldController.instance.newGame();
			});
		}
		
		private function updateView():void
		{
			if(FieldModel.instance.isGameLost)
				text.text = GameOverView.TXT_LOST;
			else
				text.text = GameOverView.TXT_WIN;
		}
	}
}