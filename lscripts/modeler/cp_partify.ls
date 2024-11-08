@warnings
@version 2.8
@name cp_partify
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    september 18, 2009

    This script will create each group of polys into seperate parts and then
    break it apart based on those parts created.
    
    Need to do it based on polys left not points. Also show feedback when done.
*/
plyCnt;
pntCnt;
partNum = recall("partNum",1);
vPartBreak = recall("vPartBreak",1);
main
{
    reqbegin("cp_Partify");
    c1 = ctlinteger("# of Parts",partNum);
    c2 = ctlchoice(" ",vPartBreak,@"Partify","Break Apart"@);
    return if !reqpost();
    partNum = getvalue(c1);
    vPartBreak = getvalue(c2);
    store("partNum", partNum);
    store("vPartBreak", vPartBreak);
    reqend();
    if(vPartBreak == 1)
    {
      partify();
    }
    else
    {
      breakapart();
    }
}

partify
{
    currentLyr = lyrfg();
	emptyLyr = lyrempty();
	lyrsetbg(emptyLyr[1]);
    undogroupbegin();
    selmode(USER);
    partNum = 1;
	while(pointcount() > 0)
	{
        selpolygon(SET, POLYNDX, 1);
        selpolygon(SET, CONNECT);
        changepart("part_" + partNum);
        store("partNum", partNum);
        partNum++;
        cut();
        lyrswap();
        paste();
        lyrswap();
    }
    lyrswap();
    cut();
    lyrsetbg(currentLyr);
    lyrsetfg(currentLyr);
    paste();
    selunhide();
    undogroupend();
}

breakapart
{
    currentLyr = lyrfg();
	emptyLyr = lyrempty();
	lyrsetbg(emptyLyr[1]);
    undogroupbegin();
    selmode(USER);
    partsLeft = partNum;
	while(pointcount() > 0)
	{
    	selpolygon(SET, PART, "part_"+partsLeft);
        partsLeft--;
        cut();
        lyrswap();
        paste();
        lyrswap();
    }
    lyrswap();
    cut();
    lyrsetbg(currentLyr);
    lyrsetfg(currentLyr);
    paste();
    selunhide();
    undogroupend();
}