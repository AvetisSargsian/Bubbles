package game.field.views.mediators
{
	import game.field.model.BallModel;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	public class BallViewMediator extends AbstractMediator
	{
		private var ballModel:BallModel;
		
		public function BallViewMediator(model:BallModel,thisView:BaseView=null)
		{
			super(thisView);
			ballModel = model;
			ballModel.registerCallBack(BallModel.BALL_UPDATE,updateView);
			ballModel.registerCallBack(BallModel.BALL_REMOVED,dispose);
			updateView();
		}
		
		override public function dispose():void
		{
			ballModel.removeCallBack(BallModel.BALL_UPDATE,updateView);
			ballModel.removeCallBack(BallModel.BALL_REMOVED,dispose);
			ballModel = null;
			super.dispose();
		}
		
		private function updateView():void
		{
			nativeVIew.x = ballModel.x;
			nativeVIew.y = ballModel.y;	
		}
	}
}