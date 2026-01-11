function VersionStrToArray(v)
{
   var _loc2_ = v.split(",");
   var _loc3_ = _loc2_.length;
   var _loc1_ = undefined;
   if(_loc3_ != 4)
   {
      return undefined;
   }
   _loc1_ = 0;
   while(_loc1_ < _loc3_)
   {
      _loc2_[_loc1_] = Number(_loc2_[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   return _loc2_;
}
function ClientVersion()
{
   var _loc1_ = System.capabilities.version;
   _loc1_ = _loc1_.substring(_loc1_.indexOf(" ") + 1,_loc1_.length);
   return VersionStrToArray(_loc1_);
}
function ServerVersion(rootNode)
{
   var _loc1_ = rootNode.firstChild;
   _loc1_ = _loc1_.firstChild;
   while(_loc1_)
   {
      if(_loc1_.nodeName == "update")
      {
         return VersionStrToArray(_loc1_.attributes.version);
      }
      _loc1_ = _loc1_.nextSibling;
   }
   return undefined;
}
function handleOnLoad(okay)
{
   if(okay)
   {
      var _loc2_ = ClientVersion();
      var _loc3_ = ServerVersion(this);
      var _loc4_ = _loc2_.length;
      if(_loc4_ != 4 || _loc4_ != _loc3_.length)
      {
         ASnative(2202,999)();
         return undefined;
      }
      var _loc5_ = false;
      i = 0;
      while(i < _loc4_)
      {
         if(_loc3_[i] > _loc2_[i])
         {
            _loc5_ = true;
            break;
         }
         if(_loc3_[i] < _loc2_[i])
         {
            break;
         }
         i++;
      }
      ASnative(2202,0)(_loc5_,this.toString());
   }
   else
   {
      ASnative(2202,998)();
   }
}
this.data = new Object();
this.GetSO = function(scope, domain)
{
   var _loc2_ = "settings";
   if(domain != null)
   {
      _loc2_ = domain + "/" + _loc2_;
   }
   if(this.data[_loc2_] == null)
   {
      this.data[_loc2_] = SharedObject.getLocal(_loc2_,scope);
   }
   return this.data[_loc2_];
};
this.LogDomain = function(scope, domain)
{
   if(domain != null)
   {
      var _loc1_ = GetSO(scope,null);
      if(_loc1_.data.domains == null)
      {
         _loc1_.data.domains = new Object();
      }
      if(_loc1_.data.domains[domain] == null)
      {
         _loc1_.data.domains[domain] = true;
         _loc1_.flush();
      }
   }
};
this.GetSetting = function(scope, domain, name)
{
   var _loc1_ = GetSO(scope,domain);
   return _loc1_.data[name];
};
this.SetSetting = function(scope, domain, name, value, override)
{
   var _loc1_ = GetSO(scope,domain);
   if(override || _loc1_.data[name] == null)
   {
      _loc1_.data[name] = value;
      _loc1_.flush();
   }
   LogDomain(scope,domain);
};
this.Commit = function(scope, domain)
{
   var _loc1_ = GetSO(scope,null);
   _loc1_.flush();
   var _loc2_ = GetSO(scope,domain);
   _loc2_.flush();
};
this.GetServerVersion = function(theUrl)
{
   var _loc1_ = new XML();
   _loc1_.ignoreWhite = true;
   _loc1_.onLoad = handleOnLoad;
   _loc1_.load(theUrl);
};
