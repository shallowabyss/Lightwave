@warnings
@version 2.7
@name cp_SelectPoint
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    december 4 2008

    This script will select a single point out of a group. Makes selecting points that are
    sitting on top of others a lot easier.
*/

pntAry;
    pntToSelect = 1;
main
{

    selmode(USER);
    pntcnt = pointcount();

    if(!pntcnt){
        error("There are no points to select.");
        return;
    }
    if(pntcnt == 1)
    {  
       error("Need more than 1 point");
       return; 
    }
    if(pntcnt >= 100)
    {
        msg[1] = "    Points selected is currently: " + pntcnt;
        msg[2] = "    are you sure you want to proceed?";
        msg[3] = "";
        msg[4] = "   ***Performance may be sluggish.***";
        reqbegin("cp_PointToSelect");
        c1 = ctltext("",msg);
        return if !reqpost();
        reqend();  
    }

    editbegin();
    pntAry = points;
    editend();

    reqbegin("cp_SelectPoint");
    c1 = ctlslider("Select Point",pntToSelect,1,pntcnt);
    ctlrefresh(c1, "udf_ValueChange");

    return if !reqpost();

    reqend();

    
}

udf_ValueChange: value
{
    udf_doSelect();
    pntToSelect = value;
}

udf_doSelect
{    
    selmode(USER);
    selpoint(CLEAR);
    selpoint(SET, POINTID, pntAry[pntToSelect]);
}
