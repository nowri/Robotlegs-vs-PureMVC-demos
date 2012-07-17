package inn.nowri.ka.utils
{
	public class VectorUtils
	{
		/**
		 * Convert Vector instance to Array instance
		 * @param value Vector instance
		 * @return Array Array Instance
		 */
		public static function toArray(value:*):Array
		{
			var arr:Array = [];
			for (var i:int = 0; i < value.length; i++)
			{
				arr[i] = value[i];
			}
			return arr;
		}
	}
}