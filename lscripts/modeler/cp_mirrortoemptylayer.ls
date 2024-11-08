@warnings
@version 2.7
@name cp_MirrorToEmptyLayer

/*
    by chris peterson
    november 20 2008
    
    This script copies your selected geometry to a background layer, mirrors it, 
    switches back to your previous foreground layer and then puts the mirrored
    geometry in a background layer.
*/

main
{
    
    vAx = recall("vAx", 1);
    vBGFG = recall("vBGFG", 1);
    vPart = recall("vPart", false);
    vPartName = recall("vPartName", "Mirror");
    
    reqbegin("cp_MirrorToEmptyLayer");
    reqsize(225,180);

    c1 = ctlchoice("Axis              ",vAx,@"X","Y","Z"@);
    ctlposition(c1,38,20);

    c2 = ctlchoice("Mirror Layer  ",vBGFG,@"BG","FG"@);
    ctlposition(c2,38,43);
    
    c3 = ctlcheckbox("Make mirror mesh a PART",vPart);
    ctlposition(c3,38,66);
    
    
    c4 = ctlstring("Partname",vPartName);
    ctlposition(c4,38,89);
    ctlvisible(c3,"toggleOn",c4);
    return if !reqpost();

    vAx = getvalue(c1);
    vBGFG = getvalue(c2);
    vPart = getvalue(c3);
    vPartName = getvalue(c4);
    store("vAx",vAx);    
    store("vBGFG",vBGFG);
    store("vPart",vPart);    
    store("vPartName",vPartName);
    
    reqend();

    if(vAx == 1) { maxis = "X";}
    if(vAx == 2) { maxis = "Y";}
    if(vAx == 3) { maxis = "Z";}

    undogroupbegin();
    selmode(USER);
    copy();
    prevLyr = lyrfg();
    empty = lyrempty();
    lyrsetfg(empty[1]);
    paste();
    selpolygon(CLEAR);
    selpolygon(SET,NVGT,0);
    mirror(maxis,0); 
    delete();
    if(vPart == true && vPartName != "")
    {
        changepart(vPartName);
    }
    lyrsetfg(prevLyr);
    if(vBGFG == 1)
    {
      lyrsetbg(empty[1]);
    }   
    else 
    {
        prevLyrSize = size(prevLyr) + 1;
        prevLyr[prevLyrSize] = empty[1];
        lyrsetfg(prevLyr);
    } 
    
    undogroupend(); 
}

toggleOn: value
{
   return(value);
}
