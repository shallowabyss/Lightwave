@warnings
@version 2.2
@name cp_LyrSurfRenamer

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 10 2009

    This script will rename the surfaces and/or layers of an object by adding
    a prefix.
*/

obj = Mesh(0);
vLayers = recall("vLayers",false);
vSurfaces = recall("vSurfaces",false);
prfx = recall("prfx","prefix_");
main
{

    reqbegin("cp_LyrNSurfRenamer");

    c1 = ctlstring("Prefix",prfx);
    c2 = ctlcheckbox("Add Prefix to Layers",vLayers);
    c3 = ctlcheckbox("Add Prefix to Surfaces",vSurfaces);

    return if !reqpost();

    prfx = getvalue(c1);
    vLayers = getvalue(c2);
    vSurfaces = getvalue(c3);

    store("prfx",prfx);
    store("vLayers",vLayers);
    store("vSurfaces",vSurfaces);
    reqend();
    
    if(vLayers)
    {
     doLayers();
    }
    if(vSurfaces)
    {
     doSurfaces();
    }
}

doLayers
{
    lyrswithdata = lyrdata();
    for(i=1; i<= size(lyrswithdata); i++)
    {
    lyrsetfg(lyrswithdata[i]);
    setlayername(prfx + obj.layerName(lyrswithdata[i]));
    }
}

doSurfaces
{
    surfNames = Surface(obj);
    if (surfNames)
    {
        for(i=1; i <= size(surfNames); i++)
        {
            renamesurface(surfNames[i], prfx + surfNames[i]);
        }
    }
}