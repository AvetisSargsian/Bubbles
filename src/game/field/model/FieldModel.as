package game.field.model
{
	import flash.geom.Point;
	
	import mvc.model.AbstractModel;
	
	public class FieldModel extends AbstractModel
	{
		public static const fieldMaxSizeCol:int = 10;
		public static const fieldMaxSizeRow:int = 10;
		public static const FIELD_WIDTH:int  = fieldMaxSizeCol * 2 * BallModel.radius + BallModel.radius; 
		public static const FIELD_HEIGHT:int = fieldMaxSizeRow * 2 * BallModel.radius + BallModel.radius;
		public static const FIELD_UPDATE:String = "FIELD_UPDATE";
		public static const FIELD_BALL_SHOOTED:String = "FIELD_SHOOT";
		public static const FIELD_NEW:String = "FIELD_NEW";
		public static const FIELD_GAME_OVER:String = "FIELD_GAME_OVER";
		private static var _instance:FieldModel;
		private var attachedBalls:Vector.<Vector.<BallModel>>;
		private var _relisedBAlls:Vector.<BallModel>;
		private var _shootedBall:BallModel;
		private var _isgameOver:Boolean = false;
		private var _isGameLost:Boolean = false;

		public function get isGameLost():Boolean
		{
			return _isGameLost;
		}

		public static function get instance( ):FieldModel
		{
			if (_instance == null)
				_instance = new FieldModel (new PrivateClass());		
			return _instance;
		}
		
		public function FieldModel(pvt:PrivateClass)
		{
			super();
			createField();
		}
		
		public function prepareNewField():void
		{
			createField();
			update(FIELD_NEW);
		}
		
		public function get isGameOver():Boolean
		{
			return _isgameOver;
		}
		
		public function get relisedBalls():Vector.<BallModel>
		{
			return _relisedBAlls;
		}
		
		public function isBallsFalling():Boolean
		{
			return _relisedBAlls.length > 0;
		}
		
		public function get shootedBall():BallModel
		{
			return _shootedBall;
		}
		
		public function set shootedBall(value:BallModel):void
		{
			_shootedBall = value;
			if(_shootedBall)
				update(FIELD_BALL_SHOOTED);
		}
		
		override public function update(str:String=null):void
		{
			invokeCallBacks(str);
		}
		
		public function getAttachedBalls():Vector.<Vector.<BallModel>>
		{
			return attachedBalls;
		}
		
		public function getAttachedBall(row:int,col:int):BallModel
		{
			if(row<0 || col<0)return null;
			if(row > attachedBalls.length-1 || col > attachedBalls[row].length-1) return null;	
			return attachedBalls[row][col];
		}
		
		public function getAttachedBallByCord(x:Number,y:Number):BallModel
		{
			var radius:int = BallModel.radius,
				row_pos:int = Math.floor(y/(2*radius)),
				step:int = row_pos%2 == 0 ? radius : 0,
				col_pos:int = Math.floor(x /(2*radius)+ step),
				ballM:BallModel = attachedBalls[row_pos][col_pos],
				distance:Number = Point.distance(new Point(x,y), new Point(ballM.x,ballM.y));
			return distance <= radius ? ballM : null;
		}
		
		public function attachOnField(ball:BallModel):void
		{	
			ball.attach();
			_shootedBall = null;
			if(ball.row >= attachedBalls.length )
			{
				attachedBalls[ball.row] = new Vector.<BallModel>(10);	
			}
			attachedBalls[ball.row][ball.colon] = ball;
			removeBallsChain(findeBallsChain(ball));
			checkForGameEnd();
		}
		
		public function forceFail():void
		{
			_isGameLost = true;
			_isgameOver = true;
			dropAllBalls();
		}
		
		public function forceWin():void
		{
			_isGameLost = false;
			_isgameOver = true;
			dropAllBalls();
		}
		
		private function checkForGameEnd():void
		{
			var counter:int = 0;
			if(attachedBalls.length >= fieldMaxSizeRow)
			{
				forceFail();
				return;
			}
			for (var i:int = 0; i < fieldMaxSizeCol; ++i) 
			{ 
				if(attachedBalls[0][i] != null) 
					++counter;
			}
			if (counter < fieldMaxSizeCol/2)
			{
				_isGameLost = false;
				forceWin();	
			}
		}
		
		private function dropAllBalls():void
		{
			for (var j:int = 0; j < fieldMaxSizeCol; ++j) 
			{
				var ball:BallModel = attachedBalls[0][j]; 
				if(ball != null)
				{
					attachedBalls[0][j] = null;
					ball.fall();
					_relisedBAlls[_relisedBAlls.length] = ball;
				}
			}
			removeNotConnected();
		}
		
		private function removeBallsChain(ballsChainArray:Array):void
		{
			if (ballsChainArray.length > 2)
			{
				for (var i:int=0,len:int = ballsChainArray.length; i < len; ++i) 
				{
					var coords:Array=ballsChainArray[i].split("_"),
						ball:BallModel = attachedBalls[coords[0]][coords[1]];
					attachedBalls[coords[0]][coords[1]] = null;
					ball.fall();
					_relisedBAlls[_relisedBAlls.length] = ball;
				}
				removeNotConnected();
			}
		}
		
		private function removeNotConnected():void 
		{
			for (var i:int=1; i<fieldMaxSizeRow; ++i) 
			{
				for (var j:uint=0; j<fieldMaxSizeCol; ++j) 
				{
					var ball:BallModel = getAttachedBall(i,j);
					if (ball) 
					{
						var connections:Array = new Array();
						getConnections(i,j,connections);
						if (connections[0]!="connected") 
						{
							attachedBalls[i][j] = null;
							ball.fall();
							relisedBalls[relisedBalls.length] = ball;
						}
					}
				}
			}
		}
		
		private function getConnections(row:int,col:int,connections:Array):void 
		{
			connections.push(row+","+col);
			var odd:uint=row%2;
			for (var i:int=-1; i<=1; i++) 
			{
				for (var j:int=-1; j<=1; j++) 
				{
					if (i!=0||j!=0) 
					{
						if (i==0||j==0||(j==-1&&odd==0)||(j==1&&odd==1)) 
						{
							if(connections.indexOf((i+row)+","+(j+col))==-1 && getAttachedBall(row+i,col+j) != null)
							{
								if (row+i==0) 
								{
									connections[0]="connected";
								} else {
									getConnections(row+i,col+j,connections);
								}
							}
						}
					}
				}
			}
		}
		
		private function findeBallsChain(startBall:BallModel):Array
		{
			var ballsChain:Array = new Array();
			nextChain(startBall.row,startBall.colon,ballsChain);
			return ballsChain;
		}
		
		private function nextChain(row:int,col:int,chain:Array):void 
		{
			chain.push(row+"_"+col);
			var odd:uint=row%2,
				ballColor:String = attachedBalls[row][col].color;
			for (var i:int=-1; i<=1; i++) 
			{
				for (var j:int=-1; j<=1; j++) 
				{
					if (i!=0||j!=0) 
					{
						if (i==0||j==0||(j==-1&&odd==0)||(j==1&&odd==1)) 
						{
							if ( ballColor == getBallColorName(row+i,col+j) && chain.indexOf((row+i)+"_"+(col+j))==-1)
							{
								nextChain(row+i,col+j,chain);
							}
						}
					}
				}
			}
		}
		
		private function getBallColorName(row:int,col:int):String
		{
			var ball:BallModel = getAttachedBall(row,col);
			if(ball)
				return ball.color;
			else
				return "";
		}
		
		private function createField():void
		{
			_isgameOver = false;
			attachedBalls = new Vector.<Vector.<BallModel>>();
			_relisedBAlls = new Vector.<BallModel>;
			_shootedBall = null;
			var ball:BallModel;
			for (var row:int = 0; row < fieldMaxSizeRow-1; ++row)
			{
				attachedBalls[row] = new Vector.<BallModel>(10);
				if (row > 4)continue;
				for (var col:int = 0; col < fieldMaxSizeCol; ++col)
				{
					ball = new BallModel(BallModel.RANDOM_COLOR,row, col);
					ball.isAttached = true;
					attachedBalls[row][col] = ball;
				}
			}
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}