@warnings
@version 2.3
@name cp_MorphSaver
/*
  cp_MorphSaver 
  last updated June 7, 2009
  
  This plugin will cycle through the layers of an object and
  save out each transformed position into a single endomorph
  followed by saving it as a new object.

  by Chris Peterson
  chrisepeterson@gmail.com
  www.chrisepeterson.com

*/

generic
{
  
   varSaveTo = recall("varSaveTo","C:\\object_with_morph.lwo");
   varObjectName = nil; 
   varEndo = recall("varEndo","morph name");
   tokens;
   reqbegin("cp_MorphSaver");
  
   c4 = ctltext("","        cp_MorphSaver","       by Chris Peterson","chrisepeterson@gmail.com");
   c2 = ctlmeshitems("Object",varObjectName);
   c5 = ctlstring("Morph Name",varEndo);
   c1 = ctlfilename("Save File As",varSaveTo);
  
   return if !reqpost();
  
   varSaveTo = getvalue(c1);
   varObjectName = getvalue(c2);
   varEndo = getvalue(c5);
  
   store("varSaveTo",varSaveTo);
   store("varEndo",varEndo);
  
   reqend();
    
   if(!varSaveTo) { error("The file to save has not been set correctly."); }
   if(!varObjectName) { error("The target object has not been set correctly."); }
   if(!varEndo) { error("The morph name has not been set correctly."); }
       
       
   objname = varObjectName.name;
   if(objname.contains(":"))
   {
      tokens = parse(":",objname);
   }
   else
   {
      error("Need an object with layers.");
   }
   
   for(i = 1; i <= varObjectName.totallayers; i++)
    {
        lyrname = varObjectName.layerName(i);
        lyr = tokens[1] + ":" + lyrname;
        if(lyrname == nil)
        {
          lyr = tokens[1] + ":Layer" + i;
        }
        SelectByName(lyr);
        SaveEndomorph(varEndo);
    }
    SaveObject(varSaveTo);
    StatusMsg("File Saved Successfully : " + varSaveTo);
}