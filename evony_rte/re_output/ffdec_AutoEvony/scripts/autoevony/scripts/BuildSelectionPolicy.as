package autoevony.scripts
{
   import autoevony.common.BuildingType;
   import autoevony.common.ScriptError;
   import com.evony.common.beans.BuildingBean;
   
   public class BuildSelectionPolicy
   {
      
      public function BuildSelectionPolicy()
      {
         super();
      }
      
      public static function findByPolicy(param1:Array, param2:String, param3:String, param4:int = 9) : BuildingBean
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:BuildingBean = null;
         var _loc6_:BuildingBean = null;
         var _loc7_:String = null;
         var _loc8_:* = "";
         var _loc9_:String = param3.substr(0,2).toLowerCase();
         if(_loc9_ == "hi")
         {
            _loc10_ = -1;
            for(_loc7_ in param1)
            {
               _loc5_ = param1[_loc7_];
               if(_loc5_.status == 0)
               {
                  if((param2 == "*" || _loc5_.typeId == BuildingType.fromString(param2)) && _loc5_.level > _loc10_ && _loc5_.level <= param4)
                  {
                     _loc6_ = _loc5_;
                     _loc10_ = _loc5_.level;
                  }
               }
            }
            _loc8_ = " level " + param4 + " or lower.";
         }
         else if(_loc9_ == "lo")
         {
            _loc11_ = 100;
            for(_loc7_ in param1)
            {
               _loc5_ = param1[_loc7_];
               if(_loc5_.status == 0)
               {
                  if((param2 == "*" || _loc5_.typeId == BuildingType.fromString(param2)) && _loc5_.level < _loc11_ && _loc5_.level < param4)
                  {
                     _loc6_ = _loc5_;
                     _loc11_ = _loc5_.level;
                  }
               }
            }
            _loc8_ = " lower than level " + param4;
         }
         else
         {
            if(_loc9_ != "le")
            {
               throw new ScriptError(param3 + " is an invalid Build policy.",-9999);
            }
            _loc12_ = parseInt(param3.substr(5,2));
            for(_loc7_ in param1)
            {
               _loc5_ = param1[_loc7_];
               if(_loc5_.status == 0)
               {
                  if((param2 == "*" || _loc5_.typeId == BuildingType.fromString(param2)) && _loc5_.level == _loc12_)
                  {
                     _loc6_ = _loc5_;
                     break;
                  }
               }
            }
            _loc8_ = " equal to level " + _loc12_;
         }
         if(_loc6_ == null)
         {
            throw new ScriptError("Unable to select a " + BuildingType.toString(BuildingType.fromString(param2)) + _loc8_,-9999);
         }
         return _loc6_;
      }
   }
}

