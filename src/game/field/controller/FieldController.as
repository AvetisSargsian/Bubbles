package game.field.controller
{
	import game.cannon.controller.CannonController;
	import game.cannon.model.CannonModel;
	import game.field.model.BallModel;
	import game.field.model.FieldModel;
	
	import mvc.controller.AbstractController;
	
	public class FieldController extends AbstractController
	{
		private static var _instance:FieldController;
		
		public function FieldController(pvt:PrivateClass)
		{
			super();
		}
		
		public static function get instance( ):FieldController
		{
			if (_instance == null)
				_instance = new FieldController(new PrivateClass());		
			return _instance;
		}
		
		override public function advanceTime(time:Number):void
		{
			updateShootedBall();
			updateFallingBalls();
			if(FieldModel.instance.isGameOver && !FieldModel.instance.isBallsFalling())
			{
				this.stopJuggling();
				FieldModel.instance.update(FieldModel.FIELD_GAME_OVER);
			}
		}
		
		private function updateFallingBalls():void
		{
			var relBalls:Vector.<BallModel> = FieldModel.instance.relisedBalls;
			for (var i:int = relBalls.length-1; i > -1 ; --i) 
			{
				var fball:BallModel = relBalls[i];
				if (fball)
				{
					fball.updateState();
					if(fball.y > FieldModel.FIELD_HEIGHT)
					{
						fball.remove();
						relBalls.removeAt(i);
					}
				}
			}
		}
		
		private function updateShootedBall():void
		{
			var sBall:BallModel = FieldModel.instance.shootedBall 
			if(sBall)
			{
				sBall.updateState();
				checkForBounce(sBall);
				checkForCollision(sBall);
			}
		}
		
		private function checkForBounce(ball:BallModel):void
		{
			if(ball.x <= BallModel.radius || ball.x >= FieldModel.FIELD_WIDTH - BallModel.radius)
			{
				ball.bounceFromWall();
			}
			if (ball.y < 0.85 * BallModel.radius)
			{
				parckBall(ball);
			}
		}
		
		private function checkForCollision(ball:BallModel):void
		{
			var ballM:BallModel,
				ballSVec:Vector.<Vector.<BallModel>> = FieldModel.instance.getAttachedBalls();
			for (var i:int = ballSVec.length-1; i > -1; --i)
			{
				for (var j:int = 0,len:int = ballSVec[i].length; j < len; ++j) 
				{
					ballM = ballSVec[i][j];
					if(ballM)
					{
						if (collide(ball,ballM))
						{
							parckBall(ball);
							return;
						}
					}
				}
			}			
		}
		
		private function parckBall(ball:BallModel):void
		{
			FieldModel.instance.attachOnField(ball);
			if(CannonModel.instance.shootCount == 0 && !FieldModel.instance.isGameOver)
				FieldModel.instance.forceFail();
		}
		
		private function collide(ball1:BallModel,ball2:BallModel):Boolean 
		{
			var dist_x:Number=ball1.x-ball2.x;
			var dist_y:Number=ball1.y-ball2.y;
			return Math.sqrt(dist_x*dist_x+dist_y*dist_y)<=2*BallModel.radius-2;
		}
		
		public function newGame():void
		{
			FieldModel.instance.prepareNewField();
			CannonModel.instance.resetShootCount();
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}