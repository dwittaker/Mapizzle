package board.objects.controls
{
	import board.objects.GlobalVars;
	//import board.objects.controls.ShapePoint;
	//import board.objects.dialog.ObjOptions;
	import board.session.user.usrMapFileMarker;
	//import board.session.user.usrMapObject;
	//import board.session.user.usrMapObjectDesign;
	//import board.session.user.usrMapObjectDesignNodes;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.geom.ColorTransform;
	

	public class drawMarker extends mapObject
	{
		
		//public var objtype:String;
		//public var objname:String;
		
		
		
		public var topleftX:Number;
		public var topleftY:Number;
		public var botrightX:Number;
		public var botrightY:Number;
		
		var firstObjdragX:Number ;
		var firstObjdragY:Number;
		var firstMousedragX:Number;
		var firstMousedragY:Number;				
		
		public function drawMarker()//objfilcol:uint = 0xFF0000,objfilalp:Number = .75,objstrkcol:uint = 0x000000,objstrkalp:Number = 1,objstrkwid:Number = 2)
		{
			
			super();
			
			objmain = new Sprite;
			
			//this.addChild(objmain);
			
			
			
		}
		
		public function drawMarkerfromDB(obj:usrMapFileMarker)
		{
			this.newObject = false;
			this.visible = true;
			name = obj.mfMarkerName;
			this.objtype = "Mrkr";
			
			this.x = obj.PosRelStgX;
			this.y = obj.PosRelStgY;
			
			var mrkcolortrans:ColorTransform = new ColorTransform;
			mrkcolortrans.color = 0xFF0000;
			this.transform.colorTransform = mrkcolortrans;
/*		
			
			
			var des:usrMapObjectDesign;
			des = obj.usrMapObjectDesign[0];
		
			objtype = des.ObjType;
			topleftX = des.Block_topLeftX;
			topleftY = des.Block_topLeftY;
			botrightX = des.Block_botRightX;
			botrightY = des.Block_botRightY;
	
			this.x = des.PosRelStgX;
			this.y = des.PosRelStgY;
*/		
			this.addEventListener(MouseEvent.MOUSE_DOWN,objbasedown);
			this.addEventListener(MouseEvent.MOUSE_UP,objbaseup);
			
			this.addEventListener(MouseEvent.CLICK,catchclick);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeobject);			
				
			objfinished= true;
				
				//changeobjectcoloralpha();
				
				
		}
		
		
		public function createMarker(posX:Number,posY:Number)
		{
			//need to verify this is still needed, as function copied into drawmarkerfromdb
			this.visible = true;
			this.x = posX;
			this.y = posY;
			this.objfinished = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,objbasedown);
			this.addEventListener(MouseEvent.MOUSE_UP,objbaseup);
			
			this.addEventListener(MouseEvent.CLICK,catchclick);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeobject);
			
		}
		
		
		
		
		
		
		
	
		private function catchclick(evt:MouseEvent)
		{
			if(GlobalVars.ArrowSelect == true && (this.getChildByName(this.objopt.name) == null || this.objopt.visible == false))
			{
				////trace(this.name + " clicked");
//				showoptions();
//				//blockopt.x = this.x + 100;
//				//blockopt.y = this.y + 20;
				
			}
//			else if (GlobalVars.EraseObj == true)
//			{
//				mainObjDeleted = true;
//				this.ObjectChanged();
//			}
		}
		
		
		
		
		
		

		
		
		public function objbasedown(evt:MouseEvent)
		{
			if (GlobalVars.ModifyMove!=true)
			{
				return;
			}
			
			firstMousedragX = evt.stageX;
			firstMousedragY = evt.stageY;
			
			evt.target.addEventListener(MouseEvent.MOUSE_MOVE,moveentireobject);
			startDrag();
		}
		
		public function objbaseup(evt:MouseEvent)
		{
			evt.target.removeEventListener(MouseEvent.MOUSE_MOVE,moveentireobject);
			stopDrag();
			
			mainObjChanged = true;
			positionChanged = true;
			this.ObjectChanged();
			//usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
			//mainObjChanged = true;
		}
		
		
		
		
		private function moveentireobject(evt:MouseEvent)
		{

			
			evt.updateAfterEvent();
			
		}
		
		
		public function changeobjectcoloralpha()
		{
			
			//mainObjChanged = true;
			//this.graphics.clear();
			
			
			mainObjChanged = true;
			designChanged = true;
			this.ObjectChanged();
			
			//usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
		}
			
	}
}