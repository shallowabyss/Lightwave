@warnings
@version 2.2
@name cp_displaySubpatchLevel
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    september 29 2009

	this script will take each selected/or all object(s) in layout and set its
    display subpatch level to what the user chooses.
*/

generic
{

    vDSL = recall("vDSL",1);
    vSelAll = recall("vSelAll",1);

    reqbegin("cp_displaySubpatchLevel");
    c1 = ctlinteger("Display Subpatch Level",vDSL);
    c2 = ctlchoice("Objects",vSelAll,@"Selected","All"@);
    return if !reqpost();
    vDSL = getvalue(c1);
    vSelAll = getvalue(c2);
    store("vSelAll",vSelAll);
    store("vDSL",vDSL);
    reqend();
    
    if(vSelAll ==1)
    {
      meshselection = Scene().getSelect(MESH);
      for(i=1; i <= size(meshselection); i++)
      {
      SelectItem(meshselection[i].id);
      CommandInput("SubPatchLevel " + vDSL);
      }
    }
    else
    {
      SelectAllObjects();
      CommandInput("SubPatchLevel " + vDSL);
    }
}