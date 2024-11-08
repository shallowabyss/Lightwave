@warnings
@version 2.7
@name "cp_RadArray"

/*
 created by Chris Peterson
 chris@shallowabyss.com
 created: August 26, 2006

*/


main{
/* Global Variables */
    rotPnt = recall("rotPnt",<0,0,0>);
    rotAx = recall("rotAx","X");
    vAxis = recall("vAxis",1);
    vInp = recall("vInp",1);
    vCopies = recall("vCopies",1);
    vX = recall("vX",0);
    vY = recall("vY",0);
    vZ = recall("vZ",0);


/* Make sure there is geometry to rotate */
pntcntFG = pointcount();
if(!pntcntFG){
    error("There needs to be something to spin.");
    return;
}

/* The requester code */
    reqbegin("Radial Array Alternative");
reqsize(270,258);

    c1 = ctlchoice("Axis",vAxis,@"X","Y","Z"@);
    ctlposition(c1,26,92,208,21);

    c2 = ctlchoice("Pivot",vInp,@"BG Point","Origin","Custom"@);
    ctlposition(c2,21,115,213,21);

    c3 = ctltext("","Radial Array Alternative","      by Chris Peterson","chris@shallowabyss.com");
    ctlposition(c3,88,16,118,39);

    c4 = ctlnumber("Number",vCopies);
    ctlposition(c4,82,69,90,21);

    c5 = ctldistance("X",vX);
    ctlposition(c5,112,140,60,21);

    c6 = ctldistance("Y",vY);
    ctlposition(c6,112,162,60,21);

    c7 = ctldistance("Z",vZ);
    ctlposition(c7,112,185,60,21);

    return if !reqpost();

    vAxis = getvalue(c1);
    vInp = getvalue(c2);
    vCopies = getvalue(c4);
    vX = getvalue(c5);
    vY = getvalue(c6);
    vZ = getvalue(c7);

/* Store values for later use */
    store("rotPnt",rotPnt);
    store("rotAx",rotAx);
    store("vAxis",vAxis);
    store("vInp",vInp);
    store("vCopies",vCopies);
    store("vX",vX);
    store("vY",vY);
    store("vZ",vZ);


reqend();
/* End requester code */

if(vCopies < 1){
	error("There must be at least one item created.");
	return;
}
/* Check for which axis */
if(vAxis == 1){
  rotAx = "X";
}
if(vAxis == 2){
  rotAx = "Y";
}
if(vAxis == 3){
  rotAx = "Z";
}

/* Copy the data that the user has selected to be arrayed */
  selmode(USER);
  copy();


/* Origin or Bg Pnt */
if(vInp == 1){
   /* Make sure that if they choose BG layer that there is only one point on it */
	lyrswap();
	pntcntBG = pointcount();
	if(pntcntBG > 1){
    		lyrswap();
    		error("There can/must be only one point in the background layer");
    		return;
	}       
  editbegin();
  /* Store the pivot point to memory (point to pivot around) */
  rotPnt = pointinfo(points[pntcntBG]);
  editend();
}
if(vInp == 2){
 /* They chose the origin */
 rotPnt = (<0,0,0>);
}
if(vInp == 3){
 /* They chose custom values*/
 rotPnt = <vX,vY,vZ>;
}

/* Get a new layer to perform the actions in and paste the object to be arrayed */
empT = lyrempty();
lyrsetfg(empT[1]);
paste();

/* Loop to make the copies in the circle */
moninit(vCopies);
for(i=1; i < vCopies; i++){

  selmode(USER);
  selinvert();
  paste();
  selinvert();
  rotangle = (360 / vCopies);
  rotate(rotangle, rotAx, rotPnt);
  monstep();
 }
monend();
/* Clear the selection caused by the script */
selmode(USER);
selpolygon(CLEAR);
selpoint(CLEAR);

}
