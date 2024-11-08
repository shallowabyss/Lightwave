@warnings
@version 2.7
@name cp_Selector
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 13 2008

    This script will select or deselect all the points along the chosen axis.
*/

    vAndZero = recall("vAndZero",true);
    vSelection = recall("vSelection",1);
    vXPlus = recall("vXPlus",false);
    vXNeg =  recall("vXNeg",false);
    vYPlus = recall("vYPlus",false);
    vYNeg =  recall("vYNeg",false);
    vZPlus = recall("vZPlus",false);
    vZNeg =  recall("vZNeg",false);


selectChange: axis, selectionMode
{
selmode(GLOBAL);
pntcnt = pointcount();
spnts = 0;
a = 1;

      editbegin();
      moninit(pntcnt);
      for(i=1; i <= pntcnt; i++)
      {   
          monstep();      
          valpoint[i] = pointinfo(points[i]); 
          if(axis == "XPlus")
          {
              if(vAndZero == 1)
              {
                if(valpoint[i].x >= 0)
                {
                spnts[a] = points[i];
                a++;
                }
              } 
              else 
              {
                if(valpoint[i].x > 0)
                {
                spnts[a] = points[i];
                a++;
                }      
              }  
          }
          if(axis == "YPlus")
          {
              if(vAndZero == 1)
              {
                if(valpoint[i].y >= 0)
                {
                spnts[a] = points[i];
                a++;
                }
              } 
              else 
              {
                if(valpoint[i].y > 0)
                {
                spnts[a] = points[i];
                a++;
                }      
              }  
          }
          if(axis == "ZPlus")
          {
              if(vAndZero == 1)
              {
                if(valpoint[i].z >= 0)
                {
                spnts[a] = points[i];
                a++;
                }
              } 
              else 
              {
                if(valpoint[i].z > 0)
                {
                spnts[a] = points[i];
                a++;
                }      
              }  
          }
          if(axis == "XNeg")
          {
              if(vAndZero == 1)
              {
                if(valpoint[i].x <= 0)
                {
                spnts[a] = points[i];
                a++;
                }
              } 
              else 
              {
                if(valpoint[i].x < 0)
                {
                spnts[a] = points[i];
                a++;
                }      
              }              
          }
          if(axis == "YNeg")
          {
              if(vAndZero == 1)
              {
                  if(valpoint[i].y <= 0)
                  {
                  spnts[a] = points[i];
                  a++;
                  }
              } 
              else 
              {
                  if(valpoint[i].y < 0)
                  {
                  spnts[a] = points[i];
                  a++;
                  }       
              }
          }
          if(axis == "ZNeg")
          {
              if(vAndZero == 1)
              {
                  if(valpoint[i].z <= 0)
                  {
                  spnts[a] = points[i];
                  a++;
                  }
              } 
              else 
              {
                  if(valpoint[i].z < 0)
                  {
                  spnts[a] = points[i];
                  a++;          
                  }
              }
          }       
       } 
       monend();
       editend();
      
       if(size(spnts) > 0)
       {
       selmode(USER);
         if(selectionMode == "Add")
         {
         selpoint(SET,POINTID,spnts);
         }
         if(selectionMode == "Subtract")
         {
         selpoint(CLEAR,POINTID,spnts);
         }
       }
}

main
{

    selmode(USER);
    pntcnt = pointcount();
    if(!pntcnt)
    {
    error("No geometry can be found.");
    return;
    }
    
    reqbegin("cp_Selector");
    reqsize(215,269);

    c1 = ctlchoice("Selection",vSelection,@"Add","Subtract"@);
    ctlposition(c1,30,42);

    c2 = ctlcheckbox("X+",vXPlus);
    ctlposition(c2,42,69);
    c3 = ctlcheckbox("X-",vXNeg);
    ctlposition(c3,125,69);
    
    c4 = ctlcheckbox("Y+",vYPlus);
    ctlposition(c4,42,96);
    c5 = ctlcheckbox("Y-",vYNeg);
    ctlposition(c5,125,96);
    
    c6 = ctlcheckbox("Z+",vZPlus);
    ctlposition(c6,42,123);
    c7 = ctlcheckbox("Z-",vZNeg);
    ctlposition(c7,125,123);

    c8 = ctlcheckbox("Include Points at Origin",vAndZero);
    ctlposition(c8,35,160);

    return if !reqpost();

    vSelection = getvalue(c1);
    vXPlus = getvalue(c2);
    vXNeg = getvalue(c3);
    vYPlus = getvalue(c4);
    vYNeg = getvalue(c5);
    vZPlus = getvalue(c6);
    vZNeg = getvalue(c7);
    vAndZero = getvalue(c8);


    store("vSelection", vSelection);
    store("vXPlus", vXPlus);
    store("vXNeg", vXNeg);
    store("vYPlus", vYPlus);
    store("vYNeg", vYNeg);
    store("vZPlus", vZPlus);
    store("vZNeg", vZNeg);
    store("vAndZero", vAndZero);

    reqend();
 


    if(vSelection == 1){
     k = "Add";
    } else {
     k = "Subtract";
    }
    if(vXPlus > 0)
    {
      selectChange("XPlus",k);
    }
    if(vYPlus > 0)
    {
      selectChange("YPlus",k);
    }
    if(vZPlus > 0)
    {
      selectChange("ZPlus",k);
    }
    if(vXNeg > 0)
    {
      selectChange("XNeg",k);
    }
    if(vYNeg > 0)
    {
      selectChange("YNeg",k);
    }
    if(vZNeg > 0)
    {
      selectChange("ZNeg",k);
    } 
}
