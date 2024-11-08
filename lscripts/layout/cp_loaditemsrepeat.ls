@version 2.3
@name cp_LoadItemsRepeat

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    march 4 2008
    
    This script will repeat the LoadItemsFromScene
    command a given amount of times.
*/


generic
{

    vLISFilename = recall("vLISFilename", "");
    vNumberLoads = recall("vNumberLoads", 1);

    reqbegin("cp_LoadItemsRepeat");
    reqsize(415,126);

    c1 = ctlfilename("Scene File",vLISFilename,70,true); // 4th parameter required for 'load' instead of 'save'
    ctlposition(c1,20,25,350,20);

    c2 = ctlinteger("Repeat ",vNumberLoads);
    ctlposition(c2,32,52);

    return if !reqpost();

    vLISFilename = getvalue(c1);
    vNumberLoads = getvalue(c2);

    store("vLISFilename",vLISFilename);
    store("vNumberLoads",vNumberLoads);

    reqend();

	if(vNumberLoads >= 1 && vLISFilename != "")
	{
	  for(i=1; i <= vNumberLoads; i++)
    	  {
	     LoadFromScene(vLISFilename);
	  }	
	}
	else
	{
	   error("Enter higher number");
	}
}

