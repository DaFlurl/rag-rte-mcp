function setText(w)
{
   localinformationSetting.text = _root.ls.storageLevels[w].label;
}
function pressSnap(n)
{
   var _loc2_ = _root.CheckVisibility(210,130);
   if(_loc2_ === false)
   {
      return undefined;
   }
   if(slider.active == true)
   {
      slider._x = slider.markList[n] + crib._x;
      localinformationSetting.text = ls.storageLevels[n].label;
      _root.changeKlimit(ls.storageLevels[n].value);
   }
}
frame_localInformation();
killHand();
