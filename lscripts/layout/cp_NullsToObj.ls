@warnings
@version 2.2
@script generic
@name cp_NullsToObj
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 13 2011
    
    This script will save out the null positions of a scene as vertices in an obj file.
*/
generic
{
	scn = Scene();
	tokens = split(scn.filename);
	selection;
	vSelection = 1;
  fname = getdir("Objects") + getsep() + tokens[3] + ".obj";

    reqbegin("cp_NullsToObj");
    reqsize(487,97);

    c1 = ctlchoice("Export",vSelection,@"Selected Nulls","All Nulls"@);
    ctlposition(c1,37,12);

    c2 = ctlfilename("Save As",fname);
    ctlposition(c2,37,37,381,18);

    return if !reqpost();

    vSelection = getvalue(c1);
    fname = getvalue(c2);

    reqend();

	if(vSelection == 1)
	{
		selection = scn.getSelect(MESH);
	}
	else
	{
		SelectAllObjects();
		selection = scn.getSelect(MESH);
	}
	if(size(selection) > 0)
	{
		f = File(fname,"w") || error("Cannot open file'",fname,"'");
		f.writeln("#### Exported null data from cp_Null2Obj");
		f.writeln("#### from the scene file: " + scn.filename);
		tokens = split(fname);
		f.writeln("o " + tokens[3] + tokens[4]);
		f.writeln("g default");
		for(i=1; i<=size(selection); i++)
		{
			SelectItem(selection[i].id);
			if(selection[i].null)
			{
				coords = selection[i].getWorldPosition(0);
				f.writeln("v " + coords.x + " " + coords.y + " " + (coords.z*-1));
			}
		}
		f.close();
	}
	if(size(selection) == 0)
	{
		error("Please make sure that there are some nulls in your scene.");
	}
}