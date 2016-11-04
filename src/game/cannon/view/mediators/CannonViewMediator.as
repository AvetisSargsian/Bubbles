package game.cannon.view.mediators
{
	import flash.geom.Point;
	
	import game.cannon.controller.CannonController;
	import game.cannon.model.CannonModel;
	import game.cannon.view.CannonView;
	import game.field.model.BallModel;
	import game.field.views.BallView;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class CannonViewMediator extends AbstractMediator
	{	
		private var arrow:DisplayObject;
		private var ammoViews:Array;
		private var countTxt:TextField;
		public function CannonViewMediator(thisView:BaseView=null)
		{
			super(thisView);
			CannonModel.instance.registerCallBack(CannonModel.CANNON_UPDATE_ARROW,updateCanonView);
			CannonModel.instance.registerCallBack(CannonModel.CANNON_UPDATE_AMMO,updateAmmoView);
			CannonModel.instance.registerCallBack(CannonModel.CANNON_SHOOT_COUNT,updateShootCount);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		override protected function setNativeVIew():BaseView
		{	
			return new CannonView(); 
		}
		
		override public function dispose():void
		{	
			CannonModel.instance.removeCallBack(CannonModel.CANNON_UPDATE_ARROW,updateCanonView);
			CannonModel.instance.removeCallBack(CannonModel.CANNON_UPDATE_AMMO,updateAmmoView);
			CannonModel.instance.removeCallBack(CannonModel.CANNON_SHOOT_COUNT,updateShootCount);
			ammoViews = null;
			arrow = null;
			super.dispose();
		}
		
		private function updateShootCount():void
		{
			countTxt.text =  CannonModel.instance.shootCount.toString();
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			arrow = nativeVIew.getChildByName(CannonView.ARROW);
			countTxt = nativeVIew.getChildByName(CannonView.COUNT_TXT) as TextField;
			var arrowPos:Point = nativeVIew.localToGlobal(new Point(arrow.x ,arrow.y));
			CannonController.instance.initialize(arrowPos);
			createAmmoView();
		}
		
		private function createAmmoView():void
		{
			var ball:BallView,
				name:String,
				tempX:Number = arrow.x,
				count:int = CannonModel.instance.ammoCount();
				ammoViews = new Array();
			
			for (var i:int = 0; i < count; ++i) 
			{
				name = CannonModel.instance.getBallColor(i);
				ball = new BallView(name);
				ball.alignPivot();
				ball.x = tempX;
				ball.y = arrow.y;
				ball.name = name;
				tempX -= 2 * BallModel.radius + 5;
				nativeVIew.addChild(ball);
				ammoViews[i] = ball;
			}
		}
		
		private function updateCanonView():void
		{
			arrow.rotation = CannonModel.instance.rotation;	
		}
		
		private function updateAmmoView():void
		{
			var name:String, 
				ballV:BallView,
				ballM:BallModel,
				count:int = ammoViews.length ;
			for (var i:int = 0; i < count; ++i) 
			{
				ballM = CannonModel.instance.getBallModel(i);
				if (ballM)
				{
					name = ballM.color;
					ballV = ammoViews[i];
					if (ballV.name != name)
					{
						ammoViews[i] = new BallView(name);
						ammoViews[i].name = name;
						nativeVIew.removeChild(ballV);
						nativeVIew.addChild(ammoViews[i]);
					}	
					ammoViews[i].x = ballV.x;
					ammoViews[i].y = ballV.y;
				}
			}
		}
	}
}