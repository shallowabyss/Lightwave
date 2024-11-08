@version 2.7
@warnings
@name cp_CycleApplySurfaces

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 23 2008
    
    This script will cycle through and apply surfaces to the selected polygons.
*/

main
{
	currentSurface = nextsurface();
	tmpSurf = currentSurface;  // for comparing the next surface to nil
	test = true;       // break the loop of dialogs
	thruList = false;  // will prevent from adding the already added surfaces to the array of surfaces

	while(test != false)
	{
	        reqbegin("cp_CycleApplySurfaces");
            reqsize(231,98);
                c1 = ctltext("","To cycle press OK to stop press Cancel");
                ctlposition(c1,20,27,186,13);
            
            if(!reqpost())
            {
                // If cancelled, exit the dialog normally
                test = false;
                return;
            }
        
            reqend();
            
            if((tmpSurf = nextsurface(currentSurface)) == nil)
    	   {
                thruList = true;
                selmode(DIRECT);
		        changesurface(currentSurface);
		        currentSurface = surfaceList[1]; // reset to top of surface list
            }
            else 
            {   
              if(thruList == false)
              {
    		  surfaceList += currentSurface;  // array of surfaces
    		  }
              selmode(DIRECT);
		      changesurface(currentSurface);
		      currentSurface = nextsurface(currentSurface);
            }	 
	}
}

