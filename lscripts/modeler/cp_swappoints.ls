@warnings
@version 2.7
@name "cp_SwapPoints"
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 28 2008
    
    This script will swap the positions of selected points.
*/

main
{
    selmode(USER);
    
    editbegin();
    pntCnt = pointcount();
    editend();
    
    if(!pntCnt)
    {
        error("No points were found in selection.");
        return;
    }

    undogroupbegin();
        editbegin(); 
        for(i = 1; i <= pntCnt; i++)
            {
                if((i+1)<=pntCnt)
                {
                    pnt1 = points[i];
                    pnt2 = points[i+1];
                    pointmove(pnt1,<pnt2.x, pnt2.y, pnt2.z>);
                    pointmove(pnt2,<pnt1.x, pnt1.y, pnt1.z>);
                    // incrementing for the 2nd point
                    i++;
                }
                else
                {
                    // if there isnt a second point to be shifted, or the process is done.
                    info("Points have been moved.");
                }
            }
        editend();
    undogroupend();
}

