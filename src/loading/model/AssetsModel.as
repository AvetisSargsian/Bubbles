package loading.model
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.system.System;
	
	import mvc.model.AbstractModel;
	
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	
	public class AssetsModel extends AbstractModel
	{	
		public static const UPDATE:String = "update";
		public static const LOADING_COMPLETE:String = "loadingComplete";
		public static const LOADING_PRECOMPLETE:String = "loadingPREComplete";
		public static const NO_ASSETS:String = "noAssets";
		
		private static var _instance:AssetsModel;
		
		public function get ratio():Number
		{
			return _ratio;
		}

		public static function get instance( ):AssetsModel
		{
			if (_instance == null)
			{
				_instance = new AssetsModel (new PrivateClass());		
			}
			return _instance;
		}
		private var _assetsManager:AssetManager;
		private var _ratio:Number;
		private var appDir:File;
		private var _path:String;
		
		public function AssetsModel(pvt:PrivateClass)
		{
			super();
			_assetsManager = new AssetManager();
			appDir = File.applicationDirectory;
			_path = "";
		}
		
		public static function drawRoundRectTexture(width:int, hight:int, color:uint, round:uint = 15,filled:Boolean=true):Texture
		{
			var bgShape:Shape = new Shape();
			bgShape.graphics.clear();
			filled ? bgShape.graphics.beginFill(color) : bgShape.graphics.lineStyle(3,color,1); 
			bgShape.graphics.drawRoundRect(0, 0, width, hight, round, round);
			bgShape.graphics.endFill();
			var bgBitmapData:BitmapData = new BitmapData(width, hight, true,0x00000000);
			bgBitmapData.draw(bgShape);
			return Texture.fromBitmapData(bgBitmapData, false, false, 1);
		}

		public function getTexture(name:String):Texture
		{
			var texture:Texture = _assetsManager.getTexture(name);
			return texture != null ? texture : drawRoundRectTexture(200,200,Color.RED);			
		}
		
		public function getMovieClipTextures(namePrefix:String):Vector.<Texture>
		{
			var texVec:Vector.<Texture> = _assetsManager.getTextures(namePrefix);
			return texVec != null ? texVec : texVec = new <Texture>[drawRoundRectTexture(200,200,Color.RED)];
		}

		public function getSound(name:String):Sound
		{
			return _assetsManager.getSound(name);
		}

		public function getXML(name:String):XML
		{
			return _assetsManager.getXml(name);
		}

		public function removeTexture(name:String):void
		{
			_assetsManager.removeTexture(name);	
		}

		public function getJSONObject(name:String):Object
		{
			return _assetsManager.getObject(name);
		}

		public function enqueueAsset(...params):void
		{
			var ful_path:String;
			for(var i:uint = 0,l:uint = params.length;i<l;i++)
			{
				if (params[i] is String)
				{
					ful_path = _path + params[i];
					appDir.resolvePath(_path);
					_assetsManager.enqueue(appDir.resolvePath(ful_path));
					continue;
				}
				if (params[i] is Array)
				{
					for (var j:int = 0,len:int = params[i].length; j<len; ++j) 
					{
						enqueueAsset(params[i][j])
					}
				}
			}
			trace("total enqued assets number",_assetsManager.numQueuedAssets);
		}

		public function loadAssets():void
		{
			if (_assetsManager.numQueuedAssets > 0)
			{
				_assetsManager.loadQueue(loadingProgress);
			}else
			{
				dispatchEventWith(NO_ASSETS);
				invokeCallBacks(NO_ASSETS);
			}
		}

		public function removeAtlas(name:String):void
		{
			_assetsManager.removeTextureAtlas(name,true);
		}

		public function removeXml(name:String):void
		{
			_assetsManager.removeXml(name,true);
		}

		private function loadingProgress(ratio:Number):void
		{
			_ratio = ratio;
			update();
			if (ratio == 1.0)
			{
				dispatchEventWith(LOADING_PRECOMPLETE);
				invokeCallBacks(LOADING_PRECOMPLETE);
				Starling.juggler.delayCall(function():void
				{
					_ratio = 0;
					// clean-up 
					System.pauseForGCIfCollectionImminent(0);
					System.gc();	
					
					dispatchEventWith(LOADING_COMPLETE);
					invokeCallBacks(LOADING_COMPLETE);
				}, 2.0);	
			}
		}

		private function update():void
		{
			invokeCallBacks(AssetsModel.UPDATE);
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ){}
}