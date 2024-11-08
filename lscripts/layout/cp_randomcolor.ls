@version 2.8
@warnings
@name cp_RandomColor

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 8 2009
    
    This script will apply a random color to each object (to help with
    visibility of wireframes).
*/

generic
{
    objSelection =  Scene().getSelect();
    if(objSelection)
    {
		for(i=1; i <= size(objSelection); i++)
		{
            SelectItem(objSelection[i].id);
            vColor = random(1,15);
    		vC = integer(vColor) - 1;
    		color = "ItemColor " + vC;
    		CommandInput(color);
		}
    }
}

