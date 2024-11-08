@warnings
@version 2.2
@name cp_motSaver

/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    october 28 2009

    This script allow you to quickly save motions to the C:\windows\temp
    directory.
*/

generic
{
    sceneName = Scene().name;
    d = date();
    t = time();
    y = string(d[3]);
    mo = string(d[2]);
    if(d[2] < 10)
    {
       mo = "0" + string(d[2]);
    }
    dy = string(d[1]);
    if(d[1] < 10)
    {
       dy = "0" + string(d[1]);
    }
    h = string(t[1]);
    if(t[1] < 10)
    {
       h = "0" + string(t[1]);
    }
    mi = string(t[2]);
    if(t[2] < 10)
    {
       mi = "0" + string(t[2]);
    }
    s = string(t[3]);
    if(t[3] < 10)
    {
       s = "0" + string(t[3]);
    }
    dateTime = y + "-" + mo + "-" + dy + "_" + h + "-" + mi + "-" + s;
    selectItems = Scene().getSelect();
    itemName = selectItems[1].name;
    gen =  selectItems[1].genus;
    itemType;
    if(gen == 1) { itemType = "O"; }
    if(gen == 2) { itemType = "L"; }
    if(gen == 3) { itemType = "C"; }
    if(gen == 4) { itemType = "B"; }
    mkdir("C:\\TEMP");
    path = "C:\\TEMP\\";
    savepath = path + sceneName + "_" + dateTime + "_" + itemType + "_" + itemName + ".mot";
    SaveMotion(savepath);
    StatusMsg("Motion saved to: " + savepath);
}

