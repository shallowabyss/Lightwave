@warnings
@version 2.7
@name cp_SelectSurfName
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 31 2008
    
    This script will allow you to search for a partial surface name and either add it
    to your current selection, or drop your current selection and then add any surfaces
    which match the search criteria.
*/
main 
{
    vSurfSrchStr = recall("vSurfSrchStr", "Default");
    vSelectionChoice = recall("vSelectionChoice", 1);
    reqbegin("cp_SelectSurfName");
    
    c1 = ctlstring("Search string",vSurfSrchStr);
    c2 = ctlchoice("Current Selection:",vSelectionChoice,@"Append","Deselect"@);
    
    return if !reqpost();

    vSurfSrchStr = getvalue(c1);
    vSelectionChoice = getvalue(c2);
    store("vSurfSrchStr",vSurfSrchStr);
    store("vSelectionChoice",vSelectionChoice);
    reqend();

    undogroupbegin();
    if(vSelectionChoice == 2)
    {
        selmode(USER);
        selpolygon(CLEAR);
    }
    surfObj = nextsurface();
        while(true)
        {
            if((surfObj = nextsurface(surfObj)) == nil)
            break;
    
               if(surfObj)
              {
                  if(surfObj.contains(vSurfSrchStr))
                  {
                      selmode(USER);
                      selpolygon(SET,SURFACE,surfObj);
                  }
              }
        }
    undogroupend();
}


