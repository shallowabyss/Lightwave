@warnings
@version 2.3
@name cp_CloneToLayers
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    september 16 2007
    
    This script will clone and offset
    a specific amount of times and put the
    clones onto new layers.
*/


main 
{
    varCopies = recall("varCopies",1);
    varXdist = recall("varXdist",1.0);
    varYdist = recall("varYdist",1.0);
    varZdist = recall("varZdist",1.0);
    makeparts = recall("makeparts",1);
 		varPrefix = recall("varPrefix","object");	

    reqbegin("cp_CloneToLayers");
    reqsize(209,244);

    c1 = ctlinteger("# Copies",varCopies);
    ctlposition(c1,31,58);

    c2 = ctldistance("X",varXdist);
    ctlposition(c2,65,83);

    c3 = ctldistance("Y",varYdist);
    ctlposition(c3,65,108);

    c4 = ctldistance("Z",varZdist);
    ctlposition(c4,65,133);

    c5 = ctlchoice("Create Parts",makeparts,@"Yes","No"@);
    ctlposition(c5,34,159,147,18);

    c6 = ctlstring("Prefix",varPrefix);
    ctlposition(c6,31,183);

    c7 = ctltext("","       cp_CloneToLayer","       by Chris Peterson","chrisepeterson@gmail.com");
    ctlposition(c7,45,5,127,39);

    return if !reqpost();

    varCopies = getvalue(c1);
    varXdist = getvalue(c2);
    varZdist = getvalue(c4);
    varYdist = getvalue(c3);
    makeparts = getvalue(c5);
    varPrefix = getvalue(c6);

		if(varCopies > 0) {
		 store("varCopies",varCopies);
		 } else {
		 	error("Copies must be more than 0.");
		 }
		 store("varXdist",varXdist);
		 store("varZdist",varZdist);
		 store("varYdist",varYdist);
		 store("makeparts",makeparts);
		 store("varPrefix",varPrefix);


    reqend();

  moninit(varCopies);
undogroupbegin();  
	for(i=1; i < varCopies; i++)
	{
		selmode(USER);
		copy();
		lyrmt = lyrempty();
		lyrsetfg(lyrmt[1]);
		paste();
		if(makeparts == 1){
			changepart (varPrefix + i);
		}
		move(varXdist,varYdist,varZdist);
		copy();
		monstep();
	}
undogroupend();
	monend();
}
