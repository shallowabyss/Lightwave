@warnings
@version 2.6
@name cp_ReplaceTextures

generic
{
    i = 1;
    imagePath = globalrecall("imagePath", getdir(IMAGESDIR)+"\\");

    reqbegin("cp_ReplaceTextures");
    reqsize(430,104);

    c1 = ctlstring("New Path",imagePath);
    ctlposition(c1,12,11,385,19);

    return if !reqpost();

    imagePath = getvalue(c1);
    globalstore("imagePath", imagePath);

    reqend();


	img = Image();
        while(img)
        {
          images[i] = Image(i);
	  Image(i).replace(imagePath + images[i].name );
          i++;
          img = img.next();
        }

	AutoConfirm(1);
	SaveAllObjects();
}