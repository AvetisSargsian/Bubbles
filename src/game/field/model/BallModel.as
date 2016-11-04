package game.field.model
{
	import flash.geom.Point;
	
	import mvc.model.AbstractModel;
	
	public class BallModel extends AbstractModel
	{
		public static const TYPE_RED:String = "bub_red";
		public static const TYPE_GREEN:String = "bub_green";
		public static const TYPE_BLUE:String = "bub_blue";
		public static const TYPE_ORANGE:String = "bub_orange";
		public static const RANDOM_COLOR:String = "RANDOM_COLOR";
		public static const BALL_UPDATE:String = "BALL_UPDATE";
		public static const BALL_REMOVED:String = "REMOVED";
		public static const radius:int = 22;
		
		private const colors:Vector.<String> = new <String>[TYPE_RED,TYPE_GREEN,TYPE_BLUE,TYPE_ORANGE];
		private const vertDist:Number = radius * Math.sqrt(3);
		private var dX:Number;
		private var dY:Number;
		private var flyAngle:Number;
		private var destination:Point;
		private var _position:Point;
		private var _moveSpeed:int = 8;
		private var _row:int;
		private var _colon:int;
		private var _color:String;
		private var _isAttached:Boolean = false;
		private var _isFalling:Boolean = false;
		private var _isFlying:Boolean = false;
		 
		public function BallModel(color,row:int = -1,col:int = -1)
		{
			super();
			_position = new Point();
			destination = new Point();
			setNewColor(color);
			this.row = row;
			this.colon = col;
		}
		
		public function bounceFromWall():void
		{
			dX *= -1; 
		}
		
		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
		}

		public function get isFlying():Boolean
		{
			return _isFlying;
		}

		public function set isFlying(value:Boolean):void
		{
			_isFlying = value;
			if (_isFlying)
			{
				_isAttached = false;
				_isFalling = false
			}
		}

		public function get isFalling():Boolean
		{
			return _isFalling;	
		}

		public function set isFalling(value:Boolean):void
		{
			_isFalling = value;
			if (_isFalling)
			{
				_isAttached = false;
				_isFlying = false
			}
		}

		public function get moveSpeed():int
		{
			return _moveSpeed;
		}

		public function get isAttached():Boolean
		{
			return _isAttached;
		}

		public function set isAttached(value:Boolean):void
		{
			_isAttached = value;
			if (_isAttached)
			{
				_isFalling = false;
				_isFlying = false
			}
		}
		
		override public function update(str:String=null):void
		{
			invokeCallBacks(str);
		}
		
		
		public function get colon():int
		{
			return _colon;
		}

		public function set colon(value:int):void
		{
			_colon = value;
			var padding:int = _row % 2 != 0 ? radius : 0 ;
			if(_colon > -1 ) _position.x = (2 * radius * _colon) + padding + radius;
		}

		public function get row():int
		{
			return _row;	
		}

		public function set row(value:int):void
		{
			_row = value;
			if(_row> -1 )_position.y = vertDist * _row + radius;
		}

		public function get y():Number
		{
			return _position.y;
		}

		public function set y(value:Number):void
		{
			_position.y = value;
		}

		public function get x():Number
		{
			return _position.x;
		}

		public function set x(value:Number):void
		{
			_position.x = value;
		}

		public function get color():String
		{
			return _color;
		}
		
		public function fly(destX:Number,destY:Number):void
		{
			isFlying = true;
			destination.setTo(destX,destY);
			setMoveShifting(_moveSpeed);
		}
		
		public function fall():void
		{
			isFalling = true;
			destination.setTo(_position.x, position.y + 2 * Constants.STAGE_HEIGHT);
			setMoveShifting(2 * _moveSpeed);
		}
		
		public function attach():void
		{
			isAttached = true;
			var diametr:int = 2 * radius;
			row = Math.floor((_position.y) / vertDist);
			if (row%2==0) {
				colon = Math.floor(_position.x/diametr);
			} else {
				colon = Math.floor((_position.x - radius)/diametr);
			}
			if(colon <= -1)	colon = 0;
			else if (colon >= 10) colon = 9;
			update(BALL_UPDATE);
		}
		
		public function updateState():void
		{
			if(_isFlying || _isFalling)
			{
				_position.offset(dX, dY);
				update(BALL_UPDATE);
			}
		}
		
		public function remove():void
		{
			update(BALL_REMOVED);
			dispose();
		}
		
		private function setMoveShifting(speed:int):void
		{
			dX = (destination.x - _position.x);
			dY = (destination.y - _position.y);
			flyAngle= Math.atan2(dY,dX);
			dX = speed * Math.cos(flyAngle);
			dY = speed * Math.sin(flyAngle);
		}
		
		private function setNewColor(color):void
		{
			if (color == RANDOM_COLOR)
			{
				setRandomColor();
			}else if(color == TYPE_RED || color == TYPE_BLUE ||color == TYPE_ORANGE ||color == TYPE_GREEN)
			{
				_color = color;
			}else
			{
				throw new Error( "Wrong Color type. Use 'Color' from BAllModel static variables!" );
			}
		}
		
		private function setRandomColor():void
		{
			var n:int = Math.floor(Math.random() * colors.length);
			_color = colors[n];
		}
	}
}