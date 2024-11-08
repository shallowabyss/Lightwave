@warnings
@version 2.8
@name cp_Rename
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    may 20, 2009
    
    This script will rename a group of items with a single click.
*/
generic
{
	rnstr = recall("rnstr","name");
	reqbegin("cp_Rename");
    c1 = ctlstring("New name",rnstr);
    return if !reqpost();
    rnstr = getvalue(c1);
	store("rnstr",rnstr);
    reqend();
	selection = Scene().getSelect();
	for(i=1; i <= size(selection); i++)
	{
		SelectItem(selection[i].id);
		Rename(rnstr);
	}
}