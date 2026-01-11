on(release){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   _parent.allowStorageChange();
}
