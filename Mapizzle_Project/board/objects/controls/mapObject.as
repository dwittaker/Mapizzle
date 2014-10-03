package board.objects.controls
{
	import board.objects.GlobalVars;
	import board.objects.dialog.ObjOptions;
	import board.utilities.general.utils;
	
	import fl.motion.easing.Back;
	
	import flash.display.Sprite;
	import flash.events.Event;

	//import flash.display.Shape;
	//import flash.display.MovieClip;
	public class mapObject extends Sprite
	{
		public var objtype:String;
		public var objfinished:Boolean;
		//public var objname:String;
		
		public var objfillcolor:uint;
		public var objfillalpha:Number;
		
		public var objstrokecolor:uint;
		public var objstrokealpha:Number;
		public var objstrokewidth:Number;
		
		public var objnoderadius:Number;
		public var objnodefillcolor:uint;
		public var objnodefillalpha:Number;
		public var objnodestrokecolor:uint;
		public var objnodestrokealpha:Number;
		public var objnodestrokewidth:Number;
		
		public var objmain:Sprite;
		public var objnode:Sprite;
		
		public var objopt:ObjOptions;
		
		public var newObject:Boolean;
		public var mainObjChanged:Boolean;
		public var infoChanged:Boolean;
		public var designChanged:Boolean;
		public var positionChanged:Boolean;
		public var nodeChanged:Boolean;
		public var scheduleChanged:Boolean;
		public var attachChanged:Boolean;
		public var shareChanged:Boolean;
		public var tasksChanged:Boolean;
		public var notesChanged:Boolean;
		
		public var mainObjDeleted:Boolean;
		
		var utils1:utils;
		
		public function mapObject()
		{
			objfinished = true;
			utils1 = new utils;
			objopt = new ObjOptions;
			objopt.name = "Options" + objopt.name;
			mainObjChanged = false;
			
			this.newObject = true;
		}
		
		public function copyopts()
		{
		objopt.objfillcolor = objfillcolor;
		objopt.objfillalpha = objfillalpha;
		objopt.objstrokecolor = objstrokecolor;
		objopt.objstrokealpha = objstrokealpha;
		objopt.objstrokewidth = objstrokewidth;
		
		}
		
		public function ObjectChanged()
		{
			var finevt:Event = new Event("ObjectChanged");
			dispatchEvent(finevt);
		}
		
		public function removeobject(evt:Event)
		{
			if(GlobalVars.EraseObj == true)
			{
				mainObjDeleted = true;
				this.ObjectChanged();
			}
			
		}
	}
}