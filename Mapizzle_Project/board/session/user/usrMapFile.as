package board.session.user
{
	public class usrMapFile
	{
		public var mapFileChanged:Boolean;
		public var newObject:Boolean;
		
		public var mapFileID:int;
		public var mapFileName:String;
		public var mapFileTitle:String;
		public var mapFileDescription:String;
		public var versionNum:int;
		public var activeSW:Boolean;
		
		public var physfileName:String;
		public var physfileDimWidth:Number;
		public var physfileDimHeight:Number;
		
		public var thumbphysfileName:String;
		public var thumbphysfileDimWidth:Number;
		public var thumbphysfileDimHeight:Number;
		
		public var usrMapMarker:Array;
		
		public var stageX:Number;
		public var stageY:Number;
		
		public function usrMapFile()
		{
			mapFileChanged = false;
		}
	}
}