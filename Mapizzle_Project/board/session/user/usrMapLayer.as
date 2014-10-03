package board.session.user
{
	public class usrMapLayer
	{
		public var layerID:int ;
		public var layerName:String ;
		public var layerTitle:String ;
		public var layerDescription:String ;
		
		public var maplayerChanged:Boolean;
		//public var mapID:int ;
		
		public var usrMapObject:Array;
		
		public function usrMapLayer()
		{
			maplayerChanged = false;
			
		}
	}
}