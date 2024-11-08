@warnings
@version 2.8
@name cp_addRandomRotation
@asyncspawn

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    may 11 2009
    
	this script will rotate the selected objects a random amount on the selected axis.	
*/

generic
{
    vMin = recall("vMin",0);
    vMax = recall("vMax",1.0);
    vH = recall("vH",false);
    vP = recall("vP",false);
    vB = recall("vB",false);

    reqbegin("cp_addRandomRotation");
	c0 = ctltext("","This will add random rotations","to the selected objects.","Make sure Autokey is on.");
    c1 = ctlnumber("Min",vMin);
    c2 = ctlnumber("Max",vMax);
    c3 = ctlcheckbox("Heading",vH);
    c4 = ctlcheckbox("Pitch",vP);
    c5 = ctlcheckbox("Bank",vB);
	c7 = ctlbutton("Toggle AutoKey",100,"tglAK");
	c8 = ctltext("","This will not update in viewport","until after the script is done.");

    return if !reqpost();

    vMin = getvalue(c1);
    vMax = getvalue(c2);
    vH = getvalue(c3);
    vP = getvalue(c4);
    vB = getvalue(c5);

	store("vMin",vMin);
	store("vMax",vMax);
	store("vH",vH);
	store("vP",vP);
	store("vB",vB);
	
    reqend();
	
	if(vMin >= vMax)
	{
		error("Minimum is not less than maximum, please correct your values.");
	}
	else
	{
		selection = Scene().getSelect();
		if(selection)
		{
			for(i=1; i<= size(selection); i++)
			{
				SelectItem(selection[i].id);
				rn = random(vMin,vMax);
				if(vH)
				{
					AddRotation(rn,0,0);
				}
				if(vP)
				{
					AddRotation(0,rn,0);
				}
				if(vB)
				{
					AddRotation(0,0,rn);
				}
			}
		}
	}
}

tglAK
{
	AutoKey();
}