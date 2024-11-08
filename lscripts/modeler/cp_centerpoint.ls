@warnings
@version 2.7
@name cp_CenterPoint

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    december 4 2008

    This script will create a point in the center of the selection.
*/

main{
// Take users selection (POLY OR POINTS)
selmode(USER);
// Get the points
pntCnt = pointcount();
// If they dont have at least 2 points selected give them an error
if(pntCnt < 2){
error("Not enough points selected");
return;
}
// Manipulating geometry, so use editbegin
editbegin();
// Make an empty variable that has values for the X,Y,Z
vecs = <0,0,0>;
// Loop to cycle through all the points
    for(i=1; i <= pntCnt; i++){
    // When cycling through add all the X,Y,and Z variables together
        vecs += pointinfo(points[i]);
    }
    // Create a new point in the center of the selection
    // i.e. the average point's coordinates
    // Store the point's ID in an array called pntID
    pntID[1] = addpoint((vecs.x/pntCnt),(vecs.y/pntCnt),(vecs.z/pntCnt));
    // Done editing geometry
editend();
// Clear the selection
selpoint(CLEAR);
// Select the center point
selpoint(SET, POINTID, pntID[1]);
}



