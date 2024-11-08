@version 2.2
@warnings
@name cp_SaveTransformed
@script generic
@asyncspawn

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    august 4, 2010
    
    This script will save the transformed objects and replace them in the scene.
   	Updated to fix a few bugs with underscores for the prefix and folder path problems.
*/

scn = Scene();
prefix = recall("prefix", "");
suffix = recall("suffix", "_transformed");
selType = recall("selType", 1);
openpath = recall("openpath",1);
frameSelect = recall("frameSelect", 0);
replaceInScene = recall("replaceInScene", 1);
filepath = recall("filepath",getdir("Objects")+getsep());

newFileName;
fp;
objSelection;
objSelectionNew;
objID;
filepath;

generic 
{
	
    if(!filepath)
    {
         filepath=getdir("Objects")+getsep();
	}
	objSelection =  scn.getSelect(MESH);
	for(i=1; i<= size(objSelection);i++)
	{
		objID[i] = objSelection[i].id;
	}
	myObject=objSelection; 
	if(!myObject) 
	{ 
	    error("need a mesh."); 
	    return;
	}

	reqbegin("cp_SaveTransformed");
	c1 = ctlchoice("save",selType,@"Selected","All"@);
	c2 = ctlinteger("frame", frameSelect);
	c4 = ctlstring("prefix", prefix);
	c7 = ctlstring("suffix", suffix);
	c3 = ctlfoldername("path",filepath,70);
	c0 = ctltext("","The folder of the selected file will be used.");
	c6 = ctlcheckbox("replace current objects with transformed ones",replaceInScene);
	c8 = ctlcheckbox("Open save path after completion", openpath);

	return if(!reqpost());
	
	selType=getvalue(c1);
  frameSelect=getvalue(c2);
	filepath=getvalue(c3);
	prefix=getvalue(c4);
	suffix=getvalue(c7);
	openpath=getvalue(c8);
	replaceInScene=getvalue(c6);
	
	testPathSep = strright(filepath,1);
	if(testPathSep != "\\")
	{
		filepath = filepath + "\\";
	}
	store("frameSelect",frameSelect);
	store("selType",selType);
	store("prefix",prefix);
	store("suffix",suffix);
	store("replaceInScene",replaceInScene);
	store("openpath",openpath);
	store("filepath", filepath);
	reqend();
   
	npath = split(filepath);
	fp = npath[1]+npath[2];
	
	if(selType == 1)  // Selected
	{
		saveTransSel();	  
	}
	if(selType == 2)     // All
	{
		saveTransAll();
	}
	if(replaceInScene == 1)
	{
	   repInScn();
	   warn("It is recommended that you now save your scene.");
	}
	if(openpath)
	{
		launchPath();
	}
	SelectItem(objID[1]);
	for(i=2; i<= size(objSelection); i++)
	{
		AddToSelection(objID[i]);
	}
}


saveTransSel
{
	GoToFrame(frameSelect);
	for(i = 1; i <= size(objSelection); i++)
	{
		SelectItem(objSelection[i].id);
		objName = objSelection[i].name;
		if(objName.contains(":"))
		{
			str = ":";
			parName = parse(str,objName);
			objNameWLayer=(parName[1]+"_"+parName[2]);
			newFileName = fp+prefix+objNameWLayer+suffix+".lwo";
		} 
		else 
		{
			newFileName = fp+prefix+objName+suffix+".lwo";
		}
		objSelectionNew[i] = newFileName;
		SaveTransformed(newFileName);
	}
}

saveTransAll
{
	GoToFrame(frameSelect);
	obj = getfirstitem(MESH);
	a=1;
	while(obj != nil)
	{
		SelectItem(obj.id);
		objID[a] = obj.id;
		objSelection[a] = obj.name;
		objName = obj.name;
		if(objName.contains(":"))
		{
			 str = ":";
			 parName = parse(str,objName);
			 objNameWLayer=(parName[1]+"_"+parName[2]);
			 newFileName = fp+prefix+objNameWLayer+suffix+".lwo";
		} 
		else 
		{
			 newFileName = fp+prefix+objName+suffix+".lwo";
		}
		SaveTransformed(newFileName);
		objSelectionNew[a] = newFileName;
		obj = obj.next();
		a = a+1;
	}
}

repInScn
{
	AutoConfirm(1);
	for(i=1; i <= size(objSelection); i++)
	 {
	   SelectItem(objID[i]);
	   ClearSelected();
	   LoadObject(objSelectionNew[i]);
	 }
	AutoConfirm(0);
}

launchPath 
{
	spawn("explorer.exe " + fp);
}