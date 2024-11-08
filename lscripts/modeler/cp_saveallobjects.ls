@warnings
@version 2.7
@name cp_SaveAllObjects

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 3 2008
    
    This script will save all objects in modeler.
*/


main 
{
   
   curObj = Mesh(0);
   curName  = curObj.name;
   x =2;

        mesh = Mesh() || error("No object files detected.");
        nameList[1] = curName;
        while(mesh)
        {
  	     nextOBJ = mesh.name;
  	     setobject(nextOBJ);
         save(mesh.filename);
         mesh = mesh.next();
         x++;
        }

    
}
