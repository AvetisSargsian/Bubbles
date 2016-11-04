package mvc.pool
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class DynamicMultiProductPool
	{
		private var dictPool:Dictionary;
		
		public function DynamicMultiProductPool()
		{
			dictPool = new Dictionary();
		}
		
		public function fillWithClass(classOfNode:Class, count:int):void
		{			
			if (!dictPool[classOfNode])
				dictPool[classOfNode] = new Vector.<classOfNode>();
			for (var i:int = 0; i < count; ++i) 
			{
				dictPool[classOfNode][dictPool[classOfNode].length] = new classOfNode();
			}
		}
		
		public function take(classOfNode:Class):Object
		{
			if (dictPool[classOfNode] && dictPool[classOfNode].length > 0)
			{
				return dictPool[classOfNode].pop()
			}
			return new classOfNode();
		}
		
		public function pushBack(node:Object):void
		{
			var str:String = getQualifiedClassName(node);
			var nodeClass:Class = getDefinitionByName(str) as Class;
			
			if (nodeClass in dictPool)
			{
				dictPool[nodeClass][dictPool[nodeClass].length] = node;
			}
		}
		
		public function flush():void
		{
			dictPool = new Dictionary();
		}
		
		public function dispose():void
		{
			dictPool = null;
		}
	}
}