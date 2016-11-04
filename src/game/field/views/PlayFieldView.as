package game.field.views
{
	import game.field.model.BallModel;
	import game.field.model.FieldModel;
	
	import loading.model.AssetsModel;
	
	import mvc.view.BaseView;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class PlayFieldView extends BaseView
	{
		public function PlayFieldView()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			this.x = (Constants.STAGE_WIDTH-FieldModel.FIELD_WIDTH)/2;
			this.y = Constants.STAGE_HEIGHT/15;
			
			var texture:Texture = AssetsModel.drawRoundRectTexture
				(FieldModel.FIELD_WIDTH+2,FieldModel.FIELD_HEIGHT,Color.GRAY,BallModel.radius,false);	
			var bg:Image = new Image(texture);
			addChild(bg);
		}
	}
}