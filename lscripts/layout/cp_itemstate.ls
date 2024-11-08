@warnings
@version 2.3
@name cp_ItemState

generic
{
  scn = Scene();
  itemID;
  itemState;
  x = 1;
  scenepath = scn.filename;
  scenesplit = split(scenepath);
  outputpath = getdir(TEMPDIR) + "\\" + scenesplit[3] + ".itemstate";
  outputpathtemp = getdir(TEMPDIR) + "\\" + scenesplit[3] + ".itemstatecheck";
  saveState = recall("saveState", 1);
  
  if(scenepath == "(unnamed)" || scenepath.contains("default.lws"))
  {
  	error("Please save your scene before running.");
  }
  mesh = Mesh() || error("No Object Loaded!");
  
  reqbegin("Item State Utility");

  c1 = ctlchoice("Item States",saveState,@"Save","Load"@);

  return if !reqpost();

  saveState = getvalue(c1);
  store("saveState",saveState);
  reqend();
    
  if(saveState == 1)
  {
	f = File(scenepath,"r") || error("Cannot open file: ",scenepath,"");
	if(f.linecount())
	{	
	   while(!f.eof())
        {
           curLine = f.read();			
			if(curLine.contains("LoadObjectLayer"))
			{
			  tokens = parse(" ",curLine);
              itemID[x] = tokens[3];
              curLine = f.read();
              curLine = f.read();
              curLine = f.read();
              curLine = f.read();
              if(curLine.contains("ItemActive"))
              {
                itemState[x] = 0;
              }
              else
              {
                itemState[x] = 1;
              }
              x++;
			}
            if(curLine.contains("AddNullObject"))
			{
			  tokens = parse(" ",curLine);
              itemID[x] = tokens[2];
              curLine = f.read();
              curLine = f.read();
              curLine = f.read();
              curLine = f.read();
              if(curLine.contains("ItemActive"))
              {
                itemState[x] = 0;
              }
              else
              {
                itemState[x] = 1;
              }
              x++;
			}
            if(curLine.contains("AddNullObject") || curLine.contains("AddLight"))
			{
			  tokens = parse(" ",curLine);
              itemID[x] = tokens[2];
              curLine = f.read();
              curLine = f.read();
              curLine = f.read();
              curLine = f.read();
              if(curLine.contains("ItemActive"))
              {
                itemState[x] = 0;
              }
              else
              {
                itemState[x] = 1;
              }
              x++;
			}
        } 
        
      out = File(outputpath,"w") || error("Cannot open file: ",outputpath,"");
      for(i=1; i <= size(itemID); i++)
      {
          out.writeln(itemID[i] + " " + itemState[i]);
      }
     out.close(); 
     StatusMsg("Settings have been saved..."); 
    }
  }
  else
  {                     
    f = File(outputpath,"r") || error("Cannot open file: ",outputpath,"");
    if(f.linecount())
    {	
      while(!f.eof())
      {
        curLine = f.read();
        items = parse(" ",curLine);
        if(items[2] == "1")
        {
            command = "SelectItem " + items[1];
            CommandInput(command);
            ItemActive(1);
        }
        else
        {
            command = "SelectItem " + items[1];
            CommandInput(command);
            ItemActive(0);
        }
      }
      StatusMsg("Settings have been loaded...");
    }
  }
}