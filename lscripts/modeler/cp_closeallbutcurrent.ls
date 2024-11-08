@version 2.4
@warnings
@name "cp_CloseAllButCurrent"
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    march 4 2008
    
    Thanks to Jon Gourley for the idea.
    
    This script will close all objects in modeler
    except for the object that is currently open.
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
          nameList[x] = mesh.name;
          mesh = mesh.next();
          x++;
        }

        if(sizeof(nameList) > 1)
        {
          for(i=1; i <= sizeof(nameList); i++)
          {
            if(nameList[i] != curName)
            {
             setobject(nameList[i]);
             close();
            }
            else
            {
              setobject(nameList[i]);
            }
          }
        }
}
