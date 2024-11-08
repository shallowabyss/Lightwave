@warnings
@version 2.2
@name cp_SelOnePt

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 27, 2009

    This script will select one point on each set of connected objects.
*/

plyCnt;
pntCnt;
pointAry;
pointAryCnter = 1;

main
{
    selmode(USER);
    selpolygon(CLEAR);
    pntCnt = pointcount();
    plyCnt = polycount();
    if(plyCnt[1] < 1)
    {
        error("Not enough polygons to perform procedure.");
        return;
    }
    undogroupbegin();
    selmode(USER);
	while(pointcount() > 0)
	{
        selpolygon(SET, POLYNDX, 1);
        selpolygon(SET, CONNECT);
        pntCnt = pointcount();
        editbegin();
        for(i=1; i <= 1; i++)
        {
            pointAry[pointAryCnter] = points[1];
            pointAryCnter++;
        }
        editend();
        selhide();
        selpolygon(CLEAR);
        selpoint(CLEAR);
    }

    selunhide();
    for(m=1; m < pointAryCnter; m++)
    {
     selpoint(SET, POINTID, pointAry[m]);
    }
    undogroupend();
}

