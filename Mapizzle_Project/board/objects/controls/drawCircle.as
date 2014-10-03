package board.objects.controls
{
	import board.objects.controls.ShapePoint;
	import board.objects.dialog.ObjOptions;
	import board.session.user.usrMapObject;
	import board.session.user.usrMapObjectDesign;
	import board.session.user.usrMapObjectDesignNodes;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import board.objects.GlobalVars;
	import board.session.user.usrSession;
	
	public class drawCircle extends mapObject
	{
		
		public var shapepoints:Array = new Array();
		public var pointcnt:int;
		
		public var centreX:Number;
		public var centreY:Number;
		public var circumX:Number;
		public var circumY:Number;
		public var radius:Number;
		
		var firstMousedragX:Number;
		var firstMousedragY:Number;	
		
		public function drawCircle(objfilcol:uint = 0xFF0000,objfilalp:Number = .75,objstrkcol:uint = 0x000000,objstrkalp:Number = 1,objstrkwid:Number = 2)
		{
			super();
			
			objmain = new Sprite;
			//objnode = new Sprite;
			this.addChild(objmain);
			//this.addChild(objnode);
			pointcnt = 0;
			objfillcolor = objfilcol;
			objfillalpha = objfilalp;
			objstrokecolor = objstrkcol;
			objstrokealpha = objstrkalp;
			objstrokewidth = objstrkwid;
			
			
		}
		
		public function drawCirclefromDB(obj:usrMapObject)
		{
			this.newObject = false;		
			name = obj.ObjName;
			
			var des:usrMapObjectDesign;
			des = obj.usrMapObjectDesign[0];
			
			objtype = des.ObjType;
			
			
			centreX = des.Circle_centreX;
			centreY = des.Circle_centreY;
			circumX = des.Circle_circumX;
			circumY = des.Circle_circumY;
			radius = des.Circle_radius;		
			
			this.x = des.PosRelStgX;
			this.y = des.PosRelStgY;
//			this.width=1024;
//			this.height = 768;
			
			objfillcolor = des.FillColour;
			objfillalpha = des.FillAlpha;
			
			objstrokecolor = des.StrokeColour
			objstrokealpha =des.StrokeAlpha
			objstrokewidth =des.StrokeWidth;
			
			var nod:usrMapObjectDesignNodes;
			nod = des.usrMapObjectDesignNodes[0];
			
			objnoderadius = nod.nodeRadius;
			objnodefillcolor = nod.nodeFillColour;
			objnodefillalpha = nod.nodeFillAlpha;
			objnodestrokecolor = nod.nodeStrokeColour;
			objnodestrokealpha = nod.nodeStrokeAlpha;
			objnodestrokewidth = nod.nodeStrokeWidth;
			
			var shppnt:ShapePoint;
			var i:int;				
			for (i=0;i < des.usrMapObjectDesignNodes.length ; i++)
			{
				nod = des.usrMapObjectDesignNodes[i];
				shppnt = new ShapePoint(nod.pointNum,nod.pointX,nod.pointY,nod.nodeName);
				this.shapepoints.push(shppnt);
			}
			
			
			
			
			objfinished= true;
			
			changeobjectcoloralpha();
			
			this.copyopts();
			this.objopt.setstartobj_design(des);
			this.objopt.setstartobj_info(obj);
			
			
			objopt.visible = false;
		}
		
		public function createCircle(circX:Number,circY:Number)
		{
			var circradius:Number = 0;
			circradius = Math.sqrt(Math.pow(circX - centreX,2) + Math.pow(circY - centreY,2));
			
			radius = circradius;
			this.objmain.graphics.lineStyle(objstrokewidth,objstrokecolor,objstrokealpha);
			this.objmain.graphics.beginFill(objfillcolor, objfillalpha);
			this.objmain.graphics.drawCircle(centreX, centreY, radius);
			this.objmain.graphics.endFill();
			
			this.objmain.name = this.name + "_base";
		}
		
		
		public function createfirstNode(firstX:Number,firstY:Number,lineonly:Boolean=false,centredot:Boolean=false)
		{
			++pointcnt;
			var strnodename:String = setupnode(firstX,firstY,objnoderadius,lineonly,centredot);
			
			var shppnt:ShapePoint = new ShapePoint(pointcnt,firstX,firstY,strnodename);
			this.shapepoints.push(shppnt);
			
//			this.objnode.graphics.lineStyle(objnodestrokewidth,objnodestrokecolor,objnodestrokealpha);
//			this.objnode.graphics.beginFill(objnodefillcolor, objnodefillalpha);
//			this.objnode.graphics.drawCircle(centreX,centreY,objnoderadius);
		}
		
		public function createotherNodes(circX:Number,circY:Number,lineonly:Boolean=false,centredot:Boolean=false)
		{
			++pointcnt;
			var strnodename:String = setupnode(circX,circY,objnoderadius,lineonly,centredot);
			
			var shppnt:ShapePoint = new ShapePoint(pointcnt,circX,circY,strnodename);
			this.shapepoints.push(shppnt);
//			this.objnode.graphics.beginFill(objnodefillcolor, objnodefillalpha);
//			this.objnode.graphics.drawCircle(circumX,circumY,objnoderadius);
			
			createCircle(circX,circY);
			//this.objnode.graphics.endFill();
			
			this.objmain.addEventListener(MouseEvent.MOUSE_DOWN,objbasedown);
			this.objmain.addEventListener(MouseEvent.MOUSE_UP,objbaseup);
			
			this.objmain.addEventListener(MouseEvent.MOUSE_UP,catchclick);
			this.objmain.addEventListener(Event.REMOVED_FROM_STAGE,removeobject);
			
			showoptions();
		}
		
		private function catchclick(evt:MouseEvent)
		{
			if(GlobalVars.ArrowSelect == true && (this.getChildByName(this.objopt.name) == null || this.objopt.visible == false))
			{
				trace(this.name + " clicked");
				showoptions();
				//blockopt.x = this.x + 100;
				//blockopt.y = this.y + 20;
				
			}
		}
		
		private function showoptions()
		{
			
			copyopts();
			setobjoptpos();
			
			if(this.getChildByName(this.objopt.name)==null)
				//if (this.objopt.parent is null)
			{
				this.addChild(this.objopt);
			}
			else if(GlobalVars.ArrowSelect == true)
			{
				this.objopt.visible = true;
			}
			
			
			
		}
		
		private function setobjoptpos()
		{
			var rightmostX:Number=0;
			var rightmostY:Number=0;
			var leftmostX:Number=99999;
			var leftmostY:Number=99999;
			var topmostX:Number = 99999;
			var topmostY:Number = 99999;
			var bottmostX:Number = 0;
			var bottmostY:Number = 0;
			
			
			
			rightmostX = this.centreX + this.radius;
			rightmostY = this.centreY;
			leftmostX = this.centreX - this.radius;
			leftmostY = this.centreY;
			
			topmostX = this.centreX;
			topmostY = this.centreY - this.radius;
			bottmostX = this.centreX;
			bottmostY = this.centreY + this.radius;
			
			
				
			
			if((stage.width - (rightmostX + this.x )) > this.objopt.width + 30)
			{
				this.objopt.PosX = rightmostX + 20;
				this.objopt.x = this.objopt.PosX;
				
			}
			else
			{
				this.objopt.PosX = leftmostX - 30 - this.objopt.width;
				this.objopt.x = this.objopt.PosX;
				
			}
			
			if((topmostY + this.y ) > 30)
			{
				
				this.objopt.PosY = topmostY - 20;
				this.objopt.y = this.objopt.PosY;
			}
			else
			{
				
				this.objopt.PosY = bottmostY - 20
				this.objopt.y = this.objopt.PosY;
			}
			
		}
		
		public function setupnode(x:Number,y:Number,Rad:Number,lineonly:Boolean=false,centredot:Boolean=false):String
		{
			//trace("Node " + pointcnt +" is at X:"+x+" Y:"+y+"");
			var nmtortrn:String;
			if(lineonly == false)
			{
				var newnode:Sprite = new Sprite  ;
				this.addChild(newnode);
				newnode.name = this.name + "_node_" + pointcnt;
				newnode.graphics.lineStyle(objnodestrokewidth,objnodestrokecolor,objnodestrokealpha);
				newnode.graphics.beginFill(objnodefillcolor, objnodefillalpha);
				newnode.graphics.drawCircle(x,y,Rad);
				newnode.graphics.endFill();
				if (centredot == true)
				{
				//newnode.addEventListener(MouseEvent.CLICK,catchclick);
				newnode.addEventListener(MouseEvent.MOUSE_DOWN,objbasedown);
				newnode.addEventListener(MouseEvent.MOUSE_UP,objbaseup);
				}else
				{
				newnode.addEventListener(MouseEvent.MOUSE_DOWN,objnodedown);
				newnode.addEventListener(MouseEvent.MOUSE_UP,objnodeup);
				}
				nmtortrn = newnode.name
			}
			else
			{
				nmtortrn = this.name + "_node_" + pointcnt;;
			}
			
			return nmtortrn;
		}
		
		
		
		public function objnodedown(evt:MouseEvent)
		{
			if (GlobalVars.ModifyMove!=true)
			{
				return;
			}
			
			
			var selnode:Sprite = Sprite(evt.target);
			
			/*firstObjdragX = selnode.x;//evt.target.x;
			firstObjdragY = selnode.y;//evt.target.y;*/
			firstMousedragX = evt.stageX;
			firstMousedragY = evt.stageY;
			
			evt.target.addEventListener(MouseEvent.MOUSE_MOVE,objnodemove);
			evt.target.startDrag();
			
			/*var selnode:Sprite = Sprite(evt.target);
			redrawobject(selnode.name,evt.stageX,evt.stageY);*/
			
			
		}
		public function objnodeup(evt:MouseEvent)
		{
			evt.target.removeEventListener(MouseEvent.MOUSE_MOVE,objnodemove);
			evt.target.stopDrag();
			
			mainObjChanged = true;
			nodeChanged = true;
			this.ObjectChanged();
			//usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
			//mainObjChanged = true;
		}
		
		public function objnodemove(evt:MouseEvent)
		{
			var newX:Number;
			var newY:Number;
			var selnode:Sprite = Sprite(evt.target);
			//firstObjdragX = selnode.x;
			//firstObjdragY = selnode.y;
			
			newX = evt.stageX - firstMousedragX;
			newY = evt.stageY - firstMousedragY;
			
			var selpnt:ShapePoint = utils1.getshapepoint(this.shapepoints, selnode.name);
			
			redrawobject(selnode.name,selpnt.pointX + newX, selpnt.pointY + newY);//newX,newY);
			evt.updateAfterEvent();
			
			firstMousedragX = evt.stageX;
			firstMousedragY = evt.stageY;
			
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
			///usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
			//mainObjChanged = true;
		}
		
			
		private function redrawobject(strnodename:String,nodeX:Number,nodeY:Number)
		{
			//this.graphics.clear();
			this.objmain.graphics.clear();
			
			pointcnt = 0;
			var firstX:Number;
			var firstY:Number;
			var X:Number;
			var Y:Number;
			var tmppoints:Array = shapepoints;
			shapepoints = [];
			var i:int;
			var len:int = tmppoints.length;
			for (i=0; i<len; i++)
			{
				var onepoint:ShapePoint = tmppoints[i];
				if (strnodename == onepoint.nodename)
				{
					X = nodeX;
					Y = nodeY;
				}
				else
				{
					X = onepoint.pointX;
					Y = onepoint.pointY;
				}
				
				if (i == 0)
				{
					firstX = X;
					firstY = Y;
					createfirstNode(X,Y,true,true);
				}
				else
				{
					createotherNodes(X,Y,true,false);
				}
			}
			
		}
		
		
	private function moveentireobject(evt:MouseEvent)
		{
	/*		var newX:Number;
			var newY:Number;
			newX = evt.stageX - firstMousedragX;
			newY = evt.stageY - firstMousedragY;
			
			
			var i:int;
			var len:int = shapepoints.length;
			for (i=0; i<len; i++)
			{
				var onepoint:ShapePoint = shapepoints[i];
				
				onepoint.pointX +=firstMousedragX;
				onepoint.pointY +=firstMousedragY;
				
				shapepoints[i] = onepoint;
				
			}
			firstMousedragX = evt.stageX;
			firstMousedragY = evt.stageY;
			*/
			setobjoptpos();
			evt.updateAfterEvent();
			
		}
	
	public function changeobjectcoloralpha()
	{
		//mainObjChanged = true;
		//this.graphics.clear();
		this.objmain.graphics.clear();
		
		pointcnt = 0;
		var firstX:Number;
		var firstY:Number;
		var X:Number;
		var Y:Number;
		var tmppoints:Array = shapepoints;
		shapepoints = [];
		var i:int;
		var len:int = tmppoints.length;
		
		var x:int = 1;
		while(this.numChildren>2)
		{
			//trace("object is " + this.getChildAt(x).name);
			//spritename = Sprite(this.getChildAt(x)).name;
			if (this.getChildAt(x) is ObjOptions)
			{
				x=2;
			}
			else
			{
				this.removeChildAt(x);	
			}
		}
		
		
		
		for (i=0; i<len; i++)
		{
			var onepoint:ShapePoint = tmppoints[i];
			
				X = onepoint.pointX;
				Y = onepoint.pointY;
			
			
			if (i == 0)
			{
				firstX = X;
				firstY = Y;
				createfirstNode(X,Y,false,true);
			}
			else
			{
				createotherNodes(X,Y,false,false);
			}
		}
		
		mainObjChanged = true;
		designChanged = true;
		this.ObjectChanged();
		//usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
		
	}
	
		
	}
}