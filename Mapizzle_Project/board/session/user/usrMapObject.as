package board.session.user
{
	public class usrMapObject
	{
		public var ObjID:int ;
		public var ObjName:String ;
		public var Title:String ;
		public var Description:String ;
		public var Priority:int ;
		public var Area:String ;
		public var CreatorID:int ;
		//public var MapID:int ;
		public var RelObjID:int ;
		public var HasAttach:Boolean ;
		public var HasSchedule:Boolean ;
		public var HasShare:Boolean ;
		public var HasNotes:Boolean ;
		public var HasTasks:Boolean ;
		public var HasConvo:Boolean;
		
		public var usrMapObjectDesign:Array;
		
		public var newObject:Boolean;
		public var mapObjectChanged:Boolean;
		public var positionChanged:Boolean;
		public var designChanged:Boolean;
		public var nodeChanged:Boolean;
	
		public  var objDeleted:Boolean;
		
		public function usrMapObject()
		{
			this.newObject = true;
			mapObjectChanged = false;
			positionChanged = false;
			designChanged = false;
			nodeChanged = false;
		}
		
		
	}
}