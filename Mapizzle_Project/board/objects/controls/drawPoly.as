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

	public class drawPoly extends mapObject
	{
		public var shapepoints:Array = new Array();
		public var pointcnt:int;

		public var firstpointX:Number;
		public var firstpointY:Number;
		public var lastpointX:Number;
		public var lastpointY:Number;
		public var closepnttolerance:Number = 10;

		var firstObjdragX:Number ;
		var firstObjdragY:Number;
		var firstMousedragX:Number;
		var firstMousedragY:Number;	
		
		//public var myclrpckr:ColorPicker;
		//public var myalphasldr:Slider;

		public function drawPoly(objfilcol:uint = 0xFF0000,objfilalp:Number = .75,objstrkcol:uint = 0x000000,objstrkalp:Number = 1,objstrkwid:Number = 2)
		{
			super();

			objmain = new Sprite  ;
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

		
		public function drawPolyfromDB(obj:usrMapObject)
		{
			this.newObject = false;
			
			name = obj.ObjName;
			
			var des:usrMapObjectDesign;
			des = obj.usrMapObjectDesign[0];
			
			objtype = des.ObjType;

			this.x = des.PosRelStgX;
			this.y = des.PosRelStgY;
			
			firstpointX = des.FirstPosX;
			firstpointY = des.FirstPosY;
			lastpointX = des.Poly_lastX;
			lastpointY = des.Poly_lastY; 
			
			
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

		public function createfirstNode(firstX:Number,firstY:Number,lineonly:Boolean=false)
		{

			++pointcnt;
			var strnodename:String = setupnode(firstX,firstY,objnoderadius,lineonly);


			var shppnt:ShapePoint = new ShapePoint(pointcnt,firstX,firstY,strnodename);
			this.shapepoints.push(shppnt);

			//this.objnode.graphics.lineStyle(objnodestrokewidth,objnodestrokecolor,objnodestrokealpha);
			//this.objnode.graphics.beginFill(objnodefillcolor, objnodefillalpha);

			//this.objmain.x = 0;
			//this.objmain.y = 0;
			this.objmain.graphics.lineStyle(objstrokewidth,objstrokecolor,objstrokealpha);
			
			this.objmain.graphics.beginFill(objfillcolor, objfillalpha);
			this.objmain.graphics.moveTo(firstX,firstY);

		}

		public function createmiddleNode(X:Number,Y:Number,lineonly:Boolean=false)
		{
			


			++pointcnt;
			var strnodename:String = setupnode(X,Y,objnoderadius,lineonly);

			var shppnt:ShapePoint;
			//this.objmain.graphics.beginFill(objfillcolor, objfillalpha);
			if(1==0)
			{
				shppnt = new ShapePoint(pointcnt,X+objnoderadius,Y+objnoderadius,strnodename);
				this.shapepoints.push(shppnt);
				this.objmain.graphics.lineTo(X+objnoderadius,Y+objnoderadius);
			}
			else
			{
				
				shppnt = new ShapePoint(pointcnt,X,Y,strnodename);
				this.shapepoints.push(shppnt);
				
				//this.objmain.graphics.lineStyle(objstrokewidth,objstrokecolor,objstrokealpha);
//				this.objmain.graphics.beginFill(objfillcolor, objfillalpha);
				this.objmain.graphics.lineTo(X,Y);	
			}
			//this.objmain.graphics.moveTo(X,Y);
		}

		
	

	public function createlastNode(X:Number,Y:Number,lineonly:Boolean=false)
	{
		
			if(1==0)
			{
				this.objmain.graphics.lineTo(X+objnoderadius,Y+objnoderadius);
			}
			else
			{
				this.objmain.graphics.lineTo(X,Y);
				}
		

		this.objmain.graphics.endFill();
		this.objmain.name = this.name + "_base";

		this.objmain.addEventListener(MouseEvent.MOUSE_DOWN,objbasedown);
		this.objmain.addEventListener(MouseEvent.MOUSE_UP,objbaseup);
		
		this.objmain.addEventListener(MouseEvent.CLICK,catchclick);
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
		
		
		var i:int;
		var len:int = shapepoints.length;
		for (i=0; i<len; i++)
		{
			var onepoint:ShapePoint = shapepoints[i];
			if(onepoint.pointX > rightmostX) 
			{
				rightmostX = onepoint.pointX;
				rightmostY = onepoint.pointY;
			}
			if(onepoint.pointX < leftmostX) 
			{
				leftmostX = onepoint.pointX;
				leftmostY = onepoint.pointY;
			}
			if(onepoint.pointY > bottmostY) 
			{
				bottmostX = onepoint.pointX;
				bottmostY = onepoint.pointY;
			}
			if(onepoint.pointY < topmostY) 
			{
				topmostX = onepoint.pointX;
				topmostY = onepoint.pointY;
			}		
			
		}	
		
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


	public function setupnode(x:Number,y:Number,Rad:Number,lineonly:Boolean=false):String
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
		//newnode.addEventListener(MouseEvent.CLICK,catchclick);
		newnode.addEventListener(MouseEvent.MOUSE_DOWN,objnodedown);
		newnode.addEventListener(MouseEvent.MOUSE_UP,objnodeup);
		
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
		
		//var selnode:Sprite = Sprite(evt.target);
		
		
		firstMousedragX = evt.stageX;
		firstMousedragY = evt.stageY;
		
		evt.target.addEventListener(MouseEvent.MOUSE_MOVE,objnodemove);
		evt.target.startDrag();
		
		
		
		
	}
	public function objnodeup(evt:MouseEvent)
	{
		evt.target.removeEventListener(MouseEvent.MOUSE_MOVE,objnodemove);
		evt.target.stopDrag();
		
		mainObjChanged = true;
		nodeChanged = true;
		this.ObjectChanged();//mainObjChanged = true;
	}
	

	
	public function objnodemove(evt:MouseEvent)
	{
		var newXnode:Number;
		var newYnode:Number;
		var selnode:Sprite = Sprite(evt.target);
		var finalX:Number;
		var finalY:Number;

		

		newXnode = evt.stageX - firstMousedragX;
		newYnode = evt.stageY - firstMousedragY;
		
		
		
		var selpnt:ShapePoint;
		selpnt = utils1.getshapepoint(this.shapepoints, selnode.name);
		//trace("Point diff: " + selpnt.pointnum + " is X:"+newXnode+ " Y:"+newYnode);
		
		
		finalX = selpnt.pointX + newXnode;
		finalY = selpnt.pointY + newYnode;
		//trace("Final point: "+selpnt.pointnum+" move to X:"+finalX+ " Y:"+finalY);
		
		redrawobject(selnode.name, finalX, finalY);//newX,newY);
		
		
		firstMousedragX = evt.stageX;
		firstMousedragY = evt.stageY;
		evt.updateAfterEvent();
	}

public function objbasedown(evt:MouseEvent)
{
	if (GlobalVars.ModifyMove!=true)
	{
		return;
	}
	
	
	firstObjdragX = evt.stageX;
	firstObjdragY = evt.stageY;
	var base:Sprite = Sprite(Sprite(evt.target).parent);
	
		base.addEventListener(MouseEvent.MOUSE_MOVE,moveentireobject);
	
	
		base.startDrag();
	
}

public function objbaseup(evt:MouseEvent)
{
	var base:Sprite =  Sprite(Sprite(evt.target).parent);
	
	base.removeEventListener(MouseEvent.MOUSE_MOVE,moveentireobject);
	base.stopDrag();
		
	mainObjChanged = true;
	positionChanged = true;
	this.ObjectChanged();
	//mainObjChanged = true;
}

private function redrawobject(strnodename:String,nodeX:Number,nodeY:Number)
{
	//this.graphics.clear();
	this.objmain.graphics.clear();

	pointcnt = 0;
	var firstX:Number=0;
	var firstY:Number=0;
	var X:Number;
	var Y:Number;
	var tmppoints:Array = shapepoints;
	shapepoints = [];
	var i:int;
	var len:int = tmppoints.length;
	
	var onepoint:ShapePoint;
	for (i=0; i<len; i++)
	{
		onepoint = tmppoints[i];
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
			
			this.createfirstNode(X,Y,true);
		}
		else
		{
			this.createmiddleNode(X,Y,true);
		}
	}
	this.createlastNode(firstX,firstY);
}



private function moveentireobject(evt:MouseEvent)
{
	/*evt.updateAfterEvent();
	var newX:Number;
	var newY:Number;
	newX = evt.stageX - firstObjdragX;
	newY = evt.stageY - firstObjdragY;
	
	
	var i:int;
	var len:int = shapepoints.length;
	var tmppoints2:Array = shapepoints;
	var onepoint:ShapePoint;
	
	shapepoints = [];
	for (i=0; i<len; i++)
	{
	onepoint = tmppoints2[i];
	onepoint.nodename = tmppoints2[i].nodename;
	onepoint.pointnum = tmppoints2[i].pointnum;
	//onepoint.pointX = onepoint.pointX + newX - this.x;
	//onepoint.pointY = onepoint.pointY + newY - this.y;
	trace("Point "+onepoint.pointnum+" move to X:"+onepoint.pointX+ " Y:"+onepoint.pointY);
	shapepoints.push(onepoint);
	
	}
	trace("ObjMain move to X:"+this.objmain.x+ " Y:"+this.objmain.y);
	trace("Poly move to X:"+this.x+ " Y:"+this.y);
firstObjdragX = evt.stageX;
firstObjdragY = evt.stageY;*/
	setobjoptpos();
	evt.updateAfterEvent();

}


public function changeobjectcoloralpha()
{
	//mainObjChanged = true;
	//this.graphics.clear();
	this.objmain.graphics.clear();
	
	pointcnt = 0;
	var firstX:Number=0;
	var firstY:Number=0;
	var X:Number;
	var Y:Number;
	var tmppoints:Array = shapepoints;
	shapepoints = [];
	var i:int;
	var len:int = tmppoints.length;
	
	var onepoint:ShapePoint;
	for (i=0; i<len; i++)
	{
		onepoint = tmppoints[i];
		
		X = onepoint.pointX;
		Y = onepoint.pointY;
		
		
		if (i == 0)
		{
			firstX = X;
			firstY = Y;
			
			this.createfirstNode(X,Y,false);
		}
		else
		{
			this.createmiddleNode(X,Y,false);
		}
	}
	this.createlastNode(firstX,firstY);
	
	
	mainObjChanged = true;
	designChanged = true;
	this.ObjectChanged();
}



}
}