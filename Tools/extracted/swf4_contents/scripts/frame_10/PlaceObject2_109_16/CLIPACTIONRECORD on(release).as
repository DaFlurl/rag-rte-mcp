on(release){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   if(_parent.securityRemember.always)
   {
      _parent.AlertResponse = "always_deny";
   }
   else
   {
      _parent.AlertResponse = "deny";
   }
}
