@warnings
@version 2.2
@name cp_VisbilityNone

generic
{
  obj = Scene().getSelect(MESH);
  for(i=1; i<= size(obj); i++)
  {
    SelectItem(obj[i].id);
    CommandInput("ItemVisibility 0");
  }
  SelectItem(obj[1].id);
  for(i=2; i<= size(obj); i++)
  {
    AddToSelection(obj[i].id);
  }
}