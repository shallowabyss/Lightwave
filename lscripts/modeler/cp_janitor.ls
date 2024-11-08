@warnings
@version 2.4
@name "cp_Janitor"

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    march 24 2006
    updated april 2 2013: Fixed several bugs discovered by Erik Alstad
    
    This script will clean your model based on
    the most common techniques for optimizing
    models in modeler.
*/


main
{

  nonpl = recall("nonpl",true);
  unpoly = recall("unpoly",true);
  twoPt = recall("twoPt",true);
  mergept = recall("mergept",true);
  zeroPt = recall("zeroPt",true);
  thresMp = recall("thresMp", 0);
  onevertex = recall("onevertex", true);

  reqbegin("cp_Janitor");
  reqsize(273,294);


    c1 = ctlcheckbox("2 Point Vertices",twoPt);
    ctlposition(c1,72,65,122,20);

    c2 = ctlcheckbox("Triple Non Planars",nonpl);
    ctlposition(c2,72,88,122,20);

    c3 = ctlcheckbox("Merge Points",mergept);
    ctlposition(c3,72,112,122,20);

    c4 = ctlcheckbox("Unify Polygons",unpoly);
    ctlposition(c4,72,160,122,20);

    c5 = ctltext("","              Janitor","      by Chris Peterson","chris@shallowabyss.com");
    ctlposition(c5,73,8,122,39);

    c6 = ctlcheckbox("0 Polygons (points)",zeroPt);
    ctlposition(c6,72,183,122,20);

    c7 = ctldistance("Threshold ",thresMp);
    ctlposition(c7,72,138,122,20);

    c8 = ctlcheckbox("1 Vertex (polys)",onevertex);
    ctlposition(c8,72,206,122,20);



  return if !reqpost();


  twoPt = getvalue(c1);
  nonpl = getvalue(c2);
  mergept = getvalue(c3);
  unpoly = getvalue(c4);
  zeroPt = getvalue(c6);
  thresMp = getvalue(c7);
  onevertex = getvalue(c8);

 store("twoPt",twoPt);
 store("nonpl",nonpl);
 store("unpoly",unpoly);
 store("mergept",mergept);
 store("zeroPt",zeroPt);
 store("thresMp", thresMp);
 store("onevertex", onevertex);
 reqend();

/////////////
undogroupbegin();
////////////
if(nonpl){
	// Retrieve whole object information
	selmode(GLOBAL);
	pntCntG = pointcount(); 

	// Select nonplanar polys and retrieve information
	selmode(USER);
	selpoint(CLEAR);
	selpolygon(CLEAR);
	selmode(DIRECT);
	selpolygon(SET, NONPLANAR);
	pols = polycount();
	if(pols)
	{
		triple();		
	}
}

/////////////
if(mergept){
	selmode(USER);
	selpoint(CLEAR);
	selpolygon(CLEAR);
        if(thresMp == 0){
        	mergepoints();
        }
        else{
					mergepoints(thresMp);		// Merge points
        }
}
/////////////
if(twoPt){
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

}
/////////////
if(unpoly){
	selmode(USER);
	selpoint(CLEAR);
	selpolygon(CLEAR);
	unifypols() ;				// Unify polygons
}
/////////////
if(onevertex){
	// Select 1 point polygons
	// Retrieve whole object information
	selmode(GLOBAL);
	pntCntG = pointcount(); 

	// Select nonplanar polys and retrieve information
	selmode(USER);
	selpoint(CLEAR);
	selpolygon(CLEAR);
	selpolygon(SET, NVEQ, 1);
	pntCntU = pointcount();

	if(pntCntU){				// If there are some points selected by the user
	if(pntCntU == pntCntG){			// Check to see if whole object is nonplanar
		//error("they are same");	// if they are same do nothing
		}
		else{
			selpolygon(SET, NVEQ, 1);
			removepols();
		}
	}
	
	else{
	 error("No points in selection.");	// If no points in user selection give error
	}

}

/////////////

if(zeroPt){
	// Select 0 polygon points (dead points)
	selmode(USER);
	selpoint(CLEAR);
	selpolygon(CLEAR);
	selpoint(SET, NPEQ, 0);
	selmode(DIRECT);
	pntCntZero = pointcount();
	if(pntCntZero)
	{
  	delete();
  }

}

/////////////
undogroupend();
/////////////
}

