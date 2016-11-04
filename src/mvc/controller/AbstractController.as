package mvc.controller
{
	import mvc.disposeble.IDisposeble;
	import mvc.model.IModel;
	
	import starling.core.Starling;
	
	public class AbstractController implements IController,IDisposeble 
	{
		public function AbstractController()
		{
			super();
			if(Object(this).constructor == AbstractController)
				throw new Error("Abstract classes can not be instantiated");
		}
		
		public function dispose():void{}
		
		public function advanceTime(time:Number):void{}
		
		public final function startJuggling():void
		{
			Starling.juggler.add(this);
		}
		
		public final function stopJuggling():void
		{
			Starling.juggler.remove(this);
		}
		
		public function updateModel(model:IModel):void
		{
			model.update();
		}
	}
}