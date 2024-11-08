@warnings
@version 2.2
@name cp_MoveIt
@script modeler

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    july 25 2012

    This script will save user defined offsets for moving selected points
    or polygons and move them accordingly.
*/

// Recall/Initialize values
offset1 = recall("offset1","<0,0,0>");
offset2 = recall("offset2","<0,0,0>");
offset3 = recall("offset3","<0,0,0>");
offset4 = recall("offset4","<0,0,0>");
offset5 = recall("offset5","<0,0,0>");
offset6 = recall("offset6","<0,0,0>");
offset7 = recall("offset7","<0,0,0>");
offset8 = recall("offset8","<0,0,0>");
offset9 = recall("offset9","<0,0,0>");
offset10 = recall("offset10","<0,0,0>");

// Populate the list of values
offsetList = 	@offset1,offset2,offset3,offset4,offset5,offset6,offset7,offset8,offset9,offset10@;
// Setup the popup list
popupList = @"Preset 1","Preset 2","Preset 3","Preset 4","Preset 5","Preset 6","Preset 7","Preset 8","Preset 9","Preset 10"@;
// Recall the previous choice the user selected
presetChoice = recall("presetChoice", 1);
// Make all controls global
c1;
c2;
c3;
c4;
		
main
{
		// Recall the last used values from the presetChoice
		tokensQuotes = parse("\"",offsetList[presetChoice]);
		tokensRtBracket = parse(">",tokensQuotes[1]);
		tokensLTBracket = parse("<",tokensRtBracket[1]);
		tokensComma = parse(",",tokensLTBracket[1]);
	  // Set the X Y Z from the store values
		distX = number(tokensComma[1]);
		distY = number(tokensComma[2]);
		distZ = number(tokensComma[3]);

		// Launch interface
    reqbegin("cp_MoveIt");
    reqsize(230,220);
		c0 = ctltext("","           cp_MoveIt","     by Chris Peterson","chrisepeterson@gmail.com");
    ctlposition(c0,55,10);
    
    c1 = ctldistance("X",distX);
    ctlposition(c1,22,90);

    c2 = ctldistance("Y",distY);
    ctlposition(c2,22,115);

    c3 = ctldistance("Z",distZ);
    ctlposition(c3,22,140);

    c4 = ctlpopup("Presets",presetChoice,popupList);
    ctlposition(c4,22,65);
    
		ctlrefresh(c1,"setPresetChoice");
		ctlrefresh(c2,"setPresetChoice");
		ctlrefresh(c3,"setPresetChoice");
		ctlrefresh(c4,"refreshList");
		
    return if !reqpost();

    distX = getvalue(c1);
    distY = getvalue(c2);
    distZ = getvalue(c3);
    presetChoice = getvalue(c4);
    
    // Store all of the vectors for future script executions
    store("presetChoice",presetChoice); 
		store("offset1",offsetList[1]);
		store("offset2",offsetList[2]);
		store("offset3",offsetList[3]);
		store("offset4",offsetList[4]);
		store("offset5",offsetList[5]);
		store("offset6",offsetList[6]);
		store("offset7",offsetList[7]);
		store("offset8",offsetList[8]);
		store("offset9",offsetList[9]);
		store("offset10",offsetList[10]);
		
    reqend();
    
    // Take the current selection
    selmode(USER);
    // Move the selection according to the defined values
    move(distX,distY,distZ);
}

setPresetChoice:value
{
	// When the user changes either the X,Y,or Z save the vector information back to our list of vectors
	tempVector = "\"<" + getvalue(c1) + "," + getvalue(c2) + "," + getvalue(c3) + ">\"";
	offsetList[getvalue(c4)] = tempVector;
}

refreshList: value
{	
	// When the user changes the popup
	// Split out the vector from the string
	tokensQuotes = parse("\"",offsetList[value]);
	tokensRtBracket = parse(">",tokensQuotes[1]);
	tokensLTBracket = parse("<",tokensRtBracket[1]);
	tokensComma = parse(",",tokensLTBracket[1]);
	
	// Set the values in the XYZ fields
  setvalue(c1,tokensComma[1]);
  setvalue(c2,tokensComma[2]);
  setvalue(c3,tokensComma[3]);
}