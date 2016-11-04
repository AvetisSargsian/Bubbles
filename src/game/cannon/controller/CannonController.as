package game.cannon.controller
{
	import flash.geom.Point;
	
	import game.cannon.model.CannonModel;
	import game.field.model.BallModel;
	import game.field.model.FieldModel;
	
	import mvc.controller.AbstractController;
	
	public class CannonController extends AbstractController
	{
		private static var _instance:CannonController;
		private var touchPoint:Point;
		private var destVector:Point
		
		public function CannonController(pvt:PrivateClass)
		{
			super();
			touchPoint = new Point();
		}
		
		public static function get instance( ):CannonController
		{
			if (_instance == null)
				_instance = new CannonController(new PrivateClass());		
			return _instance;
		}
		
		public function aimOnDirection(x:Number,y:Number):void
		{
			touchPoint.setTo(x, y);
			destVector = touchPoint.subtract(CannonModel.instance.cannonOrigin);
			CannonModel.instance.rotation =  Math.atan2(destVector.y,destVector.x);
		}
		
		public function initialize(pos:Point):void
		{
			CannonModel.instance.cannonOrigin = pos;
			CannonModel.instance.loadCannon(4);
			CannonModel.instance.resetShootCount();
		}
		
		public function shoot(globalX:Number, globalY:Number):void
		{
			if(CannonModel.instance.shootCount > 0)
			{
				var ball:BallModel = CannonModel.instance.realiseBall();
				ball.x = CannonModel.instance.cannonOrigin.x;
				ball.y = CannonModel.instance.cannonOrigin.y;
				ball.fly(globalX, globalY);
				FieldModel.instance.shootedBall = ball;
			}else{
				FieldModel.instance.forceFail();
			}
			CannonModel.instance.dicrimentShoots();
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}