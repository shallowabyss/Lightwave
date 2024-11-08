@warnings
@version 2.8
@name cp_ReplaceWithLights
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    may 19, 2009
    
    This script will create lights that match the movement of the selected items
	and can also remove the items after selected as well. Note: removing the selected
	items will also kill any items that are parented to it.
*/
generic
{
	theparent;
	lights;
	selection;
	parentNull;
  
	vLightType = recall("vLightType",1);
	vSuffix = recall("vSuffix","_Light");
	vRemove = recall("vRemove",0);
	reqbegin("cp_ReplaceWithLight");
	c2 = ctlstring("Suffix",vSuffix);
	c1 = ctlchoice("Type",vLightType,@"Area","Distant","Linear","Point","Spotlight"@);
	c3 = ctlcheckbox("Delete Selected Objects",vRemove);
	c4 = ctltext("","Note: If you choose delete selected objects it will kill","all children of the selected objects as well including","the newly created lights.");
	return if !reqpost();
	vLightType = getvalue(c1);
	vSuffix = getvalue(c2);
	vRemove = getvalue(c3);
	store("vLightType",vLightType);
	store("vSuffix",vSuffix);
	store("vRemove",vRemove);
	reqend();

	selection = Scene().getSelect();
	sizeSelection = size(selection);

	for(i=1; i <= sizeSelection; i++)
	{
		SelectItem(selection[i].id);  
		mc();
		SelectParent();
		theparent = Scene().getSelect();
		if(vLightType == 1)
		  AddAreaLight(selection[i].name+vSuffix);
		if(vLightType == 2)
		  AddDistantLight(selection[i].name+vSuffix);
		if(vLightType == 3)
		  AddLinearLight(selection[i].name+vSuffix);
		if(vLightType == 4)
		  AddPointLight(selection[i].name+vSuffix);
		if(vLightType == 5)
		  AddSpotlight(selection[i].name+vSuffix);     
		lgt = Scene().getSelect();  
		lights[i] = lgt[1]; 
		if(theparent[1].id == selection[i].id || theparent[1].id == nil)
		{
			t = "ParentItem 0";
			CommandInput(t);
		}
		else
		{
			ParentItem(theparent[1].id);
		} 
		mp();
		if(vRemove)
		{
			SelectItem(selection[i].id); 
			AutoConfirm(1);
			ClearSelected();
			AutoConfirm(0);
		}
	}
	SelectItem(lights[1].id);
	for(i=2; i <= sizeSelection; i++)
	{
		AddToSelection(lights[i].id);
	}
}

mc
{
    dumpdirectory = getdir("Temp");
    contentdirectory = getdir("Content");
    chdir(dumpdirectory);
    SaveMotion("curmotion.mot");
    chdir(contentdirectory);
}
mp
{
    dumpdirectory = getdir("Temp");
    contentdirectory = getdir("Content");
    chdir(dumpdirectory);
    LoadMotion("curmotion.mot");
    chdir(contentdirectory);
}