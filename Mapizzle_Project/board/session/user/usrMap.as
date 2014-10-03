package board.session.user
{
	public class usrMap
	{
		public var mapID:int;
		public var mapName:String;
		public var mapTitle:String;
		public var mapDescription:String;
		public var mapCreatorID:int;
		
		
		public var mapCurrFileIndex:int;
		public var mapCurrFileID:int;
		public var mapCurrFileName:String;
		
		public var usrMapLayer:Array;
		public var usrMapFile:Array;
		
		public var mapChanged:Boolean;
		
		public function usrMap()
		{
			mapChanged = false;
		}
	}
}