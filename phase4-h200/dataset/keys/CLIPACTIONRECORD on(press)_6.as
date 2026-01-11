on(press){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   this.gotoAndStop(3);
   _parent.Allow.gotoAndStop(1);
   _parent.domainSettings.data.allow = false;
   _parent.AlertResponse = "allow";
}
