@warnings
@version 2.8
@name cp_selActive
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    april 29 2009
    
	this script will only activate the selected object(s) to render. 
	all other objects will be deactivated, so they will not get rendered.
*/
generic 
{
	scn = Scene();
	itemList = scn.getSelect(MESH);
	obj = getfirstitem(MESH);
	while(obj != nil)
	{
		SelectItem(obj.id);
		ItemActive(0);
		obj = obj.next();
	}
	for(i=1; i<= size(itemList); i++)
	{
		SelectItem(itemList[i].id);
		ItemActive(1);
	}
}
