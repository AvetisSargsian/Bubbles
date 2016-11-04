package game.view
{
	import mvc.view.BaseView;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Color;
	
	public class GameOverView extends BaseView
	{
		public static const STATUS_TXT:String = "STATUS_TXT";
		public static const PLAY_BUTTON:String = "PLAY_BUTTON";
		public static const PAROT_ANIM:String = "PAROT_ANIM";
		public static const TXT_WIN:String = "WIN";
		public static const TXT_LOST:String = "LOST";
		
		public function GameOverView()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{		
			var bg:Image = new Image(assetManager.getTexture("gameEndPopup"));
			addChild(bg);
			
			var txtFormat:TextFormat = new TextFormat("Verdana",30,Color.WHITE);
			var text:TextField = new TextField(250, 75,"");
			text.format = txtFormat; 
			text.x = bg.x + bg.width/2;
			text.y = bg.y + 40;
			text.name = STATUS_TXT;
			text.alignPivot();
			addChild(text);
			
			var parrot:MovieClip = new MovieClip(assetManager.getMovieClipTextures("parot_00"),25);
			parrot.x = text.x;
			parrot.y = bg.height/2 - 75;
			parrot.alignPivot();
			parrot.name = PAROT_ANIM;
			addChild(parrot);
			Starling.juggler.add(parrot);
			
			var btn:Button = new Button(assetManager.getTexture("button_purple"),"PLAY");
			btn.textFormat = txtFormat; 
			btn.x = text.x;
			btn.y = bg.height - btn.height - 50;
			btn.alignPivot();
			btn.name = PLAY_BUTTON;
			addChild(btn);

			this.y = -this.height;			
			this.scale = 0.8;
		}
		
		private function onRemove():void
		{
			
		}
	}
}