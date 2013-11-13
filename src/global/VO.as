package global
{
	public class VO
	{
		private static var _instance:VO;
		public static function instance():VO
		{
			if(_instance == null)
				_instance = new VO();
			return _instance;
		}
		
		public function VO()
		{
		}
		
		public var sampleXML:XML;
		public var mapXML:XML;
		public var propXML:XML;
	}
}