@warnings
@version 2.2
@script generic
@name cp_MultipleLFS

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 10 2013

    This script will perform a LoadFromScene on the selected scene files.
*/

generic
{
	
	sceneFilesList = getmultifile("Select scene files to LFS from:","Lightwave Scene Files");
	if (sceneFilesList != nil)
	{
		verifiedSceneList;
		vslInc = 1;
		for(i=1; i <= size(sceneFilesList); i++)
		{
			if(sceneFilesList[i].contains(".lws"))
			{
				verifiedSceneList[vslInc] = sceneFilesList[i];
				vslInc++;
			}
		}
		if(verifiedSceneList != nil)
		{
			reqbegin("Status Report");
			reqsize(278,100);

			c1 = ctltext("",str(size(verifiedSceneList)) + " valid scenes were selected.","","Press OK to LFS or press CANCEL to stop.");
			ctlposition(c1,15,14,57,39);

			return if !reqpost();

			reqend();
			
			
			for(i=1; i <= size(verifiedSceneList); i++)
			{
				StatusMsg("{" + i/size(verifiedSceneList) + "} Loading " + verifiedSceneList[i]);
				LoadFromScene(verifiedSceneList[i]);
			}
			
			StatusMsg("MultipleLFS Complete.");

		}
		else
		{
			reqbegin("Status Report");
			reqsize(278,100);

			c1 = ctltext("","No valid scenes were selected.");
			ctlposition(c1,15,14,57,39);

			return if !reqpost();

			reqend();
		}
	}
}