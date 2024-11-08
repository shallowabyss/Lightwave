@warnings
@version 2.2
@script generic
@name cp_NewCamera

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    july 15 2012

    This script will create a new camera with the option
    of either targeting a new null or a pre-existing object.
*/

generic
{
		// Initialize variables
    vCamName = recall("vCamName","Camera");
    vTargetYN = recall("vTargetYN",true);
    vNewNullName = recall("vNewNullName","TargetNull"); 
    vParentNullName = recall("vParentNullName","ParentNull"); 
    vOtherTargets = nil;
    vChoice = recall("vChoice",1);
    vParentChoice = recall("vParentChoice",1);
    
    // Set the initial state for visibility/active functions
    c2 = 1; 
    c5 = 1;

    reqbegin("NewCamera");
    reqsize(523,250);

    c1 = ctlstring("Camera Name",vCamName);
    ctlposition(c1,34,13,269,20);

    c2 = ctlcheckbox("Target Item",vTargetYN);
    ctlposition(c2,34,38,272,20);

    c3 = ctlstring("Null Name",vNewNullName);
    ctlposition(c3,34,89,178,20);

    c4 = ctlmeshitems("Other Targets",vOtherTargets);
    ctlposition(c4,227,89,261,20);

    c5 = ctlchoice("Create new null to target?",vChoice,@"Yes","No"@);
    ctlposition(c5,34,60,270,20);

    c6 = ctlchoice("Parent camera and target to null?",vParentChoice,@"Yes","No"@);
    ctlposition(c6,34,120,270,20);
    
    c7 = ctlstring("Null Name",vParentNullName);
    ctlposition(c7,34,150,178,20);    
    
    c8 = ctltext("","Note: No parenting will be done unless a new target null is created.");
    ctlposition(c8,34,190,178,20);    

    // Set active states for controls
		ctlactive(c6,"disableNull",c7);
		ctlactive(c5,"disableNull",c3);
		ctlactive(c5,"disableObjects",c4);
		
		// Set visible states for controls
		ctlvisible(c2,"targetYesNo",c3);
		ctlvisible(c2,"targetYesNo",c4);		
		ctlvisible(c2,"targetYesNo",c5);
		ctlvisible(c2,"targetYesNo",c6);
		ctlvisible(c2,"targetYesNo",c7);
		
    return if !reqpost();

    vCamName = getvalue(c1);
    vTargetYN = getvalue(c2);
    vNewNullName = getvalue(c3);
    vOtherTargets = getvalue(c4);
    vChoice = getvalue(c5);
    vParentChoice = getvalue(c6);
    vParentNullName = getvalue(c7);
    store("vCamName",vCamName);
    store("vTargetYN",vTargetYN);
    store("vNewNullName",vNewNullName);
    store("vChoice",vChoice);   
    store("vParentChoice",vParentChoice);
    store("vParentNullName",vParentNullName);
    
    reqend();
    
  // Add a new camera
  AddCamera(vCamName);
  // Select the camera and store in array
  cam = Scene().getSelect(CAMERA);
  // Get the name of the camera
  camName = cam[1].name;
  	// Offset the target null in 5m on the Z axis
	Position(0.000000, 0.000000, -5.000);
	// Create a key for it incase autokey is off
	CreateKey(0);  
  // If the user checks the target option continue with this code
  if(vTargetYN == 1)
  {
  	// If they chose to use the new null
	  if(vChoice == 1)
	  {
		  // Add the target null
		  AddNull(vNewNullName);
		  // Select the target null and store in array
		  tgt = Scene().getSelect(MESH);
		  // Get the name of the target null
		  tgtName = tgt[1].name;
		}
		else
		{
			// Use the name from the pull down
			if(vOtherTargets != nil)
			{
				tgtName = vOtherTargets.name;
			}
			else
			{
				tgtName = nil;
			}
		}
		// Skip the targeting if the user did not choose an item to target
		if(tgtName != nil)
		{

		  // Select the camera
		  SelectItem(camName);
		  // Tell the camera to point at the target in the
		  // motion and the heading
		  HController(2);
		  PController(2);
		  // Set the camera's target to the target null
		  TargetItem(tgtName);
		  // Now we will only parent it if it is a new null to avoid problems with parenting existing items
		  if(vParentChoice == 1 && vChoice == 1)
			{
				// Add the target null
			  AddNull(vParentNullName);
			  // Select the target null and store in array
			  prt = Scene().getSelect(MESH);
			  // Get the name of the target null
			  prtName = prt[1].name;
			  // Select the camera
			  SelectItem(camName);
			  // Parent it to the parent
			  ParentItem(prtName);
			  // Make sure the camera is in the correct place due to the parenting
				// Offset the target null in -5m on the Z axis
				Position(0.000000, 0.000000, -5.000);
				// Create a key for it incase autokey is off
				CreateKey(0);
			  // Select the target
			  SelectItem(tgtName);
			  // Parent it to the parent
			  ParentItem(prtName);
				// Select the parent
				SelectItem(prtName);

			}
		}
	}
}


targetOther: value
{
  if(value == 2)
	{
    return 1;
  }
  else
  {
  	return 0;
  }
}

targetYesNo: value
{
  if(value == 1)
	{
    return 1;
  }
  else
  {
  	return 0;
  }
}

disableNull: value
{
  if(value == 1)
	{
    return 1;
  }
  else
  {
  	return 0;
  }
}

disableObjects: value
{
	if(value != 1)
	{
    return 1;
  }
  else
  {
  	return 0;
  }
}

callback
{
	requpdate();
}