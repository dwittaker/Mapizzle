package board
{
	import board.objects.GlobalVars;
	import board.objects.controls.ShapePoint;
	import board.objects.controls.drawBlock;
	import board.objects.controls.drawCircle;
	import board.objects.controls.drawMarker;
	import board.objects.controls.drawPoly;
	import board.objects.panzoom.pzhandler;
	import board.session.user.usrMapFileMarker;
	import board.session.user.usrMapObject;
	import board.session.user.usrMapObjectDesign;
	import board.session.user.usrSession;
	import board.utilities.general.utils;
	import board.utilities.snapshot.Snapshot;
	
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ColorPicker;
	import fl.controls.Slider;
	import fl.motion.Color;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	//import flash.xml.*;
	//import flash.net.*;

	


	public class maplayout extends MovieClip
	{
		
		
		var actv:Boolean = new Boolean  ;
		var firstpointX:Number;
		var firstpointY:Number;
		var lastpointX:Number;
		var lastpointY:Number;
		var newblockobject:drawBlock;
		var newcircleobject:drawCircle;
		var newpolyobject:drawPoly;
		
		var newmarkerobject:drawMarker;
		
		var sct_optns:MovieClip;
		public var myclrpckr:ColorPicker;
		public var chkrandclr:CheckBox;
		public var myalphasldr:Slider;
		var btn_snap1:Button;
		var btn_save1:Button;
		var btn_defaults1:Button;
		var btn_closedefaults1:MovieClip;
		var win_defaults1:MovieClip;
		//public var shouldbubble:Boolean = true;
		var utils1:utils;
		var blnkmc:MovieClip;
		var btn_maplt:Button;
		var btn_maprt:Button;
		
		public var myusr:usrSession;
		var imageLoader:Loader;
		
		var mapobjXML:XML;
		
		public var pz:pzhandler;
		
		public function maplayout()
		{
			super();

			myusr = new usrSession;
			
			utils1 = new utils;
			GlobalVars.ArrowSelect = false;
			
			 blnkmc = new MovieClip  ;

			 myusr.addEventListener(Event.ADDED_TO_STAGE,stageready);

			if (myusr.stage == null)
			{
				this.addChild(myusr);
			}
			
			
			//this.loadmovie("http://localhost/mapizzle/mapfilecode/getpicture.php?mfid=7&mfnm=MFm1v1u1_20110426230428",MapImg);
		//shouldbubble = true;

		}
		
		



		private function stageready(evt:Event):void
		{
			
			myusr.removeEventListener(Event.ADDED_TO_STAGE,stageready);
			//myusr.initload = true;
			
			               //loadImage("http://localhost/mapizzle/mapfilecode/getpicture.php?opt=1&mfid=16&mfnm=MFm1v1u1_20110428120544");
			
			createobjectsfromdb();
			
			
			
			
			btn_select.addEventListener(MouseEvent.CLICK,hitbtnsel);
			btn_modify.addEventListener(MouseEvent.CLICK,hitbtnmod);
			
			btn_marker.addEventListener(MouseEvent.CLICK,hitbtnmarker);
			
			//btn_poly.addEventListener(MouseEvent.CLICK,hitbtnpoly);
			//btn_block.addEventListener(MouseEvent.CLICK,hitbtnrect);
			//btn_circle.addEventListener(MouseEvent.CLICK,hitbtncircle);
			
			btn_erase.addEventListener(MouseEvent.CLICK,hitbtnerase);
			
			btn_panzoom.addEventListener(MouseEvent.CLICK,hitbtnpanzoom);
			
			win_defaults1 = this.getChildByName("win_defaults") as MovieClip;
			//sct_optns = MovieClip(this.getChildByName("win_defaults"));
			myclrpckr = ColorPicker(win_defaults1.getChildByName("option_defclrpkr"));
			chkrandclr = CheckBox(win_defaults1.getChildByName("option_chkrandomcolour"));
			
			myalphasldr = Slider(win_defaults1.getChildByName("option_defalphapkr"));

			btn_snap1 = this.getChildByName("btn_snap") as Button;
			btn_snap1.addEventListener(MouseEvent.CLICK,snapshot);
			
			btn_save1 = this.getChildByName("btn_save") as Button;
			btn_save1.addEventListener(MouseEvent.CLICK,savelayout);
			
			btn_defaults1 = this.getChildByName("btn_defaults") as Button;
			btn_defaults1.addEventListener(MouseEvent.CLICK,openclosedefaults);

			btn_closedefaults1 = MovieClip(win_defaults1.getChildByName("btn_closedefopt"));
			btn_closedefaults1.addEventListener(MouseEvent.CLICK,openclosedefaults);
			win_defaults1.visible = false;
			
			btn_mfbck = this.getChildByName("btn_mfbck") as Button;
			btn_mfbck.addEventListener(MouseEvent.CLICK,mapbck);
			
			btn_mffwd = this.getChildByName("btn_mffwd") as Button;
			btn_mffwd.addEventListener(MouseEvent.CLICK,mapfwd);
			
			pz = new pzhandler;
			pz.bWidth = stage.stageWidth
			pz.bHeight = stage.stageHeight;
			
			pz.nXSize = pz.bWidth;
			pz.nYSize = pz.bHeight;
			
			pz.nXmin = 0;
			pz.nXmax = stage.stageWidth;
			pz.nYmin = 0;
			pz.nYmax = stage.stageHeight;
			
			trace ("w=" + pz.bWidth + "h = " + pz.bHeight);
		}
		
		function mapbck(evt:MouseEvent):void{
			var newindx:int;
			if (myusr.usrMaps[0].mapCurrFileIndex == myusr.usrMaps[0].usrMapFile.length - 1)
			{newindx = myusr.usrMaps[0].mapCurrFileIndex;}
			else
			{newindx = myusr.usrMaps[0].mapCurrFileIndex + 1;}
			
			
			loadMapFile(newindx);
		}
		
		function mapfwd(evt:MouseEvent):void{
			var newindx:int;
			if (myusr.usrMaps[0].mapCurrFileIndex == 0)
			{newindx = myusr.usrMaps[0].mapCurrFileIndex;}
			else
			{newindx = myusr.usrMaps[0].mapCurrFileIndex - 1;}
			
			loadMapFile(newindx);
		}
		
		
		function loadMapFile(indx:int):void {
			myusr.usrMaps[0].mapCurrFileIndex = indx;
			myusr.usrMaps[0].mapCurrFileID = myusr.usrMaps[0].usrMapFile[indx].mapFileID;
			myusr.usrMaps[0].mapCurrFileName= myusr.usrMaps[0].usrMapFile[indx].mapFileName;
			
			var mfid:String = String(myusr.usrMaps[0].mapCurrFileID);
			var mfnm:String = String(myusr.usrMaps[0].mapCurrFileName);
			var imagetoload:String = "http://localhost/mapizzle/mapfilecode/getpicture.php?opt=1&mfid=" + mfid + "&mfnm=" + mfnm;
			//trace(imagetoload);
			
			
			
			// Set properties on my Loader object
			imageLoader = new Loader();
			imageLoader.load(new URLRequest(imagetoload));
			imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, imageLoading);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			
			
			var currchild:MovieClip;
			var cntchildren:int;
			var cntmarkers:int;
			var onemarker:usrMapFileMarker;	
			var x:int;
			var y:int;
			
			cntchildren =objarea.numChildren;
			while(cntchildren --)
			{
				var mc:Object;
				//mc = new MovieClip;
				mc = objarea.getChildAt(cntchildren);
				if (mc.objtype=="Mrkr")
					{
					objarea.removeChildAt(cntchildren);
					}
				}
			//trace(myusr);
			
			cntmarkers = myusr.usrMaps[0].usrMapFile[indx].usrMapMarker.length;
			for(x=0;x<cntmarkers;x++)
			{
				onemarker = myusr.usrMaps[0].usrMapFile[indx].usrMapMarker[x];
				newmarkerobject = new drawMarker;
				objarea.addChild(newmarkerobject);
				newmarkerobject.drawMarkerfromDB(onemarker);
				newmarkerobject.addEventListener("ObjectChanged",UpdSessObjChange);
			}
		}
		
		
		function imageLoaded(e:Event):void {
			//var i:int;
			var imgcnt:int;
			imgcnt = mapimg.numChildren;
			while(imgcnt --)
			{
				mapimg.removeChildAt(imgcnt)
				}
			// Load Image
			mapimg.addChild(imageLoader);
			mapimg.x = myusr.usrMaps[0].usrMapFile[0].stageX;
			mapimg.y = myusr.usrMaps[0].usrMapFile[0].stageY;
			
			
			
		}
		
		function imageLoading(e:ProgressEvent):void {
			
			// Use it to get current download progress
			// Hint: You could tie the values to a preloader :)
			
		}

		
		
		

		private function restrictdraw(evt:MouseEvent):Boolean
		{
			//if (evt.stageX<1 || evt.stageX > 1023 || evt.stageY <1 || 
			if (evt.stageY > 679)
			{
				return true;
			}
			else
			{
				return false;

			}
		}
		
		private function hitbtnsel(evt:MouseEvent)
		{
			drawarea.visible = false;
			trace("arrow selected");
			
			btn_panzoom.addEventListener(MouseEvent.CLICK,hitbtnpanzoom);
			
			GlobalVars.ArrowSelect = true;
			GlobalVars.ModifyMove = false;
			GlobalVars.EraseObj = false;
			
			adderaselisteners(false);
		}
		
		private function hitbtnmod(evt:MouseEvent)
		{
			drawarea.visible = false;
			trace("modify selected");
			
			btn_panzoom.addEventListener(MouseEvent.CLICK,hitbtnpanzoom);
			
			GlobalVars.ArrowSelect = false;
			GlobalVars.ModifyMove = true;
			GlobalVars.EraseObj = false;
			
			adderaselisteners(false);
		}
		
		private function hitbtnerase(evt:MouseEvent)
		{
			drawarea.visible = false;
			trace("eraser selected");
			
			btn_panzoom.addEventListener(MouseEvent.CLICK,hitbtnpanzoom);
			
			GlobalVars.ArrowSelect = false;
			GlobalVars.ModifyMove = false;
			GlobalVars.EraseObj = true;
			
			adderaselisteners(true);
			
		}
		
		private function adderaselisteners(OptErase:Boolean)
		{
			
			
			var i:int;
			var objcnt:int;
			var oa:MovieClip = objarea;
			var obj:Sprite;
			
			objcnt = objarea.numChildren;
			for(i=0;i<objcnt;i++)
			{
				obj = oa.getChildAt(i) as Sprite;
			//polyobj = objarea.getChildAt(i);
				if (OptErase == true)
				{
				obj.addEventListener(MouseEvent.CLICK,eraseobject);
				}
				else
				{
					obj.removeEventListener(MouseEvent.CLICK,eraseobject);
				}
			}
			
		}
		
		
		
		private function eraseobject(evt:MouseEvent)
		{
			trace("erase hit");
			var oa:MovieClip = objarea;
			//var sprobj:Sprite = Sprite(evt.target).parent;
			if (Sprite(evt.target).parent is drawBlock)
			{
				
				oa.removeChild(drawBlock(Sprite(evt.target).parent));	
			}
			else if (Sprite(evt.target).parent is drawCircle)
			{
				oa.removeChild(drawCircle(Sprite(evt.target).parent));	
			}
			else if (Sprite(evt.target).parent is drawPoly)
			{
				oa.removeChild(drawPoly(Sprite(evt.target).parent));	
			}
			else if (Sprite(evt.target) is drawMarker)
			{
				oa.removeChild(drawMarker(Sprite(evt.target)));	
			}
			
		
		}
		
		private function hitbtnmarker(evt:MouseEvent)
		{
			drawarea.visible = true;
			
			
			
			//objarea.addChild(newmarkerobject);
			
			trace("marker tool");
			
			
			btn_marker.removeEventListener(MouseEvent.CLICK,hitbtnmarker);
			
			
			drawarea.addEventListener(MouseEvent.CLICK, dropmarker);
			adderaselisteners(false);
			
		}	

		
		private function dropmarker(evt:MouseEvent)
		{
			
			if (! restrictdraw(evt))
			{
			
				if(newmarkerobject == null || newmarkerobject.objfinished == true)
				{
					newmarkerobject = new drawMarker  ;
					newmarkerobject.name = "Mrkr_"+utils1.dtformat(new Date());;
					
					newmarkerobject.objtype = "Mrkr";
					//objarea.addChild(newmarkerobject);
					actv = false;
					
					newmarkerobject.objfinished = false;
					
				}
			
			
			
				
				if (! actv)
				{
					var mrkcolortrans:ColorTransform = new ColorTransform;
					mrkcolortrans.color = 0xFF0000;
					newmarkerobject.transform.colorTransform = mrkcolortrans;
					
					newmarkerobject.createMarker(evt.stageX,evt.stageY);
					actv = true;
					trace("object finished");
					drawarea.visible = false;
					objarea.addChild(newmarkerobject);
					
					postobjectcreate(newmarkerobject);
					
					btn_marker.addEventListener(MouseEvent.CLICK,hitbtnmarker);
				}
				else
				{
					

						
						
						

						
						
				
				}
				
			}
			//}
		}
		//newshape.graphics.beginFill(0xf0cb00);	
	
	private function postobjectcreate(newobj:Object)
	{
		myusr.createNewMarkerArr(newobj);
		newobj.addEventListener("ObjectChanged",UpdSessObjChange);
		//chgdefcolor();
	}		
			
	private function snapshot(evt:MouseEvent)
	{
		var StageSnap:Snapshot = new Snapshot;
		
		StageSnap.gateway = "snapshot.php";
		StageSnap.capture(this.stage, {
			format: "jpg",
			action: "prompt"//,
			//loader: loader
		});
	}
	
	private function openclosedefaults(evt:MouseEvent)
	{
		if (win_defaults1.visible == false)
		{
			win_defaults1.x = 0;// (stage.width / 2);// - (win_defaults1.width/2);
			win_defaults1.y = 0;//(stage.height / 2);// - (win_defaults1.height/2);
			win_defaults1.visible = true;
			}
			else
			{
				win_defaults1.x = 0;// (stage.width / 2);// - (win_defaults1.width/2);
			win_defaults1.y = 0;//(stage.height / 2);// - (win_defaults1.height/2);
			win_defaults1.visible = false;
				}
		
		
	}
	
	
	
	private function createobjectsfromdb()
	{
	myusr.addEventListener('finishdload',drawdbobjects);
		myusr.loaduserobjects('layout');
		myusr.initload = true;
	}
	
	private function drawdbobjects(evt:Event)
	{
		myusr.removeEventListener("finishdload",drawdbobjects);
	//trace("object data pull complete");
	
	var i:int;
	var onemapobj:usrMapObject;
	var onemapobjdes:usrMapObjectDesign;
	var cntobjects:int;
	
	
	//trace(myusr);
	
	cntobjects = myusr.usrMaps[0].usrMapLayer[0].usrMapObject.length;
	
	
	
	loadMapFile(0);
	
	
	for(i=0;i<cntobjects;i++)
	{
	onemapobj = myusr.usrMaps[0].usrMapLayer[0].usrMapObject[i];
	onemapobjdes = onemapobj.usrMapObjectDesign[0];
	switch(onemapobjdes.ObjType.toUpperCase() )
	{
	case "BLOCK":
		newblockobject = new drawBlock;
		objarea.addChild(newblockobject);
		newblockobject.drawBlockfromDB(onemapobj);
		newblockobject.addEventListener("ObjectChanged",UpdSessObjChange);
		//trace("block drawn");
		break;
	
	case "CIRCLE":
		newcircleobject = new drawCircle;
		objarea.addChild(newcircleobject);
		newcircleobject.drawCirclefromDB(onemapobj);
		newcircleobject.addEventListener("ObjectChanged",UpdSessObjChange);
		//trace("circle drawn");
		break;ipad 3
	
	case "POLY":
		newpolyobject = new drawPoly;
		objarea.addChild(newpolyobject);
		newpolyobject.drawPolyfromDB(onemapobj);
		newpolyobject.addEventListener("ObjectChanged",UpdSessObjChange);
		//newpolyobject.addEventListener("ObjectRemoved",UpdSessObjRemove);
		//trace("poly drawn");
		break;
	
	}
	//trace(onemapobj.ObjName);
	
	}
	
	
	
	
	
	}
	
	
	
	
	
	private function UpdSessObjChange(evt:Event)
	{
	trace("object changed");
	myusr.setFlagChanged(evt.target);
	}
	
	
	private function savelayout(evt:MouseEvent)
	{
		trace("save clicked");
		if(myusr.boardChanged == true)
		{
		myusr.savelayouttodb(); 
		
		}
		else
		{
		trace("Sorry, no changes have been made");
		}
	}
	
	private function hitbtnpanzoom(evt:MouseEvent)
	{
		drawarea.visible = true;
		
		trace("panzoom");
		
		
		
		
		adderaselisteners(false);
		
		enablepanzoom();
	}
	
	
	private function enablepanzoom()
	{
		pz.old_center = new Point();
		pz.new_center = new Point();
		
		// Listeners for starting/stopping panning.
		drawarea.addEventListener(MouseEvent.MOUSE_DOWN, startPan);
		mapimg.addEventListener(MouseEvent.MOUSE_DOWN, startPan);
		objarea.addEventListener(MouseEvent.MOUSE_DOWN, startPan);
		stage.addEventListener(MouseEvent.MOUSE_UP, stopPan);
	
	}
	
	function startPan(me:MouseEvent):void {
		
		
		pz.old_xmin = Math.abs(mapimg.x);
		pz.old_xmax = pz.old_xmin + stage.stageWidth;//mapimg.x + mapimg.width;
		pz.old_ymin = Math.abs(mapimg.y);
		pz.old_ymax = pz.old_ymin + stage.stageHeight;
		
		pz.old_center = new Point(stage.mouseX, stage.mouseY);
		pz.new_center = new Point(stage.mouseX, stage.mouseY);
		
		/* 
		The actual panning is tied to the ENTER_FRAME event in order to get the easing effect 
		described in Dan Gries' tutorial, Easing without the Tween class. 
		*/
		stage.addEventListener(Event.ENTER_FRAME, pan);
	}
	
	// When panning is stopped, we call drawGraph to draw all the details of the graph.
	function stopPan(me:MouseEvent):void {
		stage.removeEventListener(Event.ENTER_FRAME, pan);
		
	}
	
	
	function pan(e:Event):void {
		
		var deltax:Number, deltay:Number;
		var goodPoint:Point = new Point(stage.mouseX, stage.mouseY);
		
		/* 
		The variable goodPoint is initially the mouse coordinates (in pixels) but the following code keeps it from going beyond the boundaries of the SimpleGraph object g.
		*/
		trace("good point is "+goodPoint);
		trace("pz new center is " + pz.new_center);
		if (goodPoint.x > pz.bWidth) {
			goodPoint.x = pz.bWidth;
		}
		else if (goodPoint.x  < 0) {
			goodPoint.x = 0;
		}
		
		if (goodPoint.y > pz.bHeight) {
			goodPoint.y = pz.bHeight;
		}
		else if (goodPoint.y  < 0) {
			goodPoint.y = 0;
		}
		
		
		
		pz.new_center.x += pz.responsiveness*(goodPoint.x - pz.new_center.x);
		pz.new_center.y += pz.responsiveness*(goodPoint.y - pz.new_center.y);
		
		//if(Math.abs(pz.old_center.x - pz.new_center.x) > 5 || Math.abs(pz.new_center.y - pz.old_center.y) > 5)
		//{
		//trace("inside");
		//trace(pz.xfromPix(pz.old_center.x) + " - " + pz.old_center.x + "xxxx" + pz.xfromPix(pz.new_center.x) + " - " + pz.new_center.x);
		
		// Find how far the graph needs to be shifted horizontally and vertically.
		
		deltax = pz.xfromPix(pz.new_center.x) - pz.xfromPix(pz.old_center.x);
		deltay = pz.yfromPix(pz.old_center.y) - pz.yfromPix(pz.new_center.y);
		//trace("delta:::: " + deltax + " xxxx " + deltay);
		
		
		 
		panobjects(deltax,deltay);
		
		//pz.old_center = pz.new_center;
		//}
	}
	
	function panobjects(dx:Number,dy:Number)
	{
		
		
		
		
		if((mapimg.x + dx) <= 0 && ((mapimg.width - Math.abs(mapimg.x)) + dx >= stage.stageWidth)  )
		{
		mapimg.x = mapimg.x + dx;
		objarea.x = objarea.x + dx;	
		drawarea.x = drawarea.x + dx;
		
		pz.new_xmin = pz.old_xmin + dx;
		pz.new_xmax = pz.old_xmax + dx;
		
		}
		else
		{
		if(dx > 0)
		{
		mapimg.x = 0;
		objarea.x = 0;
		drawarea.x = 0;
		
		pz.new_xmin = 0;
		pz.new_xmax = stage.stageWidth;
		}
		if(dx < 0)
		{
		mapimg.x = stage.stageWidth - mapimg.width;
		objarea.x = stage.stageWidth - mapimg.width;
		drawarea.x = stage.stageWidth - mapimg.width;
		
		pz.new_xmin = Math.abs(mapimg.x);
		pz.new_xmax = mapimg.width;
		}
		
		}
		
		if((mapimg.y + dy) <= 0  && ((mapimg.height - Math.abs(mapimg.y)) + dy >= stage.stageHeight))
		{
		mapimg.y = mapimg.y + dy;
		objarea.y = objarea.y + dy;		
		drawarea.y = drawarea.y + dy;
		
		pz.new_ymin = pz.old_ymin + dy;
		pz.new_ymax = pz.old_ymax + dy;
		}
		else
		{
		if(dy > 0)
		{
			mapimg.y = 0;
			objarea.y = 0;
			drawarea.y = 0;
		
			pz.new_ymin = 0;
			pz.new_ymax = stage.stageHeight;
		}
		if(dy < 0)
		{
			mapimg.y = stage.stageHeight - mapimg.height;
			objarea.y = stage.stageHeight - mapimg.height;
			drawarea.y = stage.stageHeight - mapimg.height;
		
			pz.new_ymin = Math.abs(mapimg.y);
			pz.new_ymax = mapimg.height;
		}
			
			
			
		}
	
	
	
	}	
		
		
	

	
	
	
}
}