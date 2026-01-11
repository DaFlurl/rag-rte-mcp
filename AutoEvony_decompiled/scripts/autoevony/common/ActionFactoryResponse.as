package autoevony.common
{
   public dynamic class ActionFactoryResponse
   {
      
      public function ActionFactoryResponse(param1:XML = null)
      {
         var _loc2_:* = undefined;
         var _loc9_:* = undefined;
         super();
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1.attributes())
         {
            this["@" + _loc2_.name()] = _loc2_.toString();
         }
         if(param1.hasSimpleContent())
         {
            this["data"] = param1.toString();
            return;
         }
         var _loc3_:* = param1.children();
         var _loc4_:Object = new Object();
         var _loc5_:String = null;
         var _loc6_:* = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         for each(_loc9_ in _loc3_)
         {
            _loc5_ = _loc9_.name().toString();
            if(_loc4_[_loc5_] == undefined)
            {
               _loc4_[_loc5_] = _loc5_;
               _loc6_ = param1.child(_loc5_);
               if(_loc6_.length() == 1)
               {
                  this[_loc5_] = new ActionFactoryResponse(XML(_loc6_));
               }
               else
               {
                  _loc7_ = new Array();
                  this[_loc5_] = _loc7_;
                  _loc8_ = 0;
                  for each(_loc9_ in _loc6_)
                  {
                     var _loc14_:*;
                     _loc7_[_loc14_ = _loc8_++] = new ActionFactoryResponse(_loc9_);
                  }
               }
            }
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:* = "";
         for(_loc3_ in this)
         {
            if(_loc2_ != "")
            {
               _loc2_ += "\n";
            }
            if(this[_loc3_] is Array)
            {
               _loc4_ = 0;
               while(_loc4_ < this[_loc3_].length)
               {
                  if(_loc4_ != 0)
                  {
                     _loc2_ += "\n";
                  }
                  _loc2_ += this[_loc3_][_loc4_].toDebugString(param1 + "." + _loc3_ + "[" + _loc4_ + "]");
                  _loc4_++;
               }
            }
            else if(this[_loc3_] is ActionFactoryResponse)
            {
               _loc2_ += this[_loc3_].toDebugString(param1 + "." + _loc3_);
            }
            else
            {
               _loc2_ += param1 + "." + _loc3_ + " = " + this[_loc3_];
            }
         }
         return _loc2_;
      }
   }
}

