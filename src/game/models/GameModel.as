package game.models
{
	import mvc.model.AbstractModel;
	
	public class GameModel extends AbstractModel
	{

		public static const GAME_OVER:String = "GAME_OVER";
		public static const NEW_GAME:String = "NEW_GAME";
		public static const NEW_SCORE:String = "NEW_SCORE";
		
		private static var _instance:GameModel;
		private var _isGameOver:Boolean;
		private var _nextMove:int;
		private var _playerScore:int;
		
		public static function get instance( ):GameModel
		{
			if (_instance == null)
				_instance = new GameModel (new PrivateClass());		
			return _instance;
		}
		
		public function GameModel(pvt:PrivateClass)
		{
			super(); 
		}
		
		public function get isGameOver():Boolean
		{
			return _isGameOver;
		}
		
		public function get playerScore():int
		{
			return _playerScore;
		}
		
		public function get nextMove():int
		{
			return _nextMove;
		}
		
		public function restartGame():void
		{
		}
		
		public function resetScore():void
		{
			_playerScore = 0;
		}
		
		public function gameOver():void
		{
			_isGameOver = true;
			invokeCallBacks(GAME_OVER);
		}
		
		public function setScores(score:int):void
		{
			_playerScore = score;
			invokeCallBacks(NEW_SCORE);
		}
		
		public function initializeGame():void
		{	
			
		}
		
		public override function dispose():void
		{	
			super.dispose();
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}