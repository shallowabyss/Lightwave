@warnings
@version 2.8
@name cp_ExcludeAllLights

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    june 15 2009
    
    This script allow you to quickly exclude all of the scene lights
    from the selected objects.
*/


selection;
kind;
lightAry;
lightInc = 1;
   	
generic
{
	mesh = Mesh() || error("No Object Loaded!");
    selection = Scene().getSelect(MESH);      
      
   	SelectAllLights();
    lights = Scene().getSelect(LIGHT);
		
	for(i=1; i <= size(selection); i++)
	{
		SelectItem(selection[i].id);
        for(j=1; j <= size(lights); j++)
        {
			ExcludeLight(lights[j].id);
		}
	}	
	SelectItem(selection[1].id);
	for(i=2; i <= size(selection); i++)
	{
		AddToSelection(selection[i].id);
	}
    SelectItem(Light().id);
}
