@warnings
@version 2.2
@name cp_ModoCamConv

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    september 25 2009

    Converts LW's camera data into measurements that can be used in Modo.
    
    Equations used from: http://www.modonize.com/FAQs/110.aspx
*/

vMFocal = 0;
vHeight = 0;
vWidth = 0;
foundInfo = false;
aperHeight = 1;

generic
{
    filename = Scene().filename;
  	f = File(filename,"r") || error("Cannot open file: ",filename,"");
    if(f.linecount())
    {
        while(!f.eof() && foundInfo == false)
        {
           curLine = f.read();
		   if(curLine.contains("ApertureHeight"))
		   {
                token = parse(" ",curLine);
				aperHeight = token[2];
		   }
         }
	}
    camera = Camera();
    scene = Scene();
    frameNum = (scene.currenttime * scene.fps);
    zF = camera.zoomFactor(frameNum);
    fLen = camera.focalLength(frameNum);
    fwidth = scene.framewidth;
    fheight = scene.frameheight;
    pAspect = scene.pixelaspect;
    aperHeight = number(aperHeight) * 1000;
    
    /*
    Modo_Focal_Length = (Zoom_Factor * Aperture_Height) / 2
    Modo_Film_Height = LW_Aperture_Height (in mm)
    Modo_Film_Width = ((Frame_width * PixelAspect) / Frame_Height) * Aperture_height (in mm)
    */
    vMFocal = (aperHeight *zF) / 2;
    vHeight = aperHeight;
    vWidth = ((fwidth * pAspect) / fheight) * number(aperHeight);

    reqbegin("cp_ModoCameraConversion");
    c1 = ctlnumber("Focal Length",vMFocal);
    c2 = ctlnumber("Film Height",vHeight);
    c3 = ctlnumber("Film Width",vWidth);
    return if !reqpost();

    reqend();
}
