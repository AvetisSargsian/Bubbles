package mvc.messanger
{
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import mvc.command.AbstractAsyncCommand;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.Align;
	import starling.utils.Color;

	public class MessageCommand extends AbstractAsyncCommand
	{
		private var canvas:DisplayObjectContainer;
		private var viewsContainer:DisplayObjectContainer
		private var timer:Timer;
		private var textField:TextField;
		private var bgImage:Image; 
		
		public function MessageCommand(message:String, canvas:DisplayObjectContainer,bgTexture:Texture, duration:int)
		{
			super();
			
			this.canvas = canvas;
			viewsContainer = new Sprite();
			bgImage = new Image(bgTexture);
			bgImage.scale9Grid = new Rectangle(20,20,360,60);
			
			timer = new Timer(duration * 1000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			textField = new TextField(100,50,message);
			textField.autoSize = starling.text.TextFieldAutoSize.HORIZONTAL;
			var textFormat:TextFormat = new TextFormat("Verdana",13);
			textFormat.horizontalAlign   = starling.utils.Align.CENTER;
			textFormat.color = Color.WHITE;
			textField.format = textFormat;
			
			bgImage.width = textField.bounds.width + 50;
			textField.x = (bgImage.width>>1) - (textField.bounds.width>>1);
			textField.y =(bgImage.height>>1) - (textField.bounds.height>>1);
			viewsContainer.addChild(bgImage);
			viewsContainer.addChild(textField);
		}

		public function set color(value:uint):void
		{
			textField.format.color = value;
		}
		
		override public function execute():void
		{
			canvas.addChildAt(viewsContainer,canvas.numChildren);
			viewsContainer.x = (Starling.current.stage.stageWidth>>1) - (viewsContainer.width>>1);
			viewsContainer.y = (Starling.current.stage.stageHeight>>1)- (viewsContainer.height>>1);
			timer.start();
		}
		
		override public function complete():void
		{
			super.complete();
			dispose();
		}
		
		override public function dispose():void
		{
			super.dispose();
			timer = null;
			canvas = null;
			textField = null;
			viewsContainer = null;
		}
		
		private function onTimerComplete(event:TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			canvas.removeChild(viewsContainer);
			complete();
		}
	}
}