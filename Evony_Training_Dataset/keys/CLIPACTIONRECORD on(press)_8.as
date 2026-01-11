on(press){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   if(this.active)
   {
      this.gotoAndStop(2);
      startDrag(this,0,left,top,right,bottom);
      pressed = true;
   }
}
