package game.field.views.mediators
{
	import game.cannon.controller.CannonController;
	import game.field.controller.FieldController;
	import game.field.model.BallModel;
	import game.field.model.FieldModel;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import game.field.views.BallView;
	import game.field.views.PlayFieldView;
	
	public class PlayFieldViewMediator extends AbstractMediator
	{
		private var fieldModel:FieldModel;
		private var touchEnabled:Boolean = true;
		
		public function PlayFieldViewMediator(thisView:BaseView=null)
		{
			super(thisView);
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
			
			fieldModel = FieldModel.instance;
			fieldModel.registerCallBack(FieldModel.FIELD_NEW,newGame);
			fieldModel.registerCallBack(FieldModel.FIELD_BALL_SHOOTED,ballShooted);
		}
		
		private function newGame():void
		{
			addBallsViews();
			FieldController.instance.startJuggling();
		}
		
		override protected function setNativeVIew():BaseView
		{		
			return new PlayFieldView(); 
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(TouchEvent.TOUCH,onTouch);
			fieldModel.removeCallBack(FieldModel.FIELD_BALL_SHOOTED,ballShooted);
			fieldModel = null;
			super.dispose();
		}
		
		private function addBallsViews():void
		{
			for (var i:int = 0; i < FieldModel.fieldMaxSizeRow; ++i) 
			{
				for (var j:int = 0; j < FieldModel.fieldMaxSizeCol; ++j) 
				{
					createView(FieldModel.instance.getAttachedBall(i,j));
				}
			}	
		}
		
		private function createView(ballM:BallModel):void
		{
			if(ballM)
			{
				var ballV:BallView = new BallView(ballM.color);
				ballV.touchable = false;
				var ballViewMediator:BallViewMediator = new BallViewMediator(ballM,ballV);
				ballViewMediator.addToParent(nativeVIew);
			}
		}
		
		private function ballShooted():void
		{
			var ball:BallModel = FieldModel.instance.shootedBall;
			if (ball)
			{
				nativeVIew.globalToLocal(ball.position,ball.position);
				createView(ball);
			}
		}
		
		private function onTouch(event:TouchEvent):void
		{
			if(FieldModel.instance.isGameOver) return;
			var touch:Touch = event.getTouch(nativeVIew,TouchPhase.BEGAN);
			if(touch)
			{
				CannonController.instance.aimOnDirection(touch.globalX,touch.globalY);
			}
			
			touch = event.getTouch(nativeVIew,TouchPhase.HOVER);
			if(touch )
			{
				CannonController.instance.aimOnDirection(touch.globalX,touch.globalY);
			}
			if (FieldModel.instance.shootedBall || FieldModel.instance.isBallsFalling()) return;
			touch = event.getTouch(nativeVIew,TouchPhase.ENDED);
			if(touch )
			{
				CannonController.instance.shoot(touch.globalX,touch.globalY);
			}
		}
	}
}