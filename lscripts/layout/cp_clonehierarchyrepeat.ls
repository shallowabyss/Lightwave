@version 2.3
@warnings
@name cp_CloneHierarchyRepeat

/*
	created by chris peterson
	chrisepeterson@gmail.com
	www.chrisepeterson.com

	last updated april 11, 2008
*/

generic
{

    varNumberClones = recall("varNumberClones", 1);

    reqbegin("cp_CloneHierarchyRepeat");
    reqsize(215,80);

    c1 = ctlinteger("Repeat ",varNumberClones);
    ctlposition(c1,45,15);

    return if !reqpost();
	
    varNumberClones = getvalue(c1);
    store("varNumberClones",varNumberClones);

    reqend();

	if(varNumberClones >= 1)
	{
	  for(i=1; i <= varNumberClones; i++)
    	  {
	     CommandInput("Generic_clonehierarchy");
	  }	
	}
	else
	{
	   error("Enter higher number");
	}
}

