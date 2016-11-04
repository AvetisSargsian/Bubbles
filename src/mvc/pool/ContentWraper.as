package mvc.pool
{
	import mvc.factory.IContentProduct;
	
	public class ContentWraper implements IContentProduct
	{
		private var _content:Object;
		
		public function ContentWraper(content:Object)
		{
			_content = content;
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		public function dispose():void
		{
			_content = null;
		}
	}
}