@warnings
@version 2.7
@name "cp_SelectNegX"
// by chris peterson   chris@shallowabyss.com

main{
// Set variables
negXpnts = 0;
valpnt = 1;

// Clear any user selections
  selmode(USER);
  selpoint(CLEAR);
// Make sure there is some geometry
  pntcnt = pointcount();
  if(!pntcnt){
    error("No geometry can be found.");
    return;
    }
// Make an array (list) of all negative X points
  editbegin();
  for(i=1; i <= pntcnt; i++){
      valpoint[i] = pointinfo(points[i]);
      if(valpoint[i].x < 0){
            negXpnts[valpnt] = points[i];
            valpnt++;
    }
   }  
   editend();
// Select all of the points on the negative X
   selpoint(SET,POINTID,negXpnts);
}
