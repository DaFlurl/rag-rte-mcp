on(press){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   startDrag(this,0,left,top,right,bottom);
   pressed = true;
}
