package mvc.factory
{
	import mvc.disposeble.IDisposeble;

	/**
	 * Functional interface,declare one method which return an generic object.
	 * To get specific type need to be casted.
	 * 
	 * @author Avetis 
	 */	
	public interface IContentProduct extends IDisposeble
	{
		function get content():Object;
	}
}