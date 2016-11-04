package mvc.controller
{
	import mvc.model.IModel;
	
	import starling.animation.IAnimatable;

	public interface IController extends IAnimatable
	{
		function startJuggling():void;
		function stopJuggling():void;
		function updateModel(modl:IModel):void
	}
}