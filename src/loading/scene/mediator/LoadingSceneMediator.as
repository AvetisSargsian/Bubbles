package loading.scene.mediator
{
	import loading.model.AssetsModel;
	import loading.scene.LoadingScene;
	
	import mvc.mediator.SceneMediator;
	import mvc.view.BaseView;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.utils.Align;
	import starling.utils.Color;
	
	public class LoadingSceneMediator extends SceneMediator
	{
		private var assetsModel:AssetsModel;
		private var pBar:DisplayObject;
		
		public function LoadingSceneMediator()
		{
			super();
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			assetsModel = AssetsModel.instance;
			assetsModel.registerCallBack(AssetsModel.UPDATE,onModelUpdate);
			assetsModel.registerCallBack(AssetsModel.NO_ASSETS,onNoAssetsToLoad);
		}
		
		private function onAdded():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			pBar = nativeVIew.getChildByName(LoadingScene.PROGRESS_BAR_NAME);
		}
		
		override public function dispose():void
		{
			assetsModel.removeCallBack(AssetsModel.UPDATE,onModelUpdate);
			assetsModel.removeCallBack(AssetsModel.NO_ASSETS,onNoAssetsToLoad);
			assetsModel = null;
			pBar = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():BaseView
		{
			return new LoadingScene();
		}
		
		private function onModelUpdate():void
		{
			var ratio:Number = assetsModel.ratio;
			pBar.scaleX = Math.max(0.0, Math.min(1.0, ratio));
		}
		
		private function onNoAssetsToLoad():void
		{			
			var txtFormat:TextFormat = new TextFormat("Verdana",25,Color.RED,Align.RIGHT);
			var txtField:TextField = new TextField(145,70,"NO ASSETS TO LOAD");
			txtField.format = txtFormat;
			txtField.name = "txtField";
			txtField.x = Constants.STAGE_WIDTH/2;
			txtField.y = pBar.y - txtField.height/2;
			txtField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			txtField.alignPivot();
			nativeVIew.addChild(txtField);
		}
	}
}