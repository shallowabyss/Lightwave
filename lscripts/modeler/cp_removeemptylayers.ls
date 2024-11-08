@warnings
@version 2.7
@name "cp_RemoveEmptyLayers"

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    december 15 2006
    
    This script will remove all the empty layers from a model.
    Also has a single undo to go back prior to running the script.
*/

main
{
    varSetName = recall("varSetName",false);

    reqbegin("cp_RemoveEmptyLayers");

    c1 = ctlcheckbox("Keep layer names with associated layers?",varSetName);
    c2 = ctltext("","***Layer name changes are undoable***");

    return if !reqpost();

    varSetName = getvalue(c1);
    store("varSetName", varSetName);
    reqend();
    
    curObj = Mesh(0);
    dtLyr = lyrdata();
    mtLyr = lyrempty();
    dtLyr.sortA();
    mtLyr.sortA();
    selmode(USER);
    selpolygon(CLEAR);
    undogroupbegin();
    for(i=1; i <= size(dtLyr); i++)
    {
            lyrsetfg(dtLyr[i]);
            lyrname = curObj.layerName(dtLyr[i]);
            selunhide();
            cut();
            lyrsetfg(i);
            paste();
            if(lyrname && varSetName == 1)
            {	
        		setlayername(lyrname);
        	}
    }
    undogroupend();
}
