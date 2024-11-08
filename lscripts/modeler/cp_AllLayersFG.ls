@warnings
@version 2.2
@script modeler
@name cp_AllLayersFG

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    november 12 2011

    This script will select all layers that have data in them in Modeler.
*/

main
{
	FGLYRS = lyrdata();
	lyrsetfg(FGLYRS);
}