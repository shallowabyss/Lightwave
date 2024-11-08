@warnings
@version 2.7
@name "cp_FastSetValue"
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    december 5 2008
    
    Sets the value for all of the points in a
    selection by matching the position(s) of 
    either the first or last point selected. 
*/


    Xbool = recall("Xbool",false);
    Ybool = recall("Ybool",false);
    Zbool = recall("Zbool",false);
    WhPnt = recall("WhPnt",1);
    Mpnts = recall("Mpnts",0);	  
    Ubool = recall("Ubool",false);
    Vbool = recall("Vbool",false);
    dontProceed = 0;
    point1 = 1;
    point2 = 1;
    pntFirst = 1;
    pntLast = 1;
    firstFound = false;

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
    
    reqbegin("cp_FastSetValue");
    reqsize(200,270);

    c1 = ctlcheckbox("X-Axis",Xbool);
    ctlposition(c1,75,51);

    c2 = ctlcheckbox("Y-Axis",Ybool);
    ctlposition(c2,75,76);

    c3 = ctlcheckbox("Z-Axis",Zbool);
    ctlposition(c3,75,101);
    
    c4 = ctlcheckbox("U-Axis",Ubool);
    ctlposition(c4,75,126);

    c5 = ctlcheckbox("V-Axis",Vbool);
    ctlposition(c5,75,152);
    
    c6 = ctlchoice("Use Pnt",WhPnt,@"First","Last"@);
    ctlposition(c6,32,177);

    c7 = ctlcheckbox("Merge Points",Mpnts);
    ctlposition(c7,75,202);
    
    c8 = ctltext("","   FastSetValue","by Chris Peterson");
    ctlposition(c8,68,8,82,26);
    
    return if !reqpost();

    Xbool = getvalue(c1);
    Ybool = getvalue(c2);
    Zbool = getvalue(c3);
    Ubool = getvalue(c4);
    Vbool = getvalue(c5);
    WhPnt = getvalue(c6);
    Mpnts = getvalue(c7);

     store("Xbool",Xbool);
     store("Ybool",Ybool);
     store("Zbool",Zbool);
     store("Ubool",Ubool);
     store("Vbool",Vbool); 
     store("WhPnt",WhPnt);
     store("Mpnts",Mpnts);

    reqend();


    if(WhPnt == 1)
    {
        editbegin();
        usePnt = pointinfo(points[1]);
        editend();
    }
    else
    {
        editbegin();
        usePnt = pointinfo(points[pntCnt]);
        editend();
    }

editbegin();
    if(Xbool) 
    {
    
        for(i = 0; i < pntCnt; i++)
        {
        curPts = points[i+1];
        pointmove(curPts,<usePnt.x, curPts.y, curPts.z>);
        }
    }
editend();
//////////////////////////////////////////////////////
editbegin();
    if(Ybool) 
    {
        for(i = 0; i < pntCnt; i++)
        {
        curPts = points[i+1];
        pointmove(curPts,<curPts.x, usePnt.y, curPts.z>);
        }
    }
editend();
//////////////////////////////////////////////////////
editbegin();
    if(Zbool) 
    {
        for(i = 0; i < pntCnt; i++)
        {
        curPts = points[i+1];
        pointmove(curPts,<curPts.x, curPts.y, usePnt.z>);
        }
    }
editend();
//////////////////////////////////////////////////////
if(Ubool == true || Vbool == true)
{
    vmap = VMap(VMTEXTURE, 0) || error("No UV map selected");
    selmode(DIRECT);
    editbegin();
    pntCnt = pointcount();
	if(pntCnt < 2)
	{
		error("Not enough points are selected.");
    }   
    for(i=1; i <= pntCnt; i++)
    {
        if(vmap.isMapped(points[i]) && firstFound == false)
        {   
       	    pntFirst = vmap.getValue(points[i]);
       	    point1 = i;
	        firstFound = true;
        }
        if(vmap.isMapped(points[i]))
        {
            pntLast = vmap.getValue(points[i]);
            point2 = i;
        }
    }

    if(point1 == point2)
        dontProceed = 1;
    if(point1 >= pntCnt)
        dontProceed = 1;
    
    if(dontProceed == 0)
    {        
       	for(i=1; i <= pntCnt; i++)
           {
            if(vmap.isMapped(points[i]))
            {
                pntOther = vmap.getValue(points[i]);
                if(Ubool == 1)
                {
                    if(WhPnt == 1)
                    {
                        adjustedValues[1] = pntFirst[1];
                        adjustedValues[2] = pntOther[2];
                        vmap.setValue(points[i], adjustedValues);
                    }
                    else
                    {
                        adjustedValues[1] = pntLast[1];
                        adjustedValues[2] = pntOther[2];
                        vmap.setValue(points[i], adjustedValues);   
                    }                
                }
                if(Vbool == 1)
                {
                    if(WhPnt == 1)
                    {
                        adjustedValues[1] = pntOther[1];
                        adjustedValues[2] = pntFirst[2];
                        vmap.setValue(points[i], adjustedValues);
                    }
                    else
                    {
                        adjustedValues[1] = pntOther[1];
                        adjustedValues[2] = pntLast[2];
                        vmap.setValue(points[i], adjustedValues);
                    }                   
                }            
            }
         }
      }
    editend();
    }
    if(Mpnts)
    {
	mergepoints();
	}
}

