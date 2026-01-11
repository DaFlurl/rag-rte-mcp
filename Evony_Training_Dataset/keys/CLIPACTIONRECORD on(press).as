on(press){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   this.always = !this.always;
   _parent.onChange(this._name,this.always);
}
