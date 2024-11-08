@warnings
@version 2.4
@name "cp_WeldGroupAverage"

// Script components from newtek's documentation
// Edited by chris peterson 
// Last edited March 23, 2006
// Added mergepoints and remove 2pt polys
// Fixed 2 pt vert bug March24

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
	      pntAvgVal = firstPntVal + secondPntVal;
              pointmove(points[currPnt],<pntAvgVal.x/2, pntAvgVal.y/2, pntAvgVal.z/2>);
	      pointmove(points[currPnt+1],<pntAvgVal.x/2, pntAvgVal.y/2, pntAvgVal.z/2>);
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
	

info("Welded Group Averages");

}

