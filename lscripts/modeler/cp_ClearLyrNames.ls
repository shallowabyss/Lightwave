@warnings
@version 2.3
@name "cp_ClearLyrNames"
//   author chris peterson -  chrisepeterson@gmail.com
//   07/03/2007   : Created script

main {
    datalayers = lyrdata();                    // Store array of datalayers into variable

     if(!datalayers){                          // if no geometry throw error
           error("No geometry detected");      // Tell user
      }

    datalayers.sortA();                        // Sort from Lowest to Highest
 
    clearWhat = recall("clearWhat",1);
    lyrToClear = recall("lyrToClear",1.0);

    reqbegin("cp_ClearLyrNames");
    reqsize(195,165);

    c1 = ctlinteger("Layer",lyrToClear);
    ctlposition(c1,45,58,108,20);

    c2 = ctlchoice("Clear",clearWhat,@"Single","All"@);
    ctlposition(c2,22,82,132,20);

    c3 = ctltext("","      cp_ClearLyrNames","        by chris peterson","chrisepeterson@gmail.com");
    ctlposition(c3,34,5,127,39);

    c4 = ctltext("","Note: There is no undo for this action.");
    ctlposition(c4,8,107,127,39);

    return if !reqpost();

    lyrToClear = getvalue(c1);
    clearWhat = getvalue(c2);
    store("clearWhat",clearWhat);

    reqend();

  if(!lyrToClear && clearWhat == 1){             // If they chose
    //store("lyrToClear", 1.0);                  // Set lyrToClear to 1.0 for future usage
    error("You must enter an integer.");
  }

  if(clearWhat == 1){
    store("lyrToClear",lyrToClear);              // Only save lyrToClear if Single layer is called
    lyrsetfg(lyrToClear);                        // Change to the layer that needs to be changed
    setlayername("");                            // Erase layer name
    lyrsetfg(datalayers[1]);                     // Set back to the first datalayer
  }

  else {
        for(i=1; i <= sizeof(datalayers); i++){    // Loop until it matches the size of the array
            lyrsetfg(datalayers[i]);            // Set the foreground layer to the select # in the array
            setlayername("");                   // Set layer name to nothing
        }
        lyrsetfg(datalayers[1]);                // Set to first layer of the object when done
    }
}




