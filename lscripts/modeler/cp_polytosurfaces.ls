@warnings
@version 2.8
@name cp_polyToSurfaces
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    september 29 2009
    
	this script will take each polygon and give it its own surface.
    useful for finding specific polygons through fprime or viper (after ran
    on object).
*/
main 
{
	pol;
	selmode(USER);
	selpolygon(CLEAR);
	editbegin();
	pCount = polycount();
	editend();
	if (pCount)
	{
		editbegin();
		pol = polygons;
		editend();
		moninit(size(pol));
		for(i=1; i <= size(pol); i++)
		{
			monstep();
			selpolygon(SET, POLYID, pol[i]);
            changesurface("Surface_"+i);
			selpolygon(CLEAR);
		}		
	}
	monend();
}