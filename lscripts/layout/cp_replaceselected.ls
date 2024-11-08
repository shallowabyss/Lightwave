@version 2.3
@warnings
@name cp_ReplaceSelected
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    june 15 2009

    This script will replace the selected items with either
    the object of your choosing or a null.
*/
generic
{

    replaceType = recall("replaceType", 1);             
    replaceList = recall("replaceList", "");
    replaceMethod = recall("replaceMethod", 1);
    replaceObject = recall("replaceObject", "");
    vColor = recall("vColor", 1);

  objSelection =  Scene().getSelect(MESH);             
  objectListSize = 0;
  objectList;


  if(objSelection)
  {
      reqbegin("ReplaceSelected");
      c0 = ctlfilename("Replacement List", replaceList, 70, true);
      c1 = ctlfilename("Replacement Object", replaceObject, 70, true);
      c2 = ctlchoice("Replace With",replaceType,@"List","Object","Null"@);
      c3 = ctlchoice("Replace Method",replaceMethod,@"Sequential","Random"@);
      c4 = ctlpopup("Color",vColor,@"- No Change -","Black","Dark Blue","Dark Green","Dark Cyan","Dark Red","Purple","Brown","Grey","Blue","Green","Cyan","Red","Magenta","Orange","White"@);
      ctlactive(c2, "isList", c0);
      ctlactive(c2, "isList", c3);
      ctlactive(c2, "isObject", c1);

      return if !reqpost();

      replaceList = getvalue(c0);
      replaceType = getvalue(c2);
      replaceMethod = getvalue(c3);
      vColor = getvalue(c4);
      replaceObject = getvalue(c1);

      store("replaceList", replaceList);
      store("replaceType", replaceType);
      store("replaceMethod", replaceMethod);
      store("vColor", vColor);
      store("replaceObject", replaceObject);

      reqend();                                  

    if(replaceType == 1 && replaceList != "")
    {

      f = File(replaceList,"r") || error("Cannot open file: ",replaceList,"");
      f.line(f.linecount());
      if(!f.read())
      {
          f.reopen("a");
          f.nl();
      }
      f.close();

      f = File(replaceList,"r") || error("Cannot open file: ",replaceList,"");
      if(f.linecount())
      {

        while(!f.eof())
        {
          curLine = f.read();
          if(curLine.contains(".lwo"))
          {
            objectListSize++;
            objectList[objectListSize] = curLine;             
          }
          if(!curLine.contains(".lwo") && curLine != nil)
          {

            warn("At least one file in the list is not a .LWO file. File ignored.");
          }
        }
      }
      else
      {

        error("Problem reading file: No files detected.");
      }
    }
      if(replaceType == 1)
      {
        seqObject = 1;
        for(i = 1; i <= size(objSelection); i++)
        {
          SelectItem(objSelection[i].id);
          if(replaceMethod == 1)
          {
            if(seqObject > size(objectList))
            {
              seqObject = 1;
            }        
            ReplaceWithObject(objectList[seqObject]);
            seqObject++;
          }
          else
          {
            randObj = random(1, size(objectList));
            ReplaceWithObject(objectList[randObj]);
          }
          message(i,size(objSelection));
        }
      }
      if(replaceType == 2)
      {
        for(i = 1; i <= size(objSelection); i++)
        {
          SelectItem(objSelection[i].id);
          ReplaceWithObject(replaceObject);
          message(i,size(objSelection));
        }
      }
      if(replaceType == 3)
      {
        for(i = 1; i <= size(objSelection); i++)
        {
          SelectItem(objSelection[i].id);

          ReplaceWithNull("Null");
          message(i,size(objSelection));
        }
      }
      for(i=1; i <= size(objSelection); i++)
      {

        if(vColor != 1)
        {
          vC = integer(vColor) - 2;
          color = "ItemColor " + vC;
          CommandInput(color);
        }

        AddToSelection(objSelection[i].id);
      }
    }
  if(!objSelection)
  {

    error("Please select a mesh item and then run the script again.");
  }
}



isList: value
{
  if(value == 1)
    return 1;
  else
    return 0;
}

isObject: value
{
  if(value == 2)
    return 1;
  else
    return 0;
}

message: value, selectionsize
{
  statmessage = string(value) + " of " + string(selectionsize) + " replaced.";
  StatusMsg(statmessage);
}