package mvc.pool
{
	import mvc.factory.IContentProduct;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class UniversalPool
	{
		private var poolVec:Vector.<IContentProduct>;
		private var classOfProduct:Class;
		
		public function UniversalPool()
		{
			poolVec = new Vector.<IContentProduct>(); 
		}
		
		public function fillUp(classOfProduct:Class,count:int):void
		{
			this.classOfProduct = classOfProduct;
			for (var i:int = 0; i < count; ++i) 
			{
				poolVec[poolVec.length] = createProduct(classOfProduct);
			}
		}
		
		public function take():IContentProduct
		{
			var product:IContentProduct;
			if (poolVec.length > 0)
			{
				product = poolVec.pop();
			}else
			{
				product = createProduct(classOfProduct);
			}
			if (product.content is DisplayObject)
			{
				product.content.addEventListener(Event.REMOVED_FROM_STAGE, returnToPool);
			}

			return product;
		}
		
		public function put(product:IContentProduct):void
		{
			poolVec[poolVec.length] = product;
		}
		
		public function flush():void
		{
			for (var i:int = 0,len:int = poolVec.length; i < len; ++i) 
			{
				poolVec[i].dispose();
				poolVec[i] = null;
			}
			poolVec.length = 0;
		}
		
		public function dispose():void
		{
			classOfProduct = null;
			poolVec = null;
		}
		
		private function createProduct(classOfProduct:Class):IContentProduct
		{
			return new ContentWraper(new classOfProduct()); 
		}
		
		private function returnToPool(event:Event):void
		{
			event.target.removeEventListener(Event.REMOVED_FROM_STAGE, returnToPool);
			var prod:Object = event.target as Object;
			put(new ContentWraper(prod));
		}
	}
}