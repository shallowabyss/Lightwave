@warnings
@version 2.8
@name cp_MultipleKeys

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    may 21 2008
    
    This script will select items of the chosen type that has
	multiple keys on it.
*/

generic
{
    vType = recall("vType",1);
    reqbegin("cp_MultipleKeys");
	c0 = ctltext("","Select the following if it has multiple keyframes:");
    c1 = ctlchoice(" ",vType,@"Objects","Bones","Lights","Camera"@);
    return if !reqpost();
    vType = getvalue(c1);
	store("vType",vType);
    reqend();
	
	if(vType == 1)
		itemType = getfirstitem(MESH);
	if(vType == 2)
		itemType = getfirstitem(BONE);
	if(vType == 3)
		itemType = getfirstitem(LIGHT);
	if(vType == 4)
		itemType = getfirstitem(CAMERA);
	a=1;
	while(itemType != nil)
	{
        chan = itemType.firstChannel();
        while(chan != nil){
            if(chan.keyCount > 1){
                multikeys[a] = itemType.id;
				a++;
            }
            chan = itemType.nextChannel();
        }
        itemType = itemType.next();
    }
    if(multikeys)
    {
    	SelectItem(multikeys[1]);
    	for(i=2; i <= size(multikeys); i++)
    	{
    		AddToSelection(multikeys[i]);
    	}
    }
    else
    {
     error("There are no keys on the items.");
    }
}

