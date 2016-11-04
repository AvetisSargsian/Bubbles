package game.cannon.view
{
	import game.field.model.BallModel;
	import game.field.model.FieldModel;
	
	import loading.model.AssetsModel;
	
	import mvc.view.BaseView;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.Align;
	import starling.utils.Color;
	import starling.utils.deg2rad;
	
	public class CannonView extends BaseView
	{
		public static const ARROW:String = "arrow";
		public static const  COUNT_TXT:String = "COUNT_TXT";
		public function CannonView()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;
			
			this.x = (Constants.STAGE_WIDTH-FieldModel.FIELD_WIDTH)/2;
			this.y = Constants.STAGE_HEIGHT - FieldModel.FIELD_HEIGHT/4 - 10;
			
			var texture:Texture = AssetsModel.drawRoundRectTexture
				(FieldModel.FIELD_WIDTH+2,FieldModel.FIELD_HEIGHT/4,Color.GRAY,BallModel.radius,false);	
			var bg:Image = new Image(texture);
			addChild(bg);
			
			var arrow:Image = new Image(assetManager.getTexture("arrow"));
			arrow.alignPivot(Align.LEFT,Align.CENTER);
			arrow.rotation = deg2rad(-90); 
			arrow.x = bg.x + bg.width/2;
			arrow.y = bg.y + bg.height/2;
			arrow.name = ARROW;
			addChild(arrow);
			
			var txtFormat:TextFormat = new TextFormat("Verdana",20,Color.WHITE);
			var countTxt:TextField = new TextField(200, 75,"Shoot Count:");
			countTxt.format = txtFormat; 
			countTxt.x = arrow.x + 100;
			countTxt.y = arrow.y;
			countTxt.alignPivot();
			addChild(countTxt);
			
			countTxt = new TextField(75, 75,"");
			countTxt.format = txtFormat; 
			countTxt.x = arrow.x + 200;
			countTxt.y = arrow.y;
			countTxt.name = COUNT_TXT;
			countTxt.alignPivot();
			addChild(countTxt);
		}
	}
}