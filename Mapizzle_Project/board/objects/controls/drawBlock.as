package board.objects.controls
{
	import board.objects.GlobalVars;
	import board.objects.controls.ShapePoint;
	import board.objects.dialog.ObjOptions;
	import board.session.user.usrMapObject;
	import board.session.user.usrMapObjectDesign;
	import board.session.user.usrMapObjectDesignNodes;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	public class drawBlock extends mapObject
	{
		public var shapepoints:Array = new Array();
		public var pointcnt:int;
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
		
		public function drawBlock()//objfilcol:uint = 0xFF0000,objfilalp:Number = .75,objstrkcol:uint = 0x000000,objstrkalp:Number = 1,objstrkwid:Number = 2)
		{
			
			super();
			
			objmain = new Sprite;
			
			this.addChild(objmain);
			
			pointcnt = 0;
			
		}
		
		public function drawBlockfromDB(obj:usrMapObject)
		{
			this.newObject = false;
			name = obj.ObjName;
			
			
			
			var des:usrMapObjectDesign;
			des = obj.usrMapObjectDesign[0];
		
			objtype = des.ObjType;
			topleftX = des.Block_topLeftX;
			topleftY = des.Block_topLeftY;
			botrightX = des.Block_botRightX;
			botrightY = des.Block_botRightY;
			
			this.x = des.PosRelStgX;
			this.y = des.PosRelStgY;
//			this.width=stage.width;
//			this.height = stage.height;
			
			
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
		
		/*public override function drawBlock(x:DisplayObject)
		{
		this = x;
		}
		*/
		public function createBlock()
		{
			
			
			this.objmain.graphics.lineStyle(objstrokewidth,objstrokecolor,objstrokealpha);
			this.objmain.graphics.beginFill(objfillcolor,objfillalpha);
			this.objmain.graphics.drawRect(topleftX, topleftY, botrightX - topleftX, botrightY - topleftY);
			this.objmain.graphics.endFill();
			
			this.objmain.name = this.name + "_base";
		}
		
		public function createfirstNode(firstX:Number,firstY:Number,lineonly:Boolean=false)
		{
			topleftX = firstX;
			topleftY = firstY;
			
			++pointcnt;
			var strnodename:String = setupnode(topleftX,topleftY,objnoderadius,lineonly);
			
			var shppnt:ShapePoint = new ShapePoint(pointcnt,topleftX,topleftY,strnodename);
			this.shapepoints.push(shppnt);
			
		}
		
		public function createotherNodes(brX:Number,brY:Number,NoLine:Number)
		{
			botrightX = brX;
			botrightY = brY;
			
			var strnodename:String;
			var shppnt:ShapePoint;
			var lineonly1:Boolean= false;
			var lineonly2:Boolean= false;
			var lineonly3:Boolean= false;
			
			if (NoLine == 1) lineonly1 = true;
			if (NoLine == 2) lineonly2 = true;
			if (NoLine == 3) lineonly3 = true;
			
			
			++pointcnt;
			strnodename = setupnode(botrightX,topleftY,objnoderadius,lineonly1);
			
			shppnt = new ShapePoint(pointcnt,botrightX,topleftY,strnodename);
			this.shapepoints.push(shppnt);
			
			
				//
				++pointcnt;
				strnodename = setupnode(botrightX,botrightY,objnoderadius,lineonly2);
				
				shppnt = new ShapePoint(pointcnt,botrightX,botrightY,strnodename);
				this.shapepoints.push(shppnt);
				
				
					
					++pointcnt;
					strnodename = setupnode(topleftX,botrightY,objnoderadius,lineonly3);
						
					shppnt = new ShapePoint(pointcnt,topleftX,botrightY,strnodename);
					this.shapepoints.push(shppnt);
							
			
			
//			this.objmain.addEventListener(MouseEvent.CLICK,catchclick);
//			this.objnode.addEventListener(MouseEvent.CLICK,catchclick);
			
			
			createBlock();
			
			this.objmain.addEventListener(MouseEvent.MOUSE_DOWN,objbasedown);
			this.objmain.addEventListener(MouseEvent.MOUSE_UP,objbaseup);
			
			this.objmain.addEventListener(MouseEvent.CLICK,catchclick);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeobject);
			
			showoptions();
		}
		
		
		
		
		
	
		private function catchclick(evt:MouseEvent)
		{
			if(GlobalVars.ArrowSelect == true && (this.getChildByName(this.objopt.name) == null || this.objopt.visible == false))
			{
				//trace(this.name + " clicked");
				showoptions();
				//blockopt.x = this.x + 100;
				//blockopt.y = this.y + 20;
				
			}
//			else if (GlobalVars.EraseObj == true)
//			{
//				mainObjDeleted = true;
//				this.ObjectChanged();
//			}
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
			else
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
			//this.parent.myusr.setFlagChanged(this.name);
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
			//usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
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
			var j:int;
			var len:int = tmppoints.length;
			var spritename:String="";
			var x:int = 1;
			//for (j=1; j<=this.numChildren; j++)
			while(this.numChildren>2)
			{
				spritename = Sprite(this.getChildAt(x)).name;
				if (spritename != strnodename)
				{
					this.removeChildAt(x);
				}
				else
				{
					x=2;
				}
			}
				
			
			for (i=0; i<len; i++)
			{
				var onepoint:ShapePoint = tmppoints[i];
				
				
				if (i == 0 && strnodename == onepoint.nodename)
				{
						createfirstNode(nodeX,nodeY,true);
						createotherNodes(botrightX,botrightY,0);
						break;					
				}
				if (i == 1 && strnodename == onepoint.nodename)
				{
					createfirstNode(topleftX,nodeY,false);
					createotherNodes(nodeX,botrightY,1);
					break;					
				}
				if (i == 2 && strnodename == onepoint.nodename)
				{
					createfirstNode(topleftX,topleftY,false);
					createotherNodes(nodeX,nodeY,2);
					break;					
				}
				if (i == 3 && strnodename == onepoint.nodename)
				{
					createfirstNode(nodeX,topleftY,false);
					createotherNodes(botrightX,nodeY,3);
					break;					
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
			var j:int;
			var len:int = tmppoints.length;
			//var len2:int = this.numChildren;
			
			var spritename:String="";
			var x:int = 1;
			//for (j=1; j<=len2; j++)
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
				
				
				if (i == 0)
				{
					createfirstNode(onepoint.pointX,onepoint.pointY,false);
					
					//break;					
				}
				else if(i==2)
				{
					
					createotherNodes(onepoint.pointX,onepoint.pointY,0);
					break;					
				}
				
				
			}
			
			mainObjChanged = true;
			designChanged = true;
			this.ObjectChanged();
			
			//usrSession(this.parent.parent.myusr).setFlagChanged(this.name);
		}
			
	}
}