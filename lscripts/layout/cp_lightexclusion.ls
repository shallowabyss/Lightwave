@warnings
@version 2.8
@name cp_LightExclusion

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 29 2008

    This script allow you to quickly include and exclude lights from casting onto objects.
	Also allows for affecting only items that contain the search string.
*/

vExLight = nil;
vExObject = nil;
vExMethod = recall("vExMethod",1);
vSearchString = recall("vSearchString","");
vInEx = recall("vInEx",2);
selection;
kind;
ie;

c1;
lb_items1;
lb_items2;
whichSelectedLights;
whichSelectedObjects;
selectedLights;
sObjects;
sLights;

generic
{

    mesh = Mesh() || error("No Objects in Scene!");
    selTest = Scene().getSelect();

    if(selTest[1].genus > 2)
    {
     error("Please select either lights or objects.");
    }

    if(selTest[1].genus == 1)
    {
     EditObjects();
     sObjects = Scene().getSelect(MESH);
     SelectAllLights();
     allLights = Scene().getSelect(LIGHT);
     for(i=1; i <= size(allLights); i++)
     {
     lgtAry[i] =  allLights[i].name;
     }
       reqbegin("cp_LightExclusion");
        c0 = ctlchoice("I/E",vInEx,@"Include","Exclude"@);
        lb_items1 =lgtAry;
        c1 = ctllistbox("Exclude Lights",250,200,"lb_Lcount","lb_Lname","lb_Levent");

        if(!reqpost())
        {
            EditObjects();
            SelectItem(sObjects[1].id);
            for(m=2; m <= size(sObjects); m++)
            {
            	AddToSelection(sObjects[m].id);
            }
            return;
        }
        vInEx = getvalue(c0);
        vExMethod = 1;
        store("vInEx",vInEx);

        reqend();
  // Reselect the original object selection
		SelectItem(sObjects[1].id);
		for(i=2; i <= size(sObjects); i++)
		{
			AddToSelection(sObjects[i].id);
		}
       // create id list from all of the lights
        for(m=1; m <= size(whichSelectedLights); m++)
        {
          idList[m] = allLights[whichSelectedLights[m]].id;
        }
        // include or exclude the lights from the objects
		for(i=1; i <= size(sObjects); i++)
		{
           for(j=1; j <= size(idList); j++)
           {
    			SelectItem(sObjects[i].id);
    			if(vInEx == 1)
    			{
    				IncludeLight(idList[j]);
    			}
    			else
    			{
    				ExcludeLight(idList[j]);
    			}
           }
		}
       // Reselect the lights in the scene
		SelectItem(sObjects[1].id);
		for(i=2; i <= size(sObjects); i++)
		{
			AddToSelection(sObjects[i].id);
		}
    }


    if(selTest[1].genus == 2)
    {
     EditLights();
     sLights = Scene().getSelect(LIGHT);
     SelectAllObjects();
     allObjects = Scene().getSelect(MESH);
     for(i=1; i <= size(allObjects); i++)
     {
     objAry[i] =  allObjects[i].name;
     }
      reqbegin("cp_LightExclusion");
        c0 = ctlchoice("I/E",vInEx,@"Include","Exclude"@);
        lb_items2 =objAry;
        c1 = ctllistbox("Exclude Objects",250,200,"lb_Ocount","lb_Oname","lb_Oevent");

        if(!reqpost())
        {
            EditLights();
            SelectItem(sLights[1].id);
            for(n=2; n <= size(sLights); n++)
            {
            	AddToSelection(sLights[n].id);
            }
            return;
        }

        vInEx = getvalue(c0);
        vExMethod = 2;
        store("vInEx",vInEx);
        reqend();
        // Reselect the original light selection
		SelectItem(sLights[1].id);
		for(i=2; i <= size(sLights); i++)
		{
			AddToSelection(sLights[i].id);
		}
       // create id list from all of the objects
        for(m=1; m <= size(whichSelectedObjects); m++)
        {
          idList[m] = allObjects[whichSelectedObjects[m]].id;
        }
        // include or exclude the objects from the lights
		for(i=1; i <= size(sLights); i++)
		{
           for(j=1; j <= size(idList); j++)
           {
    			SelectItem(sLights[i].id);
    			if(vInEx == 1)
    			{
    				IncludeObject(idList[j]);
    			}
    			else
    			{
    				ExcludeObject(idList[j]);
    			}
           }
		}
       // Reselect the lights in the scene
		SelectItem(sLights[1].id);
		for(i=2; i <= size(sLights); i++)
		{
			AddToSelection(sLights[i].id);
		}
    }

}


// Custom UDFs for the listboxes. They keep track of list items selections.

lb_Lcount
{
   return(lb_items1.size());
}
lb_Lname: index
{
   return(lb_items1[index]);
}

lb_Levent: items
{
   if(items != nil)
        whichSelectedLights = items;
   else
        whichSelectedLights = nil;
}
lb_Ocount
{
   return(lb_items2.size());
}
lb_Oname: index
{
   return(lb_items2[index]);
}

lb_Oevent: items
{
   if(items != nil)
        whichSelectedObjects = items;
   else
        whichSelectedObjects = nil;
}