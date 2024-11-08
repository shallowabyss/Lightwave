@warnings
@version 2.2
@script generic
@name HiddenToUnseen

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 30, 2011

    This script finds all objects that are hidden from the viewport
    and makes them unseen by camera. It will remove the UnseenByCamera
    flag on all objects that are visible in the viewport.
    
*/

// Declare global variables
showItemIDArray;		// Object visibility array
unseenItemIDArray;	// Object unseenbycamera array
sinc = 1;						// showItemIDArray incrementing variable
uinc = 1;						// showItemIDArray incrementing variable
	
generic
{
	// Create a temporary copy of our scene to check for the UnseenByCamera flags
	file = getdir("Temp") + getsep() +"check.lws";
	SaveSceneCopy(file);
	
	f = File(file,"r") || error("Cannot open file: ",file,"");
		if(f.linecount())
		{  
			while(!f.eof()) // while not end of file, continue
			{
				curLine = f.read();
				if(curLine.contains("AddNullObject"))
				{
					// AddNullObject 10000000 Null 
					// Parse the id from the 2nd position in the line
					tokens = parse(" ",curLine);
					tempID = tokens[2];
				}
				else if(curLine.contains("LoadObjectLayer"))
				{
					// LoadObjectLayer 1 10000001 Objects/object_v001.lwo
					// Parse the id from the 3rd position in the line
					tokens = parse(" ",curLine);
					tempID = tokens[3];
				}
				else if(curLine.contains("ShowObject 0 "))
				{
					// If either the AddNull or LoadObjectLayer were found previously
					// and we now come across ShowObject 0 which is the visibility flag
					// for the object in the scene file, add it to our array and increment
					// our to the next position in our array.
					showItemIDArray[sinc] = tempID;
					sinc++;
				}
				else if(curLine.contains("UnseenByCamera"))
				{
					// If either the AddNull or LoadObjectLayer were found previously
					// and we now come across unseenbycamera in the scene file, add it
					// to our array and increment our to the next position in our array.
					unseenItemIDArray[uinc] = tempID;
					uinc++;
				}
			}
		}
		f.close();
		
		if(showItemIDArray != nil)
		{
			if(unseenItemIDArray != nil)
			{
				for(x=1; x<= size(unseenItemIDArray); x++)
				{
					// Disable all UnseenByCamera flags on every object that has it enabled.
					cmd = "SelectItem " + unseenItemIDArray[x];
					CommandInput(cmd);
					UnseenByCamera();
				}
			}
			for(y=1; y<= size(showItemIDArray); y++)
			{
				// For all of the hidden objects we now will apply the UnseenByCamera flag.
				cmd = "SelectItem " + showItemIDArray[y];
				CommandInput(cmd);
				UnseenByCamera();
			}
		}
		else
		{
			StatusMsg("No objects hidden in the viewport.");
		}
}