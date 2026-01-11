on(press){
   var v = _root.CheckVisibility(210,130);
   if(v === false)
   {
      return undefined;
   }
   this.echosuppression = !this.echosuppression;
   _parent.onChange(this._name,this.echosuppression);
}
