package game.controller
{
	import game.models.GameModel;
	
	import mvc.controller.AbstractController;
	
	public class GameController extends AbstractController
	{
		private static var _instance:GameController;
		public function GameController(pvt:PrivateClass)
		{
			super();
		}
		
		public static function get instance( ):GameController
		{
			if (_instance == null)
				_instance = new GameController (new PrivateClass());		
			return _instance;
		}
		
		public function startNewGame():void
		{
			GameModel.instance.restartGame();	
		}
		
		public function stopGame():void
		{
			
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}