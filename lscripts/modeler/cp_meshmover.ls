@version 2.4
@warnings
@name "cp_MeshMover"
//   3/25/2006   : Created script
//   Known limitations:  Will not copy over pivots or hierarchy


main
{
   foregroundLayer = lyrfg();			// Get current layer store as foregroundLayer
   layerdata = lyrdata();			// Fill the array with all layers
   startLayer = 1;				// Give the start layer a name
   curObj = Mesh(0);			        // Create a mesh from the current object so
						// that modeler will recognize object.
   curName  = curObj.name;			// Assign the filename to a variable

    if(!layerdata){				// if no geometry throw error
    	 lyrsetfg(1);				// Set foreground to first layer
         error("No geometry detected");         // Tell user
	 return 0;			        // Tell it to be done
    }


	new();					// Create a new object to send layers to
	secondObj = Mesh(0);			// Create a mesh from the current object so
						// that modeler will recognize the object
	secondName = secondObj.name;	        // Assign the filename to a variable
	setobject(curName);			// Set to first object
	foregroundLayer.sortA();

	for(i=1; i <= sizeof(foregroundLayer); i++)
	{
						// If i is not past the selected
						// layers in the foreground
		lyrsetfg(foregroundLayer[i]);	// Set the foreground layer to the select
						// # in the array
		lyrname = curObj.layerName(foregroundLayer[i]);
						// Get the layer name of the selected layer
		selmode(GLOBAL);		// Select everything in that layer
		copy();				// Copy contents to clipboard
		setobject(secondName);		// Set the object to a different object
		lyrsetfg(startLayer);		// Find the next empty layer
		paste();			// Paste geometry in layer

		if(lyrname){			// If it has a layer name
		setlayername(lyrname);		// Set it to the layer name
		}
		else{
		setlayername("unnamed");	// If not just call it unnamed
		}

		setobject(curName);		// Set to first object
		startLayer += 1;		// Increment startLayer in the new object
		}

	setobject(secondName);			// When done set to new object
}
