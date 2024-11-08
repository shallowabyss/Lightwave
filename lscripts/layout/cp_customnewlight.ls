@warnings
@version 2.3
@name cp_CustomNewLight

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 30 2007
    
    thanks to tom bremer for the idea

    This script will create a new light based on user input, and can be called
    later to create lights with the exact settings across multiple Lightwave sessions.
*/


generic{

    varLightName = recall("varLightName", "Light");
    varLightType = recall("varLightType", 2);
    varLightIntensity = recall("varLightIntensity", 1.0);
    varLightColor = recall("varLightColor", <255,255,255>);
    varVolumetric = recall("varVolumetric",0);
    varAOpenGL = recall("varAOpenGL",1);
    varADiffuse = recall("varADiffuse",1);
    varASpec = recall("varASpec", 1);


    reqbegin("cp_CustomNewLight");
    reqsize(286,320);

    c1 = ctlstring("Name",varLightName);
    ctlposition(c1,44,55,174,20);

    c2 = ctlchoice(" ",varLightType,@"Area","Spot","Point", "Distant"@);
    ctlposition(c2,35,79,184,19);

    c3 = ctlpercent("Intensity",varLightIntensity);
    ctlposition(c3,44,102,174,20);

    c4 = ctlcolor("Color",varLightColor);
    ctlposition(c4,54,128);

    c5 = ctltext("","Other Commands:");
    ctlposition(c5,44,152);

    c6 = ctlcheckbox("Volumetric",varVolumetric);
    ctlposition(c6,94,180,125,20);

    c7 = ctlcheckbox("Affect OpenGL",varAOpenGL);
    ctlposition(c7,94,205,125,20);

    c8 = ctlcheckbox("Affect Diffuse",varADiffuse);
    ctlposition(c8,94,230,125,20);

    c9 = ctlcheckbox("Affect Specular",varASpec);
    ctlposition(c9,94,255,125,20);

    c10 = ctltext("","    cp_CustomNewLight","       by Chris Peterson","chrisepeterson@gmail.com");
    ctlposition(c10,70,3,127,35);

    return if !reqpost();

    varLightName = getvalue(c1);
    varLightType = getvalue(c2);
    varLightIntensity = getvalue(c3);
    varLightColor = getvalue(c4);
    varVolumetric = getvalue(c6);
    varAOpenGL = getvalue(c7);
    varADiffuse = getvalue(c8);
    varASpec = getvalue(c9);

    store("varLightName", varLightName);
    store("varLightType", varLightType);
    store("varLightIntensity", varLightIntensity);
    store("varLightColor", varLightColor);
    store("varLightItemColor", varLightItemColor);
    store("varVolumetric", varVolumetric);
    store("varAOpenGL", varAOpenGL);
    store("varADiffuse", varADiffuse);
    store("varASpec", varASpec);
    reqend();
if(!LightName){
if(varLightType == 4)
	{
	   AddDistantLight(varLightName);
	   if(varVolumetric == true)
		{
		   info("Volumetric Lights can only be applied to Spotlights");
		}
	}
if(varLightType == 3)
	{
	   AddPointLight(varLightName);
	   if(varVolumetric == true)
		{
		   info("Volumetric Lights can only be applied to Spotlights");
		}
	}
if(varLightType == 2)
	{
	   AddSpotlight(varLightName);
	   if(varVolumetric == true)
		{
		   VolumetricLighting();
		}
	}
if(varLightType == 1)
	{
	   AddAreaLight(varLightName);
	   if(varVolumetric == true)
		{
		   info("Volumetric Lights can only be applied to Spotlights");
		}
	}


colormix = varLightColor/2.55/100;
varLight = ("LightColor " + colormix);
CommandInput(varLight);
LightIntensity(varLightIntensity);

if(varADiffuse == false)
	{
	   AffectDiffuse();
	}
if(varASpec == false)
	{
	   AffectSpecular();
	}
if(varAOpenGL == false)
	{
	   AffectOpenGL();
	}	
   }
}
