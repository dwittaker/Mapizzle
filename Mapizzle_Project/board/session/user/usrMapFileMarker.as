package board.session.user
{
	public class usrMapFileMarker
	{
		public var mfMarkerID:int;
		public var mfMarkerName:String;
		public var mfMarkerTitle:String;
		public var mfMarkerDescription:String;
		public var CreatorID:int ;
		
		public var activeSW:Boolean;
		
		public var PosRelStgX:Number;
		public var PosRelStgY:Number;
		public var PosRelmfX:Number;
		public var PosRelmfY:Number;
		
		//public var dttmMarked:Datetime;
		
		public var newObject:Boolean;
		public var mapMarkerChanged:Boolean;
		public var positionChanged:Boolean;

		
		public  var objDeleted:Boolean;
		
		
		public function usrMapFileMarker() 
		{
			this.newObject = true;
			mapMarkerChanged = false;
			positionChanged = false;
			objDeleted = false;
			
			//mapChanged = false;
		}
	}
}