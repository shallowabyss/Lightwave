@warnings
@version 2.2
@name cp_LightsExcludeAllObjects

generic
{
  lgt = Scene().getSelect(LIGHT);
  SelectAllObjects();
  obj = Scene().getSelect(MESH);
  
  for(i=1; i<= size(lgt); i++)
  {
    SelectItem(lgt[i].id);
    for(j=1; j<= size(obj); j++)
    {
      ExcludeObject(obj[j].id);
    }
  }
}