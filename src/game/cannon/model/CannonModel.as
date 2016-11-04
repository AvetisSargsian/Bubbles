package game.cannon.model
{
	import flash.geom.Point;
	
	import game.field.model.BallModel;
	
	import mvc.model.AbstractModel;
	
	import starling.utils.deg2rad;
	
	public class CannonModel extends AbstractModel
	{
		public static const CANNON_UPDATE_ARROW:String = "CANNON_UPDATE";
		public static const CANNON_UPDATE_AMMO:String = "CANNON_UPDATE_AMMO";
		public static const CANNON_SHOOT_COUNT:String = "CANNON_SHOOT_COUNT";
		private static var _instance:CannonModel;
		private var _rotation:Number;
		private var _cannonOrigin:Point;
		private var ammo:Vector.<BallModel>;
		private const COUNT:int = 15;
		private var _shootCount:int = COUNT;
		
		
		public function CannonModel(pvt:PrivateClass)
		{
			super();
			ammo = new Vector.<BallModel>();
		}
		
		public function get shootCount():int
		{
			return _shootCount;
		}
		
		public function dicrimentShoots():void
		{
			--_shootCount;
			update(CANNON_SHOOT_COUNT);
			trace(_shootCount);
		}

		public function ammoCount():int
		{
			return ammo.length; 
		}
		
		public function loadCannon(count:uint):void
		{
			for (var i:int = 0; i < count; ++i) 
			{
				ammo[i] = new BallModel(BallModel.RANDOM_COLOR);
			}
		}
		
		public function getBallColor(i:uint):String
		{
			if (i>=ammo.length) return null
			return	ammo[i].color;
		}
		
		public function realiseBall():BallModel
		{
			ammo[ammo.length] = new BallModel(BallModel.RANDOM_COLOR);
			var ball:BallModel = ammo.shift();
			update(CANNON_UPDATE_AMMO);
			return ball; 
		}
		
		public function getBallModel(i:uint):BallModel
		{
			if (i>=ammo.length) return null;
			return ammo[i];
		}
		
		public function get cannonOrigin():Point
		{
			return _cannonOrigin;
		}

		public function set cannonOrigin(value:Point):void
		{
			_cannonOrigin = value;
		}

		public static function get instance( ):CannonModel
		{
			if (_instance == null)
				_instance = new CannonModel(new PrivateClass());		
			return _instance;
		}

		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			if(value < deg2rad(-160)) value = deg2rad(-160);
			if(value > deg2rad(-20))  value = deg2rad(-20);
			_rotation = value;
			update(CANNON_UPDATE_ARROW);
		}
		
		override public function update(str:String = null):void
		{
			invokeCallBacks(str);
		}
		
		public function resetShootCount():void
		{
			_shootCount = COUNT;
			update(CANNON_SHOOT_COUNT);
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}