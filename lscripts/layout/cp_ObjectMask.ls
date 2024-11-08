@warnings
@version 2.2
@script generic
@name cp_ObjectMask

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    december 10 2013

    This script will generate a black and white matte pass of the selected objects.
	Selected objects will be matte white, deselected objects will be matte black constant alpha black.
	This will also disable all lights and turn off radiosity.
*/

generic
{
	/********************** initialize variables *********************************/
	// Define our selection array
	selection;
	// Define objects not selected
	nonselection;
	// Define our object list (of the items we will get from our scene file)
	objArry;
	// Define our matte list 
	matteArry;
	// Define our incrementer variable for objArry
	objArrayInc = 0;
	// Define our placeholder for the object ID
	objectID = "";
	// Define our findMatte variable
	findMatte = 0;
	
	// Define our temporary directory for scanning a copy of our scene file
	// to retrieve a list of objects and their matte status
	tempFile = getdir(TEMPDIR) + getsep() + Scene().name;

	/********************** Process objects in the scene to determine selection *********************************/
	
	// Loop through mesh objects
	m = Mesh();
	while(m)
	{
		// Make sure the item is not a null as that wouldnt render anything
		if (m.null == false)
		{
			// If item is selected
			if(m.selected)
			{
				// Add it to our selection array
				selection[selection.size()+1] = m;
			}
			else
			{
				// Add it to our selection array
				nonselection[nonselection.size()+1] = m;
			}
		}
		// Check next object
		m = m.next();
	}
	
	// Make sure there is a selection, if not abort the script and alert user.
	if(!selection)
	{
		error("Error: Please select an object or objects and rerun the script.");
		return;
	}
	
	/********************** Save dialog prompt *********************************/
	saveBefore = 1;

    reqbegin("cp_ObjectMask");
    reqsize(439,177);

    c1 = ctlchoice("Save scene before proceeding?",saveBefore,@"Yes","No"@);
    ctlposition(c1,24,87,377,22);

    c2 = ctltext("","         cp_ObjectMask","        by Chris Peterson","chrisepeterson@gmail.com");
    ctlposition(c2,144,20,127,39);

    return if !reqpost();

    saveBefore = getvalue(c1);

    reqend();
	
	// Save the scene if the user opted to save the scene
	if(saveBefore)
	{	
		// Autoconfirm prevents confirmation dialogs
		AutoConfirm(1);
		SaveScene();
		AutoConfirm(0);
	}

	
	/********************** Settings we want to disable to optimize this matte pass *********************************/
	// Turn off lights
	l = Light();
	while(l)
	{
		SelectItem(l.id);
		CommandInput("ItemActive 0");
		l = l.next();
	}
	
	// Disable radiosity
	if(Scene().renderopts[16])
	{
		EnableRadiosity();
	}
	
	
	
	/********************** Process the scene file to retrieve matte settings that arent accessible via lscript *********************************/
	// Save a copy of our scene for processing
	SaveSceneCopy(tempFile);
	
	
	f = File(tempFile,"r") || error("Cannot open file",tempFile);
	if(f.linecount())
	{
		while(!f.eof())
		{
			line = f.read();
			if(line.contains("LoadObjectLayer"))
			{
				// Get id from line
				tokens = parse(" ",line);

				// Check statistics for ID once it has been found
				if(objectID != "")
				{	
					objArry[objArrayInc] = objectID; 
					matteArry[objArrayInc] = int(findMatte); 
					findMatte = false;	
				}
				
				if(line.contains("LoadObjectLayer"))
				{
					objectID = tokens[3];
					// Increment the object array incrementer
					objArrayInc++;
					
				}
			}
			
			else if(line.contains("MatteObject"))
			{
				findMatte = true; 
			}
			else
			{
				// do nothing for all other lines
			}
		} // end while loop
		
		// because last object wont have a load object layer tag to update the values
		if(objectID != "")
		{
			objArry[objArrayInc] = objectID; 
			matteArry[objArrayInc] = int(findMatte); 
			findMatte = false;	
		}
		else 
		{
		}
	}
	
	
	/********************** Process the objects and set their mattes / alpha parameters *********************************/
	
	
	// Now we have the list of objects in the scene and we have the corresponding matte list
	// Loop through the selection and compare against the list of objects and see if the object is matted
	for(i=1;i<=selection.size();i++)
	{
		// Progress bar
		StatusMsg("{" + i/sizeof(selection) + "} Processing");
		
		// Use our fixed color array
		selID = "";
		matteFlag = "";

		selectionIDTokens = parse("x", str(hex(selection[i].id)) );
		for(m=1;m<=sizeof(objArry);m++)
		{
			if(objArry[m] == selectionIDTokens[2])
			{
				selID = objArry[m];
				matteFlag = matteArry[m];					
				break;
			}
		}
	
		// Select the item
		SelectItem(selection[i].id);
			
		// Error checking
		if(selID !="") 
		{
			// Set the matte color - Toggle it on to change it if needed, then toggle off
			if(matteFlag == "0")
			{
				CommandInput("MatteObject"); 
				CommandInput("MatteColor 1 1 1");
				CommandInput("UnseenByAlphaChannel 0");
			}
			else
			{
				CommandInput("MatteColor 1 1 1");
				CommandInput("UnseenByAlphaChannel 0");
			}
		}
	}
	// Set all other objects to matte black
	for(i=1;i<=nonselection.size();i++)
	{
		// Progress bar
		StatusMsg("{" + i/sizeof(nonselection) + "} Processing");
		
		// Use our fixed color array
		selID = "";
		matteFlag = "";

		selectionIDTokens = parse("x", str(hex(nonselection[i].id)) );
		for(m=1;m<=sizeof(objArry);m++)
		{
			if(objArry[m] == selectionIDTokens[2])
			{
				selID = objArry[m];
				matteFlag = matteArry[m];					
				break;
			}
		}
	
		// Select the item
		SelectItem(nonselection[i].id);
			
		// Error checking
		if(selID !="") 
		{
			// Set the matte color - Toggle it on to change it if needed, then toggle off
			if(matteFlag == "0")
			{
				CommandInput("MatteObject"); 
				CommandInput("MatteColor 0 0 0");
				CommandInput("UnseenByAlphaChannel 2");
			}
			else
			{
				CommandInput("MatteColor 0 0 0");
				CommandInput("UnseenByAlphaChannel 2");
			}
		}
	}
	
	
	/********************** Finish up by reselecting the initial selection *********************************/
	// Reselect our selection
	StatusMsg("{" + 1/selection.size() + "} Processing");
	SelectItem(selection[1].id);
	for(i=2;i<=selection.size();i++)
	{
		// Progress bar
		StatusMsg("{" + i/selection.size() + "} Processing");
		AddToSelection(selection[i].id);
	}
	// Everything completed
	StatusMsg("Processing done. Please save your matte scene now.");
}