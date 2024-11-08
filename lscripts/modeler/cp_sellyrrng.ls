@warnings
@version 2.7
@name cp_SelLyrRng

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 17 2008
  
    This script will append a range of layers to your current foreground selection.
*/

curFg = lyrfg();
main
{
    startNum = recall("startNum", 1);
    endNum = recall("endNum", 2);

    reqbegin("cp_SelLyrRng");
    reqsize(223,132);

    c1 = ctlinteger("Start",startNum);
    ctlposition(c1,59,45);

    c2 = ctlinteger("End",endNum);
    ctlposition(c2,62,71);

    c3 = ctltext("","Enter the range of layers to select");
    ctlposition(c3,32,17,158,13);
    
    return if !reqpost();

    startNum = getvalue(c1);
    endNum = getvalue(c2);
    store("endNum", endNum);
    store("startNum", startNum);
    reqend();
    
  startNumberSize = size(curFg);
  diffNum = endNum - startNum;
  
  if(diffNum > 1)
  {
    f = 1;
    for(i=startNum; i<= endNum; i++)
    {

      curFg[startNumberSize+f] = i;
      curFg.sortA();
      f++;
    }
    lyrsetfg(curFg);
  }
}
