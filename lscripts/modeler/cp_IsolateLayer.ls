@warnings
@version 2.2
@script modeler
@name cp_IsolateLayers

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 12 2011

    This script will select the layers the selected polygons are on.
*/
currentFGLayers;
newLyrs;
inc = 1;
main
{
	currentFGLayers = lyrfg();
	selmode(DIRECT);
	totalPolys = polycount();
	if(size(totalPolys) < 10 && size(totalPolys) > 0)
	{
		editbegin();
		polyArray=polygons;
		editend();
		for(x=1; x<= size(currentFGLayers); x++)
		{
			lyrsetfg(currentFGLayers[x]);
			for(i=1; i<= size(polyArray); i++)
			{
				found = findPoly(polyArray[i]);
				if(found == true)
				{
					newLyrs[inc] = currentFGLayers[x];
					i = size(polyArray) + 1;
					inc++;
				}
			}
		}
		lyrsetfg(newLyrs);
	}
	else
	{
		error("Please select anywhere from 1 to 10 polygons.");
	}	
}

findPoly: id
{
	selmode(USER);
	selpolygon(CLEAR);
	editbegin();
	checkPolys = polygons;
	editend();
	if(checkPolys)
	{
		for(z=1; z<= size(checkPolys); z++)
		{
			if(checkPolys[z] == id)
				{
					return(1);
				}
		}
		return(0);	
	}
	else
	{
		return(0);
	}
}
