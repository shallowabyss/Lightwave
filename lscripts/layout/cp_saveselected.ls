@version 2.6
@warnings
@script generic
@name cp_SaveSelected

/*
    Date: July 09, 2008
    Author: Chris Peterson
    Email: chrisepeterson@gmail.com
    URL: http://www.chrisepeterson.com/
    Description:
    Saves either selected meshes or all meshes in their transformed state.

    // Portions came from a script by Reiner Schug. 
    // Check out his lscripts :  http://www.interialabs.de/lw/lscript

    // Thanks also go out to Mike Green (Dodgy) for the help with parsing. 
    // Check out his scripts: http://www.mikegreen.name

*/

generic {
    // Declarations
    scene = Scene();
    sprefix = recall("sprefix", "new");
    sselType = recall("sselType", 1);

   // File path info
    filepath=getdir("Objects")+getsep(); 
    if(!filepath)
        {
         filepath="C:\\";
    }

   // Object Selection
    objSelection =  scene.getSelect(MESH);
    myObject=objSelection; 
    if(!myObject) 
    { 
        error("need a mesh."); 
        return;
    }

    reqbegin("cp_SaveSelected");
        c0 = ctltext("","                      cp_SaveSelected","                         by Chris Peterson","                 chrisepeterson@gmail.com");
        c1 = ctlchoice("mode",sselType,@"Save","Save Copy"@);
    c3 = ctlstring("path", filepath,255);
    c4 = ctlstring("prefix", sprefix);

    return if(!reqpost());
    sselType=getvalue(c1);
    filepath=getvalue(c3);
    sprefix=getvalue(c4);

        store("sselType",sselType);
        store("sprefix",sprefix);

    reqend();
   
   if(sselType == 1)  // Save
   {
      if(objSelection)
      {
                for(i = 1; i <= size(objSelection); i++)
                {
            SelectItem(objSelection[i].id);
            objName = objSelection[i].name;
            if(objName.contains(":"))
            {
                     str = ":";
                     parName = parse(str,objName);
                     objNameWLayer=(parName[1]+"_"+parName[2]);
             newFileName = filepath+sprefix+"_"+objNameWLayer+".lwo";
             SaveObject(newFileName);
                    } else {
             newFileName = filepath+sprefix+"_"+objName+".lwo";
             SaveObject(newFileName);
                    }
                }
      }
   }

   if(sselType == 2)     // SaveCopy
   {
     if(objSelection)
      {
        for(i = 1; i <= size(objSelection); i++)
        {
            SelectItem(objSelection[i].id);
            objName = objSelection[i].name;
            if(objName.contains(":"))
            {
                     str = ":";
                     parName = parse(str,objName);
                     objNameWLayer=(parName[1]+"_"+parName[2]);
             	   newFileName = filepath+sprefix+"_"+objNameWLayer+".lwo";
	               SaveObjectCopy(newFileName);
            } else {
             	   newFileName = filepath+sprefix+"_"+objName+".lwo";
	               SaveObjectCopy(newFileName);
            }
       }
     }
   }
}



