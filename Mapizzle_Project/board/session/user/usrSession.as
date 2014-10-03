package board.session.user
{
	
	import board.objects.controls.drawBlock;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.xml.*;
	
	public class usrSession extends Sprite
	{
		public var userid:String;
		public var accountid:String;
		
		public var usrMaps:Array; 
		public var boardChanged:Boolean;
		public var loader:URLLoader;
		public var initload:Boolean;
		
		public function usrSession()
		{
			this.name = "usrSession";
			loader =new URLLoader();
			usrMaps = new Array();
		}
		
		public function loaduserobjects(maptype:String)
		{
			//var tempmapobjXML:XML = new XML;
			var request:URLRequest;
			
			loader.addEventListener(Event.COMPLETE,completeLoadHandler);
			if(maptype=="board")
			{
			request=new URLRequest('http://localhost/mapizzle/getMapObjects.php');
			}
			
			if(maptype=="layout")
			{
			request=new URLRequest('http://localhost/mapizzle/getMapLayout.php');
			}
			
			try 
			{
				loader.load(request);
			} 
			catch(error:Error) 
			{
				
				trace('Error encountered');
			}
			finally
			{
			request = null;
			//loader = null;
			}
			
			
		}
		
		

		
		public function dbfillusr(xmlstr:String)
		{
			trace(xmlstr);
			var result:XML=new XML(xmlstr);
			var myXML:XMLDocument=new XMLDocument();
			myXML.ignoreWhite=true;
			myXML.parseXML(result.toXMLString());
			//trace(myXML);
			 
			
			//var mapnode:XMLNode=myXML.firstChild;
			accountid = myXML.firstChild.attributes.accountid;
			userid = myXML.firstChild.attributes.userid;
			
			var cntmaps:int = myXML.firstChild.childNodes.length;
			var i:int;
			
			
			
			for(i=0; i< cntmaps; i++) //create layers of maps
			{
				//trace(myXML.firstChild.childNodes[i].attributes.mapname);
				 
				var onemap:usrMap = new usrMap;
				var mapnode:XMLNode=myXML.firstChild.childNodes[i];
				
				onemap.mapID = mapnode.attributes.mapID;
				onemap.mapName = mapnode.attributes.mapname;
				onemap.mapTitle = mapnode.attributes.maptitle;
				onemap.mapDescription = mapnode.attributes.mapDescription;
				onemap.mapCreatorID = mapnode.attributes.mapCreatorID;
				onemap.mapCurrFileIndex = 0;
				onemap.mapCurrFileID = mapnode.attributes.mapFileID;
				onemap.mapCurrFileName = mapnode.attributes.mapFileName;
				
				 
				
				var cntmapfiles:int = mapnode.childNodes[0].childNodes.length; 
				var f:int;
				onemap.usrMapFile = new Array;
				
				for(f=0; f< cntmapfiles; f++) //create map file objects
				{
				var onemapfile:usrMapFile = new usrMapFile;
				var mapfilenode:XMLNode=mapnode.childNodes[0].childNodes[f];
				
				onemapfile.mapFileID = mapfilenode.attributes.mapfileID;
				onemapfile.mapFileName = mapfilenode.attributes.mapfileName;
				onemapfile.mapFileTitle = mapfilenode.attributes.mapfileTitle;
				onemapfile.mapFileDescription = mapfilenode.attributes.mapfileDescription;
				onemapfile.activeSW = mapfilenode.attributes.activeSW;
				onemapfile.physfileName = mapfilenode.attributes.physfileName;
				onemapfile.physfileDimWidth= mapfilenode.attributes.physfileDimWidth;
				onemapfile.physfileDimHeight= mapfilenode.attributes.physfileDimHeight;
				onemapfile.stageX = mapfilenode.attributes.stageX;
				onemapfile.stageY = mapfilenode.attributes.stageY;
				onemapfile.mapFileChanged = false;
				onemapfile.newObject = false;
				
				var cntmapfilemarkers:int = mapfilenode.childNodes.length;
				var g:int;
				onemapfile.usrMapMarker = new Array;
				
				for(g=0; g < cntmapfilemarkers;g++)
				{	
					var onemapmarker:usrMapFileMarker = new usrMapFileMarker;
					var mapfilemarkernode:XMLNode=mapfilenode.childNodes[g];
					
					onemapmarker.mfMarkerID = mapfilemarkernode.attributes.mfmarkerID;
					onemapmarker.mfMarkerName = mapfilemarkernode.attributes.mfmarkerName;
					onemapmarker.mfMarkerTitle = mapfilemarkernode.attributes.mfmarkerTitle;
					onemapmarker.mfMarkerDescription = mapfilemarkernode.attributes.mfmarkerDescription;
					onemapmarker.activeSW = mapfilemarkernode.attributes.activeSW;
					onemapmarker.PosRelStgX = mapfilemarkernode.attributes.PosRelStgX;
					onemapmarker.PosRelStgY = mapfilemarkernode.attributes.PosRelStgY;
					onemapmarker.PosRelmfX = mapfilemarkernode.attributes.PosRelmfX;
					onemapmarker.PosRelmfY = mapfilemarkernode.attributes.PosRelmfY;
					onemapmarker.newObject = false;
					onemapmarker.mapMarkerChanged = false;
					onemapfile.usrMapMarker.push(onemapmarker);
				}
				
				onemap.usrMapFile.push(onemapfile);
				}
				
				
				
				
				var cntmaplayers:int = mapnode.childNodes.length-1;
				var m:int;
				onemap.usrMapLayer = new Array;	
				
				for(m=0; m< cntmaplayers; m++) //create map layer objects
				{
					var onemaplayer:usrMapLayer = new usrMapLayer;
					var maplayernode:XMLNode=mapnode.childNodes[m+1];
					
					
					onemaplayer.layerID = maplayernode.attributes.layerID;
					onemaplayer.layerName = maplayernode.attributes.layername;
					onemaplayer.layerTitle = maplayernode.attributes.layertitle;
					onemaplayer.layerDescription = maplayernode.attributes.layerdescription;
					
					 
					
				var cntmapobjects:int = maplayernode.childNodes.length;
				var j:int;
				
				onemaplayer.usrMapObject = new Array;	
				
				for(j=0; j< cntmapobjects; j++) //create map objects
				{
					var onemapobject:usrMapObject = new usrMapObject;
					var mapobjectnode:XMLNode=maplayernode.childNodes[j];
					
					onemapobject.ObjID = mapobjectnode.attributes.objID;
					onemapobject.ObjName = mapobjectnode.attributes.objName;
					onemapobject.Description = mapobjectnode.attributes.description;
					onemapobject.Title = mapobjectnode.attributes.objtitle;
					onemapobject.Priority = mapobjectnode.attributes.priority;
					onemapobject.Area = mapobjectnode.attributes.area;
					onemapobject.CreatorID = mapobjectnode.attributes.creatorid;
					onemapobject.RelObjID = mapobjectnode.attributes.RelObjID;
					onemapobject.HasAttach = convbool(mapobjectnode.attributes.hasattach);
					onemapobject.HasSchedule = convbool(mapobjectnode.attributes.hasschedule);
					onemapobject.HasShare =convbool( mapobjectnode.attributes.hasshare);
					onemapobject.HasNotes = convbool(mapobjectnode.attributes.hasnotes);
					onemapobject.HasTasks = convbool(mapobjectnode.attributes.hastasks);
					onemapobject.HasConvo = convbool(mapobjectnode.attributes.hasconvo);
					
					onemapobject.newObject = false;
					
					
					var cntobjectdesigns:int = mapobjectnode.childNodes.length;
					var k:int;
					
					onemapobject.usrMapObjectDesign = new Array;
					
					for(k=0; k< cntobjectdesigns; k++) //create map object designs
					{
						
					var onemapobjectdesign:usrMapObjectDesign = new usrMapObjectDesign;
					var mapobjectdesignnode:XMLNode = mapobjectnode.childNodes[k];
					
					onemapobjectdesign.idobjDesign = mapobjectdesignnode.attributes.designid;
					onemapobjectdesign.ObjType = mapobjectdesignnode.attributes.objtype;
					onemapobjectdesign.FillColour = mapobjectdesignnode.attributes.fillcolour;
					onemapobjectdesign.FillAlpha= mapobjectdesignnode.attributes.fillalpha;
					onemapobjectdesign.StrokeColour= mapobjectdesignnode.attributes.strokecolour;
					onemapobjectdesign.StrokeAlpha = mapobjectdesignnode.attributes.strokealpha;
					onemapobjectdesign.StrokeWidth= mapobjectdesignnode.attributes.strokewidth;
					onemapobjectdesign.PosRelStgX = mapobjectdesignnode.attributes.posrelstgx;
					onemapobjectdesign.PosRelStgY = mapobjectdesignnode.attributes.posrelstgy;
					onemapobjectdesign.PosRelObjX = mapobjectdesignnode.attributes.posrelobjx;
					onemapobjectdesign.PosRelObjY = mapobjectdesignnode.attributes.posrelobjy;
					onemapobjectdesign.SizeRadius = mapobjectdesignnode.attributes.sizeradius;
					onemapobjectdesign.SizeWidth = mapobjectdesignnode.attributes.sizewidth;
					onemapobjectdesign.SizeHeight = mapobjectdesignnode.attributes.sizeheight;
					onemapobjectdesign.FirstPosX = mapobjectdesignnode.attributes.firstposx;
					onemapobjectdesign.FirstPosY = mapobjectdesignnode.attributes.firstposy;
					onemapobjectdesign.NodeCnt = mapobjectdesignnode.attributes.nodecnt;
					onemapobjectdesign.Block_topLeftX = mapobjectdesignnode.attributes.blocktopleftx;
					onemapobjectdesign.Block_topLeftY = mapobjectdesignnode.attributes.blocktoplefty;
					onemapobjectdesign.Block_botRightX = mapobjectdesignnode.attributes.blockbotrightx;
					onemapobjectdesign.Block_botRightY = mapobjectdesignnode.attributes.blockbotrighty;
					onemapobjectdesign.Circle_centreX= mapobjectdesignnode.attributes.circlecentrex;
					onemapobjectdesign.Circle_centreY = mapobjectdesignnode.attributes.circlecentrey;
					onemapobjectdesign.Circle_circumX = mapobjectdesignnode.attributes.circlecircumx;
					onemapobjectdesign.Circle_circumY = mapobjectdesignnode.attributes.circlecircumy;
					onemapobjectdesign.Circle_radius = mapobjectdesignnode.attributes.circleradius;
					onemapobjectdesign.Poly_firstX= mapobjectdesignnode.attributes.polyfirstx;
					onemapobjectdesign.Poly_firstY = mapobjectdesignnode.attributes.polyfirsty;
					onemapobjectdesign.Poly_lastX = mapobjectdesignnode.attributes.polylastx;
					onemapobjectdesign.Poly_lastY = mapobjectdesignnode.attributes.polylasty;
						
					
					var cntmapobjectnodes:int = mapobjectdesignnode.firstChild.childNodes.length;
					var l:int;
					
					onemapobjectdesign.usrMapObjectDesignNodes = new Array;
					
					for(l=0; l< cntmapobjectnodes; l++) //create map object design nodes
					{
						var onemapobjectdesignnode:usrMapObjectDesignNodes = new usrMapObjectDesignNodes;
						var mapobjectdesignnodenode:XMLNode = mapobjectdesignnode.firstChild.childNodes[l];
						
						onemapobjectdesignnode.objnodeID = mapobjectdesignnodenode.attributes.objnodeid;
						onemapobjectdesignnode.objdesignID = mapobjectdesignnodenode.attributes.objdesignid;
						onemapobjectdesignnode.pointNum = mapobjectdesignnodenode.attributes.pointnum;
						onemapobjectdesignnode.pointX = mapobjectdesignnodenode.attributes.pointx;
						onemapobjectdesignnode.pointY= mapobjectdesignnodenode.attributes.pointy;
						onemapobjectdesignnode.nodeName = mapobjectdesignnodenode.attributes.nodename;
						onemapobjectdesignnode.nodeRadius = mapobjectdesignnodenode.attributes.noderadius;
						onemapobjectdesignnode.nodeFillColour = mapobjectdesignnodenode.attributes.nodefillcolour;
						onemapobjectdesignnode.nodeFillAlpha = mapobjectdesignnodenode.attributes.nodefillalpha;
						onemapobjectdesignnode.nodeStrokeColour = mapobjectdesignnodenode.attributes.nodestrokecolour;
						onemapobjectdesignnode.nodeStrokeAlpha = mapobjectdesignnodenode.attributes.nodestrokealpha;
						onemapobjectdesignnode.nodeStrokeWidth = mapobjectdesignnodenode.attributes.nodestrokewidth;
						
						onemapobjectdesign.usrMapObjectDesignNodes.push(onemapobjectdesignnode);
					}
					
					onemapobject.usrMapObjectDesign.push(onemapobjectdesign);
						
					}				
					
					onemaplayer.usrMapObject.push(onemapobject);
					
				}
				
				onemap.usrMapLayer.push(onemaplayer); 
				
				}
				
				usrMaps.push(onemap);
				
			}// end of map creation
			
			xmlstr = null;
			result = null;
			myXML = null;
			mapnode = null;
			maplayernode = null;
			mapobjectnode = null;
			mapobjectdesignnode = null;
			mapobjectdesignnodenode = null;
			onemap = null;
			onemaplayer = null;
			onemapobject = null;
			onemapobjectdesign = null;
			onemapobjectdesignnode = null;
			//trace(usrMaps);
		}
		
		private function convbool(itm:String) :Boolean
		{
			if(itm=="true"||itm=="1")
			{return true;}
			else if(itm=="false"||itm=="0")
			{return false;}
			else
			return false;
			
			}
		
		public function completeLoadHandler(event:Event):void
		{	
		loader.removeEventListener(Event.COMPLETE,completeLoadHandler);
			dbfillusr(event.target.data);
			
			//var n:int=node.childNodes.length;
			
			
			var finevt:Event = new Event("finishdload");
			dispatchEvent(finevt);
		}
		
		public function setFlagChanged(chgobj:Object)
		{
			
			this.boardChanged = true;
			var onemap:usrMap = new usrMap;
			var onemaplayer:usrMapLayer = new usrMapLayer;	
			var onemapobj:usrMapObject;
			var onemapobjectdesign:usrMapObjectDesign;
			var onemapfile:usrMapFile = new usrMapFile;
			var onemapfilemarker:usrMapFileMarker = new usrMapFileMarker;
		
			
		for(var g=0;g < this.usrMaps.length ; g++)
		{
				onemap = this.usrMaps[g];
				
			for(var t=0;t < onemap.usrMapFile.length; t++)
			{
				onemapfile = onemap.usrMapFile[t];
				//if (onemapfile.mapFileChanged == true)
				//{
					for(var u=0;u < onemapfile.usrMapMarker.length; u++)
					{
						onemapfilemarker = onemapfile.usrMapMarker[u];
						
						if(onemapfilemarker.mfMarkerName == chgobj.name)
						{
							onemapfilemarker.mapMarkerChanged = true; 
							
							this.usrMaps[g].usrMapFile[t].mapFileChanged = true;
							this.usrMaps[g].mapChanged = true;
							
							if (chgobj.positionChanged == true)
								{
									onemapfilemarker.positionChanged = true;
									chgobj.positionChanged = false;
									this.usrMaps[g].usrMapFile[t].usrMapMarker[u].PosRelStgX = chgobj.x;
									this.usrMaps[g].usrMapFile[t].usrMapMarker[u].PosRelStgY = chgobj.y;
								}
							
							if (chgobj.mainObjDeleted == true)
								{
									if (onemapfilemarker.newObject == false)
									{
										onemapfilemarker.objDeleted  = true;
									}
									else
									{
										this.usrMaps[g].usrMapFile[t].usrMapMarker.splice(u,1);
									}
									
								}
								
						}
					}
				//}
			
			}
			
			for(var h=0;h < this.usrMaps[g].usrMapLayer.length ; h++)
			{
				onemaplayer = this.usrMaps[g].usrMapLayer[h];
					
			for(var i=0;i < this.usrMaps[g].usrMapLayer[h].usrMapObject.length; i++)
			{
			onemapobj = this.usrMaps[g].usrMapLayer[h].usrMapObject[i];
			onemapobjectdesign = onemapobj.usrMapObjectDesign[0];
			if (onemapobj.ObjName ==chgobj.name)
			{
			onemapobj.mapObjectChanged = true; 
			this.usrMaps[g].usrMapLayer[h].maplayerChanged = true;
			this.usrMaps[g].mapChanged = true;
			
			
			if (chgobj.designChanged == true)
			{
				onemapobj.designChanged = true;
				chgobj.designChanged == false;
				
				//var onemapobjectdesign:usrMapObjectDesign = onemapobj.usrMapObjectDesign[0];
				
				
				
				onemapobjectdesign.FillColour = chgobj.objfillcolor;
				onemapobjectdesign.FillAlpha= chgobj.objfillalpha;
				onemapobjectdesign.StrokeColour= chgobj.objstrokecolor;
				onemapobjectdesign.StrokeAlpha = chgobj.objstrokealpha;
				onemapobjectdesign.StrokeWidth= chgobj.objstrokewidth;
				
				//var onemapobjectdesign:usrMapObjectDesign = onemapobj.usrMapObjectDesign[0];
				var onemapobjectdesignnode:usrMapObjectDesignNodes;
				
				for( var j = 0 ; j < onemapobjectdesign.usrMapObjectDesignNodes.length; j ++)
				{
					onemapobjectdesignnode = onemapobjectdesign.usrMapObjectDesignNodes[j];
					
					onemapobjectdesignnode.nodeFillColour = chgobj.objnodefillcolor;
					onemapobjectdesignnode.nodeFillAlpha = chgobj.objnodefillalpha;
					onemapobjectdesignnode.nodeStrokeColour = chgobj.objnodestrokecolor;
					onemapobjectdesignnode.nodeStrokeAlpha = chgobj.objnodestrokealpha;
					onemapobjectdesignnode.nodeStrokeWidth = chgobj.objnodestrokewidth;
					onemapobjectdesignnode.nodeRadius = chgobj.objnoderadius;
					
					onemapobjectdesign.usrMapObjectDesignNodes[j] = onemapobjectdesignnode ;
				}
				
			} //end of if design changed
			
			
			
			
			
			if (chgobj.positionChanged == true)
			{
				onemapobj.positionChanged = true;
				chgobj.positionChanged == false;
				
				/*
				onemapobjectdesign.PosRelStgX = chgobj.posrelstgx;
				onemapobjectdesign.PosRelStgY = chgobj.posrelstgy;
				onemapobjectdesign.PosRelObjX = chgobj.posrelobjx;
				onemapobjectdesign.PosRelObjY = chgobj.posrelobjy;
				*/
				
				
				
				onemapobjectdesign.PosRelStgX = chgobj.x;
				onemapobjectdesign.PosRelStgY = chgobj.y;
				
				
				
				
				
			} // end of if position changed
			
			
				
			if (chgobj.nodeChanged == true)
			{
				onemapobj.nodeChanged = true;
				chgobj.nodeChanged == false;
				

				
				for(var k = 0 ; k < onemapobjectdesign.usrMapObjectDesignNodes.length; k ++)
				{
					onemapobjectdesignnode = onemapobjectdesign.usrMapObjectDesignNodes[k];
					
					onemapobjectdesignnode.pointNum = chgobj.shapepoints[k].pointnum;
					onemapobjectdesignnode.pointX = chgobj.shapepoints[k].pointX;
					onemapobjectdesignnode.pointY = chgobj.shapepoints[k].pointY;
					onemapobjectdesignnode.nodeName = chgobj.shapepoints[k].nodename;
					
					
					onemapobjectdesign.usrMapObjectDesignNodes[k] = onemapobjectdesignnode ;
				}
				
				
				onemapobjectdesign.SizeWidth = chgobj.width;
				onemapobjectdesign.SizeHeight = chgobj.height;
				
				switch (chgobj.objtype)
				{
					case "BLOCK":
						onemapobjectdesign.Block_topLeftX = chgobj.topleftX;
						onemapobjectdesign.Block_topLeftY = chgobj.topleftY;
						onemapobjectdesign.Block_botRightX = chgobj.botrightX;
						onemapobjectdesign.Block_botRightY = chgobj.botrightY;
						break;
					case "CIRCLE":
						
						onemapobjectdesign.SizeRadius = chgobj.radius;
						onemapobjectdesign.Circle_centreX= chgobj.centreX;
						onemapobjectdesign.Circle_centreY = chgobj.centreY;
						onemapobjectdesign.Circle_circumX = chgobj.circumX;
						onemapobjectdesign.Circle_circumY = chgobj.circumY;
						onemapobjectdesign.Circle_radius = chgobj.radius;
						break;
					
					case "POLY":
						onemapobjectdesign.NodeCnt = chgobj.pointcnt;
						onemapobjectdesign.FirstPosX = chgobj.firstpointX;
						onemapobjectdesign.FirstPosY = chgobj.firstpointX;
						onemapobjectdesign.Poly_firstX= chgobj.firstpointX;
						onemapobjectdesign.Poly_firstY = chgobj.firstpointY;
						onemapobjectdesign.Poly_lastX = chgobj.lastpointX;
						onemapobjectdesign.Poly_lastY = chgobj.lastpointY;
						break;
					
				}
				
				onemapobj.usrMapObjectDesign[0] = onemapobjectdesign;
				
				
				
			}
			
			
			if(chgobj.mainObjDeleted == true)
			{
				if (onemapobj.newObject == false)
				{
					onemapobj.objDeleted = true;
					}
					else
					{
						this.usrMaps[g].usrMapLayer[h].usrMapObject.splice(i,1);
						}
			
			
			}
				
			
			
			
			
			
			
			
			
			}
		} //end of map object loop
			}//end of map layer loop
			}//end of map loop
		} //end of object changed
		
		public function saveobjectupdatestodb()
		{
			var mapupdDBXML:XML = new XML(createXMLfromObjects());
			saveobjects(mapupdDBXML);
		}
		
		
		
		public function saveobjects(mapxml:XML)
		{
			//var tempmapobjXML:XML = new XML;
			var saveloader:URLLoader=new URLLoader();
			
			saveloader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);

			saveloader.addEventListener(Event.COMPLETE,completeSaveHandler, false, 0, true);
			
			var saverequest:URLRequest=new URLRequest('http://localhost/mapizzle/saveMapObjects.php');
			
			saverequest.method = URLRequestMethod.POST;
			saverequest.contentType = "text/xml";
			saverequest.data = mapxml;
			try 
			{
				saveloader.load(saverequest);
			} 
			catch(error:Error) 
			{
				
				trace('Error encountered: ' + error.message);
			}
			finally
			{
				saverequest = null;
			}
			
			
		}
		
		
		
		private function createXMLfromObjects():String
		{
			var mainstr:String;
			try
			{
		
		mainstr = "<?xml version=\"1.0\" ?>";
		mainstr += "<totalmap userid =\"" + this.userid + "\" accountid = \"" + this.accountid + "\" boardchanged=\"" + this.boardChanged + "\" >";
		
		var om:usrMap;
		var oml:usrMapLayer;
		var omlo:usrMapObject;
		var omod:usrMapObjectDesign;
		var omodn:usrMapObjectDesignNodes;
		for(var a=0; a < usrMaps.length; a++)
		{
			om = usrMaps[a];
			if(om.mapChanged == true)
			{
			mainstr += "<map mapID=\"" + om.mapID + "\" mapname=\"" + om.mapName + "\" maptitle=\"" + om.mapTitle + "\" mapDescription=\"" + om.mapDescription + "\" mapCreatorID=\"" + om.mapCreatorID + "\" mapchanged=\"" + om.mapChanged + "\">";
		
			
			for(var b = 0; b < om.usrMapLayer.length ; b ++)
			{
				oml = om.usrMapLayer[b];
				if (oml.maplayerChanged == true)
				{
				mainstr += "<maplayer layerID=\""+ oml.layerID + "\" layername=\""+ oml.layerName +"\" layertitle=\""+ oml.layerTitle +"\" layerdescription=\""+ oml.layerDescription +"\" maplayerchanged=\"" + oml.maplayerChanged + "\">";
				
				for(var c = 0; c < oml.usrMapObject.length ; c ++)
				{
					omlo = oml.usrMapObject[c];
				if (omlo.mapObjectChanged == true || omlo.newObject == true || omlo.objDeleted == true)
				{
					mainstr += "<mapobject objID=\""+ omlo.ObjID + "\" objName=\""+ omlo.ObjName + "\"  objtitle=\""+ omlo.Title + "\"  description=\""+ omlo.Description + "\"  priority=\""+ omlo.Priority + "\"  area=\""+ omlo.Area + "\"  creatorid=\""+ omlo.CreatorID + "\" layerid=\""+ oml.layerID+ "\" relobjid=\""+ omlo.RelObjID + "\"  hasattach=\""+ omlo.HasAttach + "\"  hasschedule=\""+ omlo.HasSchedule + "\"  hasshare=\""+ omlo.HasShare + "\"  hasnotes=\""+ omlo.HasNotes + "\"  hastasks=\""+ omlo.HasTasks + "\"  hasconvo=\""+ omlo.HasConvo + "\" mapobjectchanged=\"" + omlo.mapObjectChanged + "\" designchanged=\"" + omlo.designChanged + "\" positionchanged=\"" + omlo.positionChanged + "\" nodechanged=\"" + omlo.nodeChanged + "\" newObject=\"" + omlo.newObject + "\" delObject=\"" + omlo.objDeleted + "\" >";

					for(var d = 0; d < omlo.usrMapObjectDesign.length ; d ++)
					{
						omod = omlo.usrMapObjectDesign[d];
						
						mainstr += "<objectdesign designid=\""+ omod.idobjDesign + "\"  objtype=\""+ omod.ObjType + "\" fillcolour=\""+ omod.FillColour + "\"  fillalpha=\""+ omod.FillAlpha + "\"  strokecolour=\""+ omod.StrokeColour + "\"  strokealpha=\""+ omod.StrokeAlpha + "\"  strokewidth=\""+ omod.StrokeWidth + "\"  posrelstgx=\""+ omod.PosRelStgX + "\"  posrelstgy=\""+ omod.PosRelStgY + "\"  posrelobjx=\""+ omod.PosRelObjX + "\"  posrelobjy=\""+ omod.PosRelObjY + "\"  sizeradius=\""+ omod.SizeRadius + "\"  sizewidth=\""+ omod.SizeWidth + "\"  sizeheight=\""+ omod.SizeHeight + "\"  firstposx=\""+ omod.FirstPosX + "\"  firstposy=\""+ omod.FirstPosY + "\"  nodecnt=\""+ omod.NodeCnt + "\"  blocktopleftx=\""+ omod.Block_topLeftX + "\"  blocktoplefty=\""+ omod.Block_topLeftY + "\"  blockbotrightx=\""+ omod.Block_botRightX + "\"  blockbotrighty=\""+ omod.Block_botRightY + "\"  circlecentrex=\""+ omod.Circle_centreX + "\"  circlecentrey=\""+ omod.Circle_centreY + "\"  circlecircumx=\""+ omod.Circle_circumX + "\"  circlecircumy=\""+ omod.Circle_circumY + "\"  circleradius=\""+ omod.Circle_radius + "\"  polyfirstx=\""+ omod.Poly_firstX + "\"  polyfirsty=\""+ omod.Poly_firstY + "\"  polylastx=\""+ omod.Poly_lastX + "\"  polylasty=\""+ omod.Poly_lastY + "\" >";
					
						mainstr += "<objnodeCollection>";
						for(var e = 0; e < omod.usrMapObjectDesignNodes.length; e ++)
						{
							omodn = omod.usrMapObjectDesignNodes[e];
							
							mainstr += "<objectnode objnodeid=\""+ omodn.objnodeID + "\"  objdesignid=\""+ omodn.objdesignID + "\"  pointnum=\""+ omodn.pointNum + "\"  pointx=\""+ omodn.pointX + "\"  pointy=\""+ omodn.pointY + "\"  nodename=\""+ omodn.nodeName + "\"  noderadius=\""+ omodn.nodeRadius + "\"  nodefillcolour=\""+ omodn.nodeFillColour + "\"  nodefillalpha=\""+ omodn.nodeFillAlpha + "\"  nodestrokecolour=\""+ omodn.nodeStrokeColour + "\"  nodestrokealpha=\""+ omodn.nodeStrokeAlpha + "\"  nodestrokewidth=\""+ omodn.nodeStrokeWidth + "\"  />";
						
						}
						mainstr += "</objnodeCollection>";
						mainstr += "</objectdesign>";
					}
					
					mainstr += "</mapobject>";
				} //end of if map object changed
				}			
				
				mainstr += "</maplayer>";	
				}//end of if map layer changed
			}
		
		
		
		mainstr += "</map>";
			}//end of if map changed
		
		}
		
		mainstr +="</totalmap>";
		//trace(mainstr);	

		om = null;
		oml = null;
		omlo = null;
		omod = null;
		omodn = null;
		//trace(mainstr);
		
		}
		catch(error:Error) 
			{
				
				trace("Error encountered: " + error.message);
			}
		finally
		{
			return mainstr;
		}
		}
		
		
		function completeSaveHandler(evt:Event):void {
			try {
				var xmlResponse:XML;
				//xmlResponse = new XML(evt.target.data);
				trace( evt.target.data);
				removeEventListener(Event.COMPLETE, completeSaveHandler);
				removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			} catch (err:TypeError) {
				//respTxt.text = 
				trace("An error occured when communicating with server:\n" + err.message);
			}
			
		}

		
		function onIOError(evt:IOErrorEvent):void {
			//respTxt.text = 
			trace("An error occurred when attempting to load the XML.\n" + evt.text);
			//placeText();
		}
		
		
		public function createNewObjectArr(newobj:Object)
		{
		
			this.boardChanged = true;
			this.usrMaps[0].usrMapLayer[0].maplayerChanged = true;
			this.usrMaps[0].mapChanged = true;
			var onemapobject:usrMapObject = new usrMapObject;
			
			
			
			onemapobject.ObjName = newobj.name;
			onemapobject.Description = newobj.objopt.objdescription;
			onemapobject.Title = newobj.objopt.objtitle;
			onemapobject.Priority = newobj.objopt.objpriority;
			onemapobject.Area = newobj.objopt.objarea;
			onemapobject.CreatorID = 1;//this.accountid;
			onemapobject.RelObjID =  0;
			onemapobject.HasAttach = convbool("0");
			onemapobject.HasSchedule = convbool("0");
			onemapobject.HasShare = convbool("0");
			onemapobject.HasNotes = convbool("0");
			onemapobject.HasTasks = convbool("0");
			onemapobject.HasConvo = convbool("0");
			
			onemapobject.newObject = true;
			
			var cntobjectdesigns:int = 1;
			var k:int;
			
			onemapobject.usrMapObjectDesign = new Array;
			
			for(k=0; k< cntobjectdesigns; k++) //create map object designs
			{
				
				var onemapobjectdesign:usrMapObjectDesign = new usrMapObjectDesign;
				
				
				
				onemapobjectdesign.ObjType = newobj.objtype;
				onemapobjectdesign.FillColour = newobj.objfillcolor;
				onemapobjectdesign.FillAlpha= newobj.objfillalpha;
				onemapobjectdesign.StrokeColour= newobj.objstrokecolor;
				onemapobjectdesign.StrokeAlpha = newobj.objstrokealpha;
				onemapobjectdesign.StrokeWidth= newobj.objstrokewidth;
				onemapobjectdesign.PosRelStgX = newobj.x;
				onemapobjectdesign.PosRelStgY = newobj.y;
				onemapobjectdesign.PosRelObjX = 0;
				onemapobjectdesign.PosRelObjY = 0;
				
				onemapobjectdesign.SizeWidth = newobj.width;
				onemapobjectdesign.SizeHeight = newobj.height;
				onemapobjectdesign.NodeCnt = newobj.pointcnt;
								
				switch (newobj.objtype.toUpperCase())
				{
					case "BLOCK":
						onemapobjectdesign.Block_topLeftX = newobj.topleftX;
						onemapobjectdesign.Block_topLeftY = newobj.topleftY;
						onemapobjectdesign.Block_botRightX = newobj.botrightX;
						onemapobjectdesign.Block_botRightY = newobj.botrightY;
						break;
					case "CIRCLE":
						
						onemapobjectdesign.SizeRadius = newobj.radius;
						onemapobjectdesign.Circle_centreX= newobj.centreX;
						onemapobjectdesign.Circle_centreY = newobj.centreY;
						onemapobjectdesign.Circle_circumX = newobj.circumX;
						onemapobjectdesign.Circle_circumY = newobj.circumY;
						onemapobjectdesign.Circle_radius = newobj.radius;
						break;
					
					case "POLY":
						
						onemapobjectdesign.FirstPosX = newobj.firstpointX;
						onemapobjectdesign.FirstPosY = newobj.firstpointX;
						onemapobjectdesign.Poly_firstX= newobj.firstpointX;
						onemapobjectdesign.Poly_firstY = newobj.firstpointY;
						onemapobjectdesign.Poly_lastX = newobj.lastpointX;
						onemapobjectdesign.Poly_lastY = newobj.lastpointY;
						break;
					
				}
				
				
				var cntmapobjectnodes:int = newobj.shapepoints.length;
				var l:int;
				
				onemapobjectdesign.usrMapObjectDesignNodes = new Array;
				
				for(l=0; l< cntmapobjectnodes; l++) //create map object design nodes
				{
					var onemapobjectdesignnode:usrMapObjectDesignNodes = new usrMapObjectDesignNodes;
					
					onemapobjectdesignnode.nodeFillColour = newobj.objnodefillcolor;
					onemapobjectdesignnode.nodeFillAlpha = newobj.objnodefillalpha;
					onemapobjectdesignnode.nodeStrokeColour = newobj.objnodestrokecolor;
					onemapobjectdesignnode.nodeStrokeAlpha = newobj.objnodestrokealpha;
					onemapobjectdesignnode.nodeStrokeWidth = newobj.objnodestrokewidth;
					onemapobjectdesignnode.nodeRadius = newobj.objnoderadius;
					
					
					onemapobjectdesignnode.pointNum = newobj.shapepoints[l].pointnum;
					onemapobjectdesignnode.pointX = newobj.shapepoints[l].pointX;
					onemapobjectdesignnode.pointY = newobj.shapepoints[l].pointY;
					onemapobjectdesignnode.nodeName = newobj.shapepoints[l].nodename;
					
					onemapobjectdesign.usrMapObjectDesignNodes.push(onemapobjectdesignnode);
				}
				
				onemapobject.usrMapObjectDesign.push(onemapobjectdesign);
				
			}				
			
			
			this.usrMaps[0].usrMapLayer[0].usrMapObject.push(onemapobject);
		
		}

		public function savelayouttodb()
		{
			var layupdDBXML:XML = new XML(createXMLfromLayout());
			savelayout(layupdDBXML);
		}
		
		
		
		public function savelayout(mapxml:XML)
		{
			//var tempmapobjXML:XML = new XML;
			var saveloader:URLLoader=new URLLoader();
			
			saveloader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			
			saveloader.addEventListener(Event.COMPLETE,completeSaveHandler, false, 0, true);
			
			var saverequest:URLRequest=new URLRequest('http://localhost/mapizzle/saveMapLayout.php');
			
			saverequest.method = URLRequestMethod.POST;
			saverequest.contentType = "text/xml";
			saverequest.data = mapxml;
			try 
			{
				saveloader.load(saverequest);
			} 
			catch(error:Error) 
			{
				
				trace('Error encountered: ' + error.message);
			}
			finally
			{
				saverequest = null;
			}
			
			
		}
		
		
		
		private function createXMLfromLayout():String
		{
			var mainstr:String;
			try
			{
				
				mainstr = "<?xml version=\"1.0\" ?>";
				mainstr += "<totalmap userid =\"" + this.userid + "\" accountid = \"" + this.accountid + "\" boardchanged=\"" + this.boardChanged + "\" >";
				
				var om:usrMap;
				var omf:usrMapFile;
				var omfm:usrMapFileMarker;
				var oml:usrMapLayer;
				var omlo:usrMapObject;
				var omod:usrMapObjectDesign;
				var omodn:usrMapObjectDesignNodes;
				for(var a=0; a < usrMaps.length; a++)
				{
					om = usrMaps[a];
					if(om.mapChanged == true)
					{
						mainstr += "<map mapID=\"" + om.mapID + "\" mapname=\"" + om.mapName + "\" maptitle=\"" + om.mapTitle + "\" mapDescription=\"" + om.mapDescription + "\" mapCreatorID=\"" + om.mapCreatorID + "\" mapchanged=\"" + om.mapChanged + "\">";
						mainstr += "<mapfileset>";
						for(var f = 0; f < om.usrMapFile.length ; f ++)
						{
							omf = om.usrMapFile[f];
							if(omf.mapFileChanged==true || omf.newObject==true)
							{
								mainstr += "<mapfile mapfileID=\""+ omf.mapFileID + "\" mapfileName=\""+ omf.mapFileName + "\" mapfileTitle=\""+ omf.mapFileTitle + "\" mapfileDescription=\""+ omf.mapFileDescription + "\" versionNum=\""+ omf.versionNum + "\" activeSW=\""+ omf.activeSW + "\" physfileName=\""+ omf.physfileName + "\" physfileDimWidth=\""+ omf.physfileDimWidth + "\" physfileDimHeight=\""+ omf.physfileDimHeight + "\" stageX=\""+ omf.stageX + "\" stageY=\""+ omf.stageY + "\" >";
								//mainstr += "<mapfile mapfileID=\"".$mapfiledata["mapfileID"]."\" mapfileName=\"".$mapfiledata["mapfileName"]."\" mapfileTitle=\"".$mapfiledata["mapfileTitle"]."\" mapfileDescription=\"".$mapfiledata["mapfileDescription"]."\" mapID=\"".$mapfiledata["mapID"]."\" upldruserID=\"".$mapfiledata["upldruserID"]."\" versionNum=\"".$mapfiledata["versionNum"]."\" activeSW=\"".$mapfiledata["activeSW"]."\" physfileName=\"".$mapfiledata["physfileName"]."\" physfileType=\"".$mapfiledata["physfileType"]."\" physfileDimWidth=\"".$mapfiledata["physfileDimWidth"]."\" physfileDimHeight=\"".$mapfiledata["physfileDimHeight"]."\" stageX=\"".$mapfiledata["stageX"]."\" stageY=\"".$mapfiledata["stageY"]."\" >";	
							
								for(var g = 0; g < omf.usrMapMarker.length; g++)
								{
									omfm = omf.usrMapMarker[g];
									if(omfm.mapMarkerChanged ==true || omfm.newObject == true || omfm.objDeleted == true)
									{
										mainstr += "<mapfilemarker mfmarkerID=\""+ omfm.mfMarkerID + "\" mfmarkerName=\""+ omfm.mfMarkerName + "\" mfmarkerTitle=\""+ omfm.mfMarkerTitle + "\" mfmarkerDescription=\""+ omfm.mfMarkerDescription + "\" activeSW=\""+ omfm.activeSW + "\" PosRelStgX=\""+ omfm.PosRelStgX + "\" PosRelStgY=\""+ omfm.PosRelStgY + "\" PosRelmfX=\""+ omfm.PosRelmfX + "\" PosRelmfY=\""+ omfm.PosRelmfY + "\"  MapMarkerChanged=\""+ omfm.mapMarkerChanged + "\"  NewObject=\""+ omfm.newObject + "\" DelObject=\""+ omfm.objDeleted + "\" />";
									}
									
								}
							
							mainstr+="</mapfile>";
							}
							
						}
						mainstr += "</mapfileset>";
						
						for(var b = 0; b < om.usrMapLayer.length ; b ++)
						{
							oml = om.usrMapLayer[b];
							if (oml.maplayerChanged == true)
							{
								mainstr += "<maplayer layerID=\""+ oml.layerID + "\" layername=\""+ oml.layerName +"\" layertitle=\""+ oml.layerTitle +"\" layerdescription=\""+ oml.layerDescription +"\" maplayerchanged=\"" + oml.maplayerChanged + "\">";
								
								for(var c = 0; c < oml.usrMapObject.length ; c ++)
								{
									omlo = oml.usrMapObject[c];
									if (omlo.mapObjectChanged == true || omlo.newObject == true || omlo.objDeleted == true)
									{
										mainstr += "<mapobject objID=\""+ omlo.ObjID + "\" objName=\""+ omlo.ObjName + "\"  objtitle=\""+ omlo.Title + "\"  description=\""+ omlo.Description + "\"  priority=\""+ omlo.Priority + "\"  area=\""+ omlo.Area + "\"  creatorid=\""+ omlo.CreatorID + "\" layerid=\""+ oml.layerID+ "\" relobjid=\""+ omlo.RelObjID + "\"  hasattach=\""+ omlo.HasAttach + "\"  hasschedule=\""+ omlo.HasSchedule + "\"  hasshare=\""+ omlo.HasShare + "\"  hasnotes=\""+ omlo.HasNotes + "\"  hastasks=\""+ omlo.HasTasks + "\"  hasconvo=\""+ omlo.HasConvo + "\" mapobjectchanged=\"" + omlo.mapObjectChanged + "\" designchanged=\"" + omlo.designChanged + "\" positionchanged=\"" + omlo.positionChanged + "\" nodechanged=\"" + omlo.nodeChanged + "\" newObject=\"" + omlo.newObject + "\" delObject=\"" + omlo.objDeleted + "\" >";
										
										for(var d = 0; d < omlo.usrMapObjectDesign.length ; d ++)
										{
											omod = omlo.usrMapObjectDesign[d];
											
											mainstr += "<objectdesign designid=\""+ omod.idobjDesign + "\"  objtype=\""+ omod.ObjType + "\" fillcolour=\""+ omod.FillColour + "\"  fillalpha=\""+ omod.FillAlpha + "\"  strokecolour=\""+ omod.StrokeColour + "\"  strokealpha=\""+ omod.StrokeAlpha + "\"  strokewidth=\""+ omod.StrokeWidth + "\"  posrelstgx=\""+ omod.PosRelStgX + "\"  posrelstgy=\""+ omod.PosRelStgY + "\"  posrelobjx=\""+ omod.PosRelObjX + "\"  posrelobjy=\""+ omod.PosRelObjY + "\"  sizeradius=\""+ omod.SizeRadius + "\"  sizewidth=\""+ omod.SizeWidth + "\"  sizeheight=\""+ omod.SizeHeight + "\"  firstposx=\""+ omod.FirstPosX + "\"  firstposy=\""+ omod.FirstPosY + "\"  nodecnt=\""+ omod.NodeCnt + "\"  blocktopleftx=\""+ omod.Block_topLeftX + "\"  blocktoplefty=\""+ omod.Block_topLeftY + "\"  blockbotrightx=\""+ omod.Block_botRightX + "\"  blockbotrighty=\""+ omod.Block_botRightY + "\"  circlecentrex=\""+ omod.Circle_centreX + "\"  circlecentrey=\""+ omod.Circle_centreY + "\"  circlecircumx=\""+ omod.Circle_circumX + "\"  circlecircumy=\""+ omod.Circle_circumY + "\"  circleradius=\""+ omod.Circle_radius + "\"  polyfirstx=\""+ omod.Poly_firstX + "\"  polyfirsty=\""+ omod.Poly_firstY + "\"  polylastx=\""+ omod.Poly_lastX + "\"  polylasty=\""+ omod.Poly_lastY + "\" >";
											
											mainstr += "<objnodeCollection>";
											for(var e = 0; e < omod.usrMapObjectDesignNodes.length; e ++)
											{
												omodn = omod.usrMapObjectDesignNodes[e];
												
												mainstr += "<objectnode objnodeid=\""+ omodn.objnodeID + "\"  objdesignid=\""+ omodn.objdesignID + "\"  pointnum=\""+ omodn.pointNum + "\"  pointx=\""+ omodn.pointX + "\"  pointy=\""+ omodn.pointY + "\"  nodename=\""+ omodn.nodeName + "\"  noderadius=\""+ omodn.nodeRadius + "\"  nodefillcolour=\""+ omodn.nodeFillColour + "\"  nodefillalpha=\""+ omodn.nodeFillAlpha + "\"  nodestrokecolour=\""+ omodn.nodeStrokeColour + "\"  nodestrokealpha=\""+ omodn.nodeStrokeAlpha + "\"  nodestrokewidth=\""+ omodn.nodeStrokeWidth + "\"  />";
												
											}
											mainstr += "</objnodeCollection>";
											mainstr += "</objectdesign>";
										}
										
										mainstr += "</mapobject>";
									} //end of if map object changed
								}			
								
								mainstr += "</maplayer>";	
							}//end of if map layer changed
						}
						
						
						
						mainstr += "</map>";
					}//end of if map changed
					
				}
				
				mainstr +="</totalmap>";
				//trace(mainstr);	
				
				om = null;
				oml = null;
				omlo = null;
				omod = null;
				omodn = null;
				//trace(mainstr);
				
			}
			catch(error:Error) 
			{
				
				trace("Error encountered: " + error.message);
			}
			finally
			{
				return mainstr;
			}
		}
		
		
		public function createNewMarkerArr(newobj:Object)
		{
			
			this.boardChanged = true;
			this.usrMaps[0].mapChanged = true;
			this.usrMaps[0].usrMapFile[0].mapFileChanged = true;
			var onemapmarker:usrMapFileMarker = new usrMapFileMarker;
			
			
			onemapmarker.activeSW = convbool("1");
			onemapmarker.mfMarkerName = newobj.name;
			onemapmarker.mfMarkerTitle = "Title:"+newobj.name;
			onemapmarker.mfMarkerDescription = "Desc:"+newobj.name;
			onemapmarker.CreatorID = 1;
						
			onemapmarker.newObject = true;	
			
			onemapmarker.PosRelStgX = newobj.x;
			onemapmarker.PosRelStgY = newobj.y;
			
			onemapmarker.PosRelmfX = newobj.x - this.usrMaps[0].usrMapFile[0].stageX;
			onemapmarker.PosRelmfY = newobj.y - this.usrMaps[0].usrMapFile[0].stageY;
			
			//this.usrMaps[0].usrMapFile[0].usrMapMarker = new Array;
			
			this.usrMaps[0].usrMapFile[0].usrMapMarker.push(onemapmarker);
			//this.usrMaps[0].usrMapLayer[0].usrMapObject.push(onemapobject);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
}