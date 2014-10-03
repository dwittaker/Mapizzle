package board.objects.dialog
{
	import board.objects.controls.drawBlock;
	import board.objects.controls.drawCircle;
	import board.objects.controls.drawPoly;
	import board.objects.controls.mapObject;
	import board.session.user.usrMapObject;
	import board.session.user.usrMapObjectDesign;
	import board.session.user.usrMapObjectDesignNodes;
	import board.session.user.usrSession;
	import board.utilities.general.utils;
	
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ColorPicker;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.controls.Slider;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import fl.events.ColorPickerEvent;
	import fl.events.SliderEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	
	public class ObjOptions extends MovieClip
	{
		public var PosX:Number;
		public var PosY:Number;
		
		public var objfillcolor:uint;
		public var objfillalpha:Number;
		
		public var objstrokecolor:uint;
		public var objstrokealpha:Number;
		public var objstrokewidth:Number;
		
		public var objnodefillcolor:uint;
		public var objnodefillalpha:Number;
		
		public var objnodestrokecolor:uint;
		public var objnodestrokealpha:Number;
		public var objnodestrokewidth:Number;
		
		public var objtitle:String;
		public var objdescription:String;
		public var objarea:String;
		public var objpriority:Number;
		
		var lbl_option1:TextField;
		var lbl_selectedoption:String;
		
		var btn_closeopt1:MovieClip;
		var btn_design1:MovieClip;
		var btn_info1:MovieClip;
		var btn_attach1:MovieClip;
		var btn_dataopt1:MovieClip;
		var btn_schedule1:MovieClip;
		var btn_share1:MovieClip;
		var btn_notes1:MovieClip;
		var btn_tasks1:MovieClip;
		
		var mc_design:MovieClip;
		var mc_info:MovieClip;
		
		var mc_dataopt:MovieClip;
		var mc_attach:MovieClip;
		var mc_schedule:MovieClip;
		var mc_share:MovieClip;
		var mc_notes:MovieClip;
		var mc_tasks:MovieClip;
		
		
		var objopt_clrpckr:ColorPicker;
		var objopt_alphasldr:Slider;	
		
		var txtinfo_title1:TextInput;
		var txtinfo_area1:TextInput;
		var txtinfo_description1:TextArea;
		var btninfo_save1:Button;
		var cbinfo_priority1:ComboBox;
		
		var chk_attach1:CheckBox;
		var chk_schedule1:CheckBox;
		var chk_share1:CheckBox;
		var chk_notes1:CheckBox;
		var chk_tasks1:CheckBox;
		
		var utils2:utils;
		
		public var optattachChanged:Boolean;
		public var optscheduleChanged:Boolean;
		public var optshareChanged:Boolean;
		public var optnotesChanged:Boolean;
		public var opttasksChanged:Boolean;
		
		public function ObjOptions()
		{
			super();
			
			utils2 = new utils;
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		
		public function added(evt:Event)
		{
			//trace("added");
			
			lbl_option1 = this.getChildByName("lbl_option") as TextField;
			lbl_selectedoption = "Select an Option below";
			lbl_option1.text=lbl_selectedoption;
			
			btn_closeopt1 = this.getChildByName("btn_closeopt") as MovieClip;
			
			btn_design1 = this.getChildByName("btn_design") as MovieClip;
			btn_design1.mouseChildren = false;
			btn_info1 = this.getChildByName("btn_info") as MovieClip;
			btn_info1.mouseChildren = false;
			
			btn_dataopt1 = this.getChildByName("btn_dataopt") as MovieClip;
			btn_dataopt1.mouseChildren = false;
			
			btn_attach1 = this.getChildByName("btn_attach") as MovieClip;
			btn_attach1.mouseChildren = false;
			btn_schedule1 = this.getChildByName("btn_schedule") as MovieClip;
			btn_schedule1.mouseChildren = false;
			btn_share1 = this.getChildByName("btn_share") as MovieClip;
			btn_share1.mouseChildren = false;
			btn_notes1 = this.getChildByName("btn_notes") as MovieClip;
			btn_notes1.mouseChildren = false;
			btn_tasks1 = this.getChildByName("btn_tasks") as MovieClip;
			btn_tasks1.mouseChildren = false;
			
			
			mc_design = this.getChildByName("objopt_design") as MovieClip;
			mc_info = this.getChildByName("objopt_info") as MovieClip;
			
			mc_dataopt = this.getChildByName("objopt_dataopt") as MovieClip;
			mc_attach = this.getChildByName("objopt_attach") as MovieClip;
			mc_schedule = this.getChildByName("objopt_schedule") as MovieClip;
			mc_share = this.getChildByName("objopt_share") as MovieClip;
			mc_notes = this.getChildByName("objopt_notes") as MovieClip;
			mc_tasks = this.getChildByName("objopt_tasks") as MovieClip;
			
			mc_design.visible = false;
			mc_info.visible = false;
			mc_dataopt.visible = false;
			mc_attach.visible = false;
			mc_schedule.visible = false;
			mc_share.visible = false;
			mc_notes.visible = false;
			mc_tasks.visible = false;
			
			
			btn_design1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_info1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_dataopt1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_attach1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_schedule1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_share1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_notes1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			btn_tasks1.addEventListener(MouseEvent.ROLL_OVER,hover_optionbutton);
			
			btn_closeopt1.addEventListener(MouseEvent.CLICK,click_close);
			
			btn_design1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_info1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_dataopt1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_attach1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_schedule1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_share1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_notes1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			btn_tasks1.addEventListener(MouseEvent.CLICK,click_optionbutton);
			
			setstartobj_design();
			setstartobj_info();
			setstartobj_dataopt();
		}
		
		public function click_close(evt:MouseEvent)
		{
			trace("object closed");
			this.visible = false;
			
			}
		
		public function click_optionbutton(evt:MouseEvent)
		{
			showoptiongroup(MovieClip(evt.target).name);		
		}
		
		public function showoptiongroup(sender:String)
		{
			switch (sender)
			{
				case "btn_design":
					//trace("design click");
					mc_design.visible = true;
					mc_info.visible = false;
					mc_dataopt.visible = false;
					mc_attach.visible = false;
					mc_schedule.visible = false;
					mc_share.visible = false;
					mc_notes.visible = false;
					mc_tasks.visible = false;
					lbl_option1.text = "Design";
					btn_design1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_info":
					//trace("info click");
					mc_design.visible = false;
					mc_info.visible = true;
					mc_dataopt.visible = false;
					mc_attach.visible = false;
					mc_schedule.visible = false;
					mc_share.visible = false;
					mc_notes.visible = false;
					mc_tasks.visible = false;
					lbl_option1.text = "Information";
					btn_info1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_dataopt":
					//trace("attach click");	
					mc_design.visible = false;
					mc_info.visible = false;
					mc_dataopt.visible = true;
					mc_attach.visible = false;
					mc_schedule.visible = false;
					mc_share.visible = false;
					mc_notes.visible = false;
					mc_tasks.visible = false;
					lbl_option1.text = "Object Options";
					btn_dataopt1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_attach":
					//trace("attach click");	
					mc_design.visible = false;
					mc_info.visible = false;
					mc_dataopt.visible = false;
					mc_attach.visible = true;
					mc_schedule.visible = false;
					mc_share.visible = false;
					mc_notes.visible = false;
					mc_tasks.visible = false;
					lbl_option1.text = "Attachments";
					btn_attach1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_schedule":
					//trace("attach click");	
					mc_design.visible = false;
					mc_info.visible = false;
					mc_dataopt.visible = false;
					mc_attach.visible = false;
					mc_schedule.visible = true;
					mc_share.visible = false;
					mc_notes.visible = false;
					mc_tasks.visible = false;
					lbl_option1.text = "Schedule";
					btn_schedule1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_share":
					//trace("attach click");	
					mc_design.visible = false;
					mc_info.visible = false;
					mc_dataopt.visible = false;
					mc_attach.visible = false;
					mc_schedule.visible = false;
					mc_share.visible = true;
					mc_notes.visible = false;
					mc_tasks.visible = false;
					lbl_option1.text = "Share this item";
					btn_share1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_notes":
					//trace("attach click");	
					mc_design.visible = false;
					mc_info.visible = false;
					mc_dataopt.visible = false;
					mc_attach.visible = false;
					mc_schedule.visible = false;
					mc_share.visible = false;
					mc_notes.visible = true;
					mc_tasks.visible = false;
					lbl_option1.text = "Notes";
					btn_notes1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_tasks":
					//trace("attach click");	
					mc_design.visible = false;
					mc_info.visible = false;
					mc_dataopt.visible = false;
					mc_attach.visible = false;
					mc_schedule.visible = false;
					mc_share.visible = false;
					mc_notes.visible = false;
					mc_tasks.visible = true;
					lbl_option1.text = "Tasks";
					btn_tasks1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
			}
			
			lbl_selectedoption = lbl_option1.text;
		}
				
		public function hover_optionbutton(evt:MouseEvent)
		{
			//trace("Label says " + lbl_option1.text);
			if(evt.type=="rollOver")
			{
				switch (MovieClip(evt.target).name)
				{
				case "btn_design":
					//trace("design hover");	
					lbl_option1.text = "Design";
					btn_design1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_info":
					//trace("info hover");
					lbl_option1.text = "Information";
					btn_info1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_dataopt":
					//trace("attach hover");	
					lbl_option1.text = "Object Options";
					btn_dataopt1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_attach":
					//trace("attach hover");	
					lbl_option1.text = "Attachments";
					btn_attach1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_schedule":
					//trace("attach hover");	
					lbl_option1.text = "Schedule";
					btn_schedule1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_share":
					//trace("attach hover");	
					lbl_option1.text = "Share this item";
					btn_share1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_notes":
					//trace("attach hover");	
					lbl_option1.text = "Schedule";
					btn_notes1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				case "btn_tasks":
					//trace("attach hover");	
					lbl_option1.text = "Share this item";
					btn_tasks1.addEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
					break;
				}
			}
			else if(evt.type=="rollOut")
			{
				lbl_option1.text = lbl_selectedoption;
				btn_design1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_info1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_dataopt1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_attach1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_schedule1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_share1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_notes1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
				btn_tasks1.removeEventListener(MouseEvent.ROLL_OUT,hover_optionbutton);
			}
		}
		
		
		
	
	public function setstartobj_design(des:usrMapObjectDesign = null)
	{
		
		objopt_clrpckr = mc_design.getChildByName("clrpckr_objfillcolor") as ColorPicker;
		objopt_alphasldr = mc_design.getChildByName("sldr_objfillalpha") as Slider;
		
		if (des != null)
		{
			if(des.ObjID != 0 )
			{
		objopt_clrpckr.selectedColor = des.FillColour ;
		objopt_alphasldr.value = des.FillAlpha;
		
		objfillcolor = objopt_clrpckr.selectedColor;
		objfillalpha = objopt_alphasldr.value;
			}
		
		}
		else
		{
			
			 objopt_clrpckr.selectedColor = objfillcolor;
			objopt_alphasldr.value = objfillalpha ;
		}
			
		objopt_clrpckr.addEventListener(ColorPickerEvent.CHANGE, catch_colour);
		objopt_alphasldr.addEventListener(SliderEvent.CHANGE, catch_alpha);

	}
	
	public function setstartobj_info(obj:usrMapObject = null)
	{
		txtinfo_title1 = mc_info.getChildByName("txtinfo_title") as TextInput;
		txtinfo_area1 = mc_info.getChildByName("txtinfo_area") as TextInput;
		txtinfo_description1 = mc_info.getChildByName("txtinfo_description") as TextArea;
		cbinfo_priority1 = mc_info.getChildByName("cbinfo_priority") as ComboBox;
		btninfo_save1 = mc_info.getChildByName("btninfo_save") as Button;
		
		if (obj != null)
		{
			if(obj.ObjID != 0 )
			{
		txtinfo_title1.text = obj.Title;
		txtinfo_area1.text = obj.Area;
		txtinfo_description1.text = obj.Description;
		cbinfo_priority1.selectedIndex = getlstindex(cbinfo_priority1,obj.Priority);
		
		objtitle = txtinfo_title1.text;
		objdescription = txtinfo_description1.text;
		objarea = txtinfo_area1.text;
		//objpriority = cbinfo_priority1.selectedItem as Number;
		objpriority = cbinfo_priority1.selectedItem.data;
		
		
			}
		}
		
		txtinfo_title1.addEventListener(FocusEvent.FOCUS_OUT,save_info);
		txtinfo_area1.addEventListener(FocusEvent.FOCUS_OUT,save_info);
		txtinfo_description1.addEventListener(FocusEvent.FOCUS_OUT,save_info);
		cbinfo_priority1.addEventListener(FocusEvent.FOCUS_OUT,save_info);
		
		//btninfo_save1.addEventListener(MouseEvent.CLICK,save_info);
				
		showoptiongroup("btn_info");
		//stage.focus = txtinfo_title1;
		//objopt_title1.drawFocus(true);
		
	}
	
	private function getlstindex(cb:ComboBox, itemvalue:int) :int
	{
		
		var indx:int = 0;
		
		
		for(var i=0;i< cb.length; i++)
		{
		//obj = cb[i];

		if (cb.getItemAt(i).data == itemvalue)
		{
		indx = i;
		break;
		}
		else
		{}
			
			
		}
		
		return indx;
	}
	
	private function catch_colour(evt:ColorPickerEvent)
	{
		chgobj_colouralpha(evt);
		
		}
	
	private function catch_alpha(evt:SliderEvent)
	{
		chgobj_colouralpha(evt);
		}
	
	private function chgobj_colouralpha(evt:Event)
	{
	//trace("color change: " + objopt_clrpckr.selectedColor);
	//trace("alpha change" + objopt_alphasldr.value);	
	
	var myparent;
	
	if (this.parent is drawBlock)
	{
		 myparent = this.parent as drawBlock;
	}
	if (this.parent is drawCircle)
	{
		 myparent = this.parent as drawCircle;
	}
	if (this.parent is drawPoly)
	{
		 myparent = this.parent as drawPoly;
	}
	
	myparent.objnodefillcolor = utils2.makeDarkVersion(objopt_clrpckr.selectedColor,-80);
	myparent.objnodefillalpha = objopt_alphasldr.value;
	myparent.objnodestrokecolor = utils2.makeDarkVersion(objopt_clrpckr.selectedColor,-80);
	myparent.objnodestrokewidth = 2;
	myparent.objnodestrokealpha = objopt_alphasldr.value;	
	
	myparent.objstrokewidth = 2;
	myparent.objstrokecolor = utils2.makeDarkVersion(objopt_clrpckr.selectedColor,-80);
	myparent.objstrokealpha = objopt_alphasldr.value;
	myparent.objfillcolor = objopt_clrpckr.selectedColor;
	myparent.objfillalpha = objopt_alphasldr.value;
	trace(myparent.objfillcolor );
	
	
	myparent.changeobjectcoloralpha();
	mapObject(this.parent).copyopts();
	
//	updateAfterEvent();
	
	save_design(evt);
	
	
	}
	
	private function save_design(evt:Event)
	{
		if(1==1) //(objfillcolor != objopt_clrpckr.selectedColor || objfillalpha != objopt_alphasldr.value)
			{
				objfillcolor = objopt_clrpckr.selectedColor;
				objfillalpha = objopt_alphasldr.value;
				objstrokecolor = utils2.makeDarkVersion(objopt_clrpckr.selectedColor,-80);
				objstrokealpha = objopt_alphasldr.value;
				
				objnodefillcolor = utils2.makeDarkVersion(objopt_clrpckr.selectedColor,-80);
				objnodefillalpha = objopt_alphasldr.value;
				objnodestrokecolor = utils2.makeDarkVersion(objopt_clrpckr.selectedColor,-80);
				objnodestrokealpha = objopt_alphasldr.value;
			
				var theusr:usrSession = MovieClip(this.stage.getChildAt(0)).myusr;
				
				for(var i=0;i < theusr.usrMaps[0].usrMapLayer[0].usrMapObject.length ; i ++)
				{
					if (usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).ObjName == evt.currentTarget.parent.parent.parent.name)
					{

						//trace("Found it at " + usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Title;
						usrMapObjectDesign(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0]).FillColour = objfillcolor;
						usrMapObjectDesign(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0]).FillAlpha = objfillalpha;
						usrMapObjectDesign(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0]).StrokeColour = objstrokecolor;
						usrMapObjectDesign(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0]).StrokeAlpha = objstrokealpha;
						
						
						for(var j=0;j < theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0].usrMapObjectDesignNodes.length ; j ++)
						{
							usrMapObjectDesignNodes(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0].usrMapObjectDesignNodes[j]).nodeFillColour = objnodefillcolor;
							usrMapObjectDesignNodes(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0].usrMapObjectDesignNodes[j]).nodeFillAlpha = objnodefillalpha;
							
							usrMapObjectDesignNodes(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0].usrMapObjectDesignNodes[j]).nodeStrokeColour = objnodestrokecolor;
							usrMapObjectDesignNodes(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i].usrMapObjectDesign[0].usrMapObjectDesignNodes[j]).nodeStrokeAlpha = objnodestrokealpha;
							
						}
						
						
						//usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Area = objarea;
						//usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Priority = objpriority;
					}
				}
				
			}
	}
		
		
	private function save_info(evt:Event)
	{
		if(objtitle != txtinfo_title1.text || objdescription != txtinfo_description1.text || objarea != txtinfo_area1.text || objpriority != (cbinfo_priority1.selectedItem.data))
		{
			
			
		objtitle = txtinfo_title1.text;
		objdescription = txtinfo_description1.text;
		objarea = txtinfo_area1.text;
		objpriority = cbinfo_priority1.selectedItem.data;
		
		//trace (MovieClip(this.stage.getChildAt(0)).myusr);
		var theusr:usrSession = MovieClip(this.stage.getChildAt(0)).myusr;
		
		for(var i=0;i < theusr.usrMaps[0].usrMapLayer[0].usrMapObject.length; i ++)
		{
			
		
		if (usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).ObjName == evt.currentTarget.parent.parent.parent.name)
		{
			//trace("Found it at " + usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Title;
			usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Title = objtitle;
			usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Description = objdescription;
			usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Area = objarea;
			usrMapObject(theusr.usrMaps[0].usrMapLayer[0].usrMapObject[i]).Priority = objpriority;
		}
		}
		//trace(objtitle +  " - " + objdescription);
		
		}
	}
	
	private function setstartobj_dataopt()
	{
	btn_attach1.visible = false;
	btn_schedule1.visible = false;
	btn_share1.visible = false;
	btn_notes1.visible = false;
	btn_tasks1.visible = false;
	
	chk_attach1 = mc_dataopt.getChildByName("chk_attach") as CheckBox;
	chk_schedule1 = mc_dataopt.getChildByName("chk_schedule") as CheckBox;
	chk_share1 = mc_dataopt.getChildByName("chk_share") as CheckBox;	
	chk_notes1 = mc_dataopt.getChildByName("chk_notes") as CheckBox;
	chk_tasks1 = mc_dataopt.getChildByName("chk_tasks") as CheckBox;
	
	chk_attach1.addEventListener(Event.CHANGE,chk_dataopt);
	chk_schedule1.addEventListener(Event.CHANGE,chk_dataopt);
	chk_share1.addEventListener(Event.CHANGE,chk_dataopt);
	chk_notes1.addEventListener(Event.CHANGE,chk_dataopt);
	chk_tasks1.addEventListener(Event.CHANGE,chk_dataopt);
	}
	
	private function chk_dataopt(evt:Event)
	{
		switch (evt.target.name)
		{
		case "chk_attach":
			
				btn_attach1.visible = chk_attach1.selected;
		
			break;
		case "chk_schedule":
			
				btn_schedule1.visible = chk_schedule1.selected;
			
			break;
		case "chk_share":
			
				btn_share1.visible = chk_share1.selected;
			
			break;
		case "chk_notes":
			
				btn_notes1.visible = chk_notes1.selected;
			
			break;
		case "chk_tasks":
			
				btn_tasks1.visible = chk_tasks1.selected;
			
			break;
		}
	}
	
	}
}
