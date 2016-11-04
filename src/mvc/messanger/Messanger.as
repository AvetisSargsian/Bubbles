//TODO:
//1) доработать анимацию появления и исчезновения  сообшения на экране
//2) add method option forceShow!
//3) опция нескольких сообшений, падаюшая очередь
//4) опция вывода сообшения в лог
//5) use pool for MessageComands
package mvc.messanger
{	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import mvc.command.AbstractAsyncCommandExecuter;
	import mvc.command.interfaces.IAsyncCommandExecuter;
	
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class Messanger 
	{
		private static var instance:Messanger;
		
		private var queueManager:IAsyncCommandExecuter;
		private var messageBgTexture:Texture;
//		===================================================================================
		public function Messanger(param:PrivateClass){}
//		====================================================================================
		public static function showAlert(message:String,canvas:DisplayObjectContainer,time:int = 2):void
		{
			checkForInit();
			showMessage("!!! " + message + " !!!",canvas,time,Color.RED)
		}
//		====================================================================================
		public static function showInfo(message:String,canvas:DisplayObjectContainer,time:int = 2):void
		{
			checkForInit(); 
			showMessage(message,canvas,time)
		}
//		===================================================================================
		private static function showMessage(message:String, canvas:DisplayObjectContainer, time:int, color:uint = Color.WHITE):void
		{
			var mc:MessageCommand = new MessageCommand(message,canvas,instance.messageBgTexture,time);
			mc.color = color;
			instance.queueManager.add(mc);
		}
//		===================================================================================
		private static function checkForInit():void
		{
			if (!instance)
			{
				instance = new Messanger(new PrivateClass());
				instance.initialize();
			}
		}
//		===================================================================================
		private function initialize():void
		{
			queueManager = new AbstractAsyncCommandExecuter();
			messageBgTexture = createBgTexture();
		}
//		===================================================================================
		private function createBgTexture():Texture
		{
			var cornerRadius:int = 40,
				bgBitmapData:BitmapData,
				bgShape:flash.display.Shape = new flash.display.Shape();
			
			bgShape.graphics.beginFill(0x00000, 1);
			bgShape.graphics.drawRoundRect(0, 0, 400, 100, cornerRadius, cornerRadius);
			bgShape.graphics.endFill();
			bgBitmapData = new BitmapData(400, 100, true,0x000000);
			bgBitmapData.draw(bgShape);
			
			return Texture.fromBitmapData(bgBitmapData, false, false, 1);
		}
//		====================================================================================
	}
}
class PrivateClass
{
	public function PrivateClass(){}
}