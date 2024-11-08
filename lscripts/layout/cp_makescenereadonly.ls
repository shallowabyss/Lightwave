@warnings
@version 2.2
@name cp_makeSceneReadOnly
/*
    by chris peterson
    chrisepeterson@gmail.com
    http://www.chrisepeterson.com
    august 3 2009

    This script will make the current scene file readonly.
*/

generic
{
 scn = Scene().filename;
 systemex("attrib +r " + scn);
 StatusMsg(scn + " has been set to read only.")
}