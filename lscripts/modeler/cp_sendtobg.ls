@warnings
@version 2.6
@name cp_SendToBG

/*
    cp_SendToBG
    by Chris Peterson

    This script will take the selected geometry, cut it, and paste in the next available
    empty layer. Then it will switch back to the first layer you had selected and put the
    cut geometry's layer into the background. Essentially "sending" the selected geometry
    to the background.
    
    Last updated: October 4, 2008
*/

main {
undogroupbegin();
	selmode(USER);
	fg = lyrfg();
	cut();        
	targetLyrData = lyrdata();
        targetTotalVal = sizeof(targetLyrData);
        targetLyrData.sortA();
        targetLstIdx = targetLyrData[targetTotalVal];
        nextEmpty = targetLstIdx + 1;
        if(lyrempty() == nil)
        {
	lyrsetfg(nextEmpty);
        }
        else
        {
        emptyLayers = lyrempty();
        info(emptyLayers);
        emptyLayers.sortA();
	lyrsetfg(emptyLayers[1]);
        }
        bg = lyrfg();
	paste();
	lyrsetfg(fg);
	lyrsetbg(bg);
	undogroupend();
}
