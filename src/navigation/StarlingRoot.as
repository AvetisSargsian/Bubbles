package navigation
{
	import mvc.view.BaseView;
	
	public class StarlingRoot extends BaseView
	{
		public function StarlingRoot()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;
		}
	}
}