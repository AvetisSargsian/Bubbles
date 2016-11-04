package game.field.views
{
	import mvc.view.BaseView;
	
	import starling.display.Image;
	
	public class BallView extends BaseView
	{
		private var imgName:String;
		public function BallView(mcName:String)
		{
			super();
			this.imgName = mcName;
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			var img:Image= new Image(assetManager.getTexture(imgName));
			img.name = imgName;
			addChild(img);
			alignPivot();
		}
	}
}