@warnings
@version 2.4
@name "cp_WeldGroup"

// Edited by chris peterson 
// Last edited April 11, 2006

main
{
    selmode(USER);
    pntCnt = pointcount();
    if (pntCnt == 0)
    {
         error("No Points selected.");
    }
    moveId = floor(pntCnt/2);

    
    editbegin();
         for(currPnt = 1; currPnt < (moveId + moveId); currPnt++)
         {
             // info(currPnt);
	      firstPntVal = pointinfo(points[currPnt]);
	      secondPntVal = pointinfo(points[currPnt+1]);
              pointmove(points[currPnt],<secondPntVal.x, secondPntVal.y, secondPntVal.z>);
	      pointmove(points[currPnt+1],<secondPntVal.x, secondPntVal.y, secondPntVal.z>);
          /* since its dealing with groups of points we have to
              increment the currPnt variable twice. */
              currPnt++;
         }
    editend();
    mergepoints();


	// Retrieve whole object information
	selmode(GLOBAL);
	pntCntG = pointcount(); 

	// Select nonplanar polys and retrieve information
	selmode(USER);
	selpoint(CLEAR);
	selpolygon(CLEAR);
	selpolygon(SET, NVEQ, 2);
	pntCntU = pointcount();

	if(pntCntU){				// If there are some points selected by the user
	if(pntCntU == pntCntG){			// Check to see if whole object is nonplanar
		//error("they are same");	// if they are same do nothing
		}
		else{
			selpolygon(SET, NVEQ, 2);
			removepols();
		}
	}
	
	else{
	 error("No points in selection.");	// If no points in user selection give error
	}
	

info("Welded Group");

}

