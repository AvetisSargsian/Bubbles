package mvc.animator
{
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Animator
	{
		static public function move(view:DisplayObject,time:Number,dx:Number,dy:Number,onComplete:Function = null):void
		{
			var obj:Object = {
				x:dx,
				y:dy,
				onComplete:onComplete
			}
				
			Starling.juggler.tween(view,time,obj);
		}
		
		static public function drop(view:DisplayObject,time:Number,onComplete:Function = null):void
		{
			var obj:Object = {
				scale:1,
				onComplete:onComplete,
				transition: Transitions.EASE_OUT_BOUNCE
			}
			
			Starling.juggler.tween(view,time,obj);
		}
		
		static public function flip(view:DisplayObject,time:Number,onFlipAction:Function = null,onComplete:Function = null):void
		{
			var obj:Object = {
				scaleX:0,
				repeatCount:2,
				reverse:true,
				onRepeat:onFlipAction,
				onComplete:onComplete
			}
			
			Starling.juggler.tween(view,time,obj);
		}
	}
}