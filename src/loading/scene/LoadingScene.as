package loading.scene
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import mvc.view.Scene;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class LoadingScene extends Scene
	{
		public static const PROGRESS_BAR_NAME:String = "progressBar";
		
		public function LoadingScene()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{	
			this.onAddedToStage = null;
			
			var tFormat:TextFormat = new TextFormat("Verdana",25,Color.YELLOW);
			var logoTxt:TextField = new TextField(150,75,"Aim And Shoot");
			logoTxt.format = tFormat; 
			logoTxt.x = Constants.STAGE_WIDTH/2;
			logoTxt.y = Constants.STAGE_HEIGHT/3;
			logoTxt.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			logoTxt.alignPivot();
			addChild(logoTxt);
			
			tFormat = new TextFormat("Verdana",20,0xffffff);
			var loadingTxt:TextField = new TextField(150,75,"Loading...");
			loadingTxt.format = tFormat;
			loadingTxt.y = Constants.STAGE_HEIGHT/2 - 50;
			loadingTxt.x = Constants.STAGE_WIDTH/2 - loadingTxt.width/2;
			addChild(loadingTxt);
			
			var width:Number = Constants.STAGE_WIDTH * 0.66,
				height:Number = 35,
				scale:Number = Starling.contentScaleFactor,
				padding:Number = height * 0.175,
				cornerRadius:Number = padding * scale * 2;
			
			var bgShape:Shape = new Shape();
			bgShape.graphics.beginFill(0x0, 0.6);
			bgShape.graphics.drawRoundRect(0, 0, width*scale, height*scale, cornerRadius, cornerRadius);
			bgShape.graphics.endFill();
			
			var bgBitmapData:BitmapData = new BitmapData(width*scale, height*scale, true, 0x0);
			bgBitmapData.draw(bgShape);
			var bgTexture:Texture = Texture.fromBitmapData(bgBitmapData, false, false, scale);
			
			var mBackground:Image = new Image(bgTexture);
			mBackground.x = Constants.STAGE_WIDTH/2 - mBackground.width/2;
			mBackground.y = Constants.STAGE_HEIGHT/1.5
			addChild(mBackground);
			
			// create progress bar quad			
			var mBar:Quad = new Quad(width - 2*padding, height - 2 * padding, 0xffffff);
			mBar.setVertexColor(2, 0xffbe00);
			mBar.setVertexColor(3, 0xffbe00);
			mBar.x = mBackground.x + padding;
			mBar.y = mBackground.y + padding;
			mBar.scaleX = 0;
			mBar.name = PROGRESS_BAR_NAME;
			addChild(mBar);
		}
	}
}