on(press){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   this.safefullscreen = !this.safefullscreen;
   _parent.onChange(this._name,this.safefullscreen);
}
