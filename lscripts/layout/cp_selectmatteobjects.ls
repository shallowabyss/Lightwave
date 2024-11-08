@warnings
@version 2.2
@name cp_SelectMatteObjects

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    july 30 2012

	This script will select all of the objects that have the Matte attribute
	checked.

*/

j = 0;
matteAry;
curLine;
itemID;

generic
{
		scn = getdir("TEMP") + getsep() + "temp.lws";
    SaveSceneCopy(scn);
    f = File(scn,"r") || error("Cannot open file: ",scn,"");
    if(f.linecount())
    {
        while(!f.eof())
        {
            curLine = f.read();
            if(curLine.contains("LoadObject"))
            {
                tokens = parse(" ", curLine);
                itemID = tokens[3];
            }
            if(curLine.contains("MatteObject"))
            {
                matteAry[++j] = itemID;
            }
        }
    }

		if(matteAry)
		{
	    cmd = "SelectItem " + matteAry[1];
	    CommandInput(cmd);
	    for(i=2; i<= size(matteAry); i++)
	    {
	        cmd = "AddToSelection " + matteAry[i];
	        CommandInput(cmd);
	    }
	    StatusMsg("All matte objects are now selected.");
  	}
  	else
  	{
  		StatusMsg("No matte objects detected.");
  	}
}

