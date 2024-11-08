@warnings
@version 2.4
@name "cp_FixedCopyPaste"

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    march 10 2006
    
    This script will take the selection, copy it, paste it, and select it.
    In my mind this is how copying and pasting should work in Lightwave.
*/

main
{

pntCnt = pointcount();  	// Get # Points

if(pntCnt == 0){
error("No points selected."); 	// Incase empty
}


if(pntCnt > 0){
   selmode(USER);		// Only those elements selected by the user. 

   copy();			// Copy geometry

   emptyLyr = lyrempty();       // Create an empty layer

   lyrsetbg(emptyLyr[1]);     	// Make background that layer

   lyrswap();			// Invert Layers

   paste();			// Pastes the geometry
   
   cut();			// Cuts it again

   lyrswap();   		// Swap back

   selmode(USER);		// Select Nothing

   selinvert();			// Select All

   paste();			// Paste

   selinvert();			// Select new geometry

   info("New geometry created");// Feedback
}



}

