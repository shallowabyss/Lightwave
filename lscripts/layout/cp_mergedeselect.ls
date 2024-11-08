@warnings
@version 2.6
@name cp_MergeDeselect

/*
      by Chris Peterson
      chrisepeterson@gmail.com
      www.chrisepeterson.com
      July 31, 2012
      
      This script will combine the merge polygon and deselect commands for
      quicker clean up of meshes.
*/

main {
   selmode(DIRECT);
   editbegin();
   pcount = polycount();
   compareSize = pcount[3] + pcount[4] + pcount[5] + pcount[6];
   editend();
   if(compareSize > 1)
   {
     undogroupbegin();
     mergepols();
     selpolygon(CLEAR);
     undogroupend();
   }
   else
   {
     info("You need at least two polygons.");
   }
}