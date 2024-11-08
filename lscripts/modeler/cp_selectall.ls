@warnings
@version 2.7
@name cp_SelectAll
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 31 2008
    
    This script will select all polygons and points.
*/

main
{
  selmode(DIRECT);
  selpoint(CLEAR);
  selpoint(SET,NPGT,1);
  selpolygon(CLEAR);
  selpolygon(SET,NVGT,1);
}
