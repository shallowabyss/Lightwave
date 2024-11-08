@warnings
@version 2.8
@name cp_motLoader

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 28 2009

    This script allow you to quickly load motions from the C:\windows\temp
    directory.
*/

itemID;
c1;
lb_items;
whichSelected;

generic
{
    selectItems = Scene().getSelect();
    itemID = selectItems[1].id;
    SelectItem(itemID);
    path = "C:\\TEMP\\";
    motions = matchfiles(path, "*.mot");
    reqbegin("cp_motLoader");
    lb_items = motions;
    c1 = ctllistbox("Motions",700,300,"lb_count","lb_name","lb_event");

    return if !reqpost();

    reqend();
    if(whichSelected)
    {
     motfile = path + lb_items[whichSelected[1]];
     LoadMotion(motfile);
     StatusMsg("Loaded Motion: " + motfile);
    }
}

lb_count
{
   return(lb_items.size());
}
lb_name: index
{
   return(lb_items[index]);
}
lb_event: items
{
   if(items != nil)
        whichSelected = items;
   else
        whichSelected = nil;
}
