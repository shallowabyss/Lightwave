@warnings
@version 2.7
@name "cp_2ptPolyMaker"

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    december 4 2008

    This script will create 2 point polys in either the selected or creation order (if nothing is selected).
*/

main
{
    selmode(USER);
    pntCnt = pointcount();
    if (pntCnt < 2)
    {
         error("Not enough points to create chain.");
    }
    undogroupbegin();
    editbegin();
         for(i = 1; i < pntCnt; i++)
         {
            chain[1] = points[i];
            chain[2] = points[i+1];
            addpolygon(chain);

         }
    editend();
    undogroupend();

}

