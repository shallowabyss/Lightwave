@warnings
@version 2.3
@name "cp_MirrorPoints"

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 28 2008
    
    This script will swap the positions of selected points on an axis.
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

    choiceAxis = recall("choiceAxis",1);

    reqbegin("cp_MirrorPoints");
    reqsize(200,140);

    c1 = ctlchoice("Axis",choiceAxis,@"X","Y","Z"@);
    ctlposition(c1,58,56);
    c2 = ctltext("","Choose an axis to \"flip\" over.");
    ctlposition(c2,68,4,52,16);

    return if !reqpost();

    choiceAxis = getvalue(c1);

    store("choiceAxis",choiceAxis);


    reqend();

    
    if(choiceAxis == 1) 
    {
      undogroupbegin();
            editbegin();  
            for(i = 1; i <= pntCnt; i++)
                {
                    pnt1 = points[i];
                    pnt2 = points[(pntCnt + 1) - i];
                    pointmove(pnt1,<pnt2.x, pnt1.y, pnt1.z>);
                    pointmove(pnt2,<pnt1.x, pnt2.y, pnt2.z>);
                }
            editend();
        undogroupend();
    }

//////////////////////////////////////////////////////

    if(choiceAxis == 2) 
    {
      undogroupbegin();
            editbegin(); 
      undogroupbegin();
            editbegin();  
            for(i = 1; i <= pntCnt; i++)
                {
                    pnt1 = points[i];
                    pnt2 = points[(pntCnt + 1) - i];
                    pointmove(pnt1,<pnt1.x, pnt2.y, pnt1.z>);
                    pointmove(pnt2,<pnt2.x, pnt1.y, pnt2.z>);
                }
            editend();
        undogroupend();
    }
//////////////////////////////////////////////////////
    if(choiceAxis == 3) 
    {
      undogroupbegin();
            editbegin();  
            for(i = 1; i <= pntCnt; i++)
                {
                    pnt1 = points[i];
                    pnt2 = points[(pntCnt + 1) - i];
                    pointmove(pnt1,<pnt1.x, pnt1.y, pnt2.z>);
                    pointmove(pnt2,<pnt2.x, pnt2.y, pnt1.z>);
                }
            editend();
        undogroupend();
    }
//////////////////////////////////////////////////////

}
