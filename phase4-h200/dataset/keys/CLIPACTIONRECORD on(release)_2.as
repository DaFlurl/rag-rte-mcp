on(release){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   _parent.checkIt = setInterval(_parent.download,200);
   _parent.gotoAndStop("DP_download");
}
