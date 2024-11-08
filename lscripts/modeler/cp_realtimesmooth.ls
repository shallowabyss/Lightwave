@warnings
@version 2.7
@name cp_RealTimeSmooth
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    july 15, 2009
    
    This script will allow you to preview your smooth and only use a single undo.
*/

c;
firstChange = false;
main
{
  pntCnt = pointcount();
  if(!pntCnt)
  {
    error("There are no points.");
    break;
  }

    smStrength = recall("smStrength",1);
    smIterations = recall("smIterations",1);
    reqbegin("cp_RealTimeSmooth");
    c[1] = ctlslider("Strength",smStrength,1,100);
    c[2] = ctlslider("Iterations",smIterations,1,100);
    ctlrefresh(c[1], "updateValue");
    ctlrefresh(c[2], "updateValue");
    if(!reqpost())
    {
        undo();
        return;
    }
    smStrength = getvalue(c[1]);
    smIterations = getvalue(c[2]);
    store("smStrength",smStrength);
    store("smIterations",smIterations);
    reqend();
}
updateValue: value
{
	doSmooth();
}
doSmooth
{
    smStrength = getvalue(c[1]);
    smIterations = getvalue(c[2]);
    selmode(USER);
    if(firstChange == false)
    {
        smooth(smIterations,smStrength);
        firstChange = true;
    } 
    else
    {
        undo();
        smooth(smIterations,smStrength);
    }  
}
