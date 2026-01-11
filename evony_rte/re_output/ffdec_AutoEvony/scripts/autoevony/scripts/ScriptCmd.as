package autoevony.scripts
{
   import autoevony.common.Utils;
   import autoevony.player.Map;
   
   public class ScriptCmd
   {
      
      private static var TYPENAMES:Array = new Array("String","Boolean","Number","int","Coordinate","Resource","Fortification","Troop","*");
      
      public var func:Function;
      
      public var cmdName:String;
      
      private var params:Array;
      
      private var paramTypes:Array;
      
      private var nParamsRequired:int;
      
      public function ScriptCmd(param1:String, param2:Function, param3:Array, param4:Array, param5:int)
      {
         var _loc6_:String = null;
         super();
         this.func = param2;
         this.cmdName = param1;
         this.params = param3;
         this.paramTypes = param4;
         this.nParamsRequired = param5;
         if(param3.length != param4.length || param4.length < param5)
         {
            throw new Error("FATAL ERROR: Invalid param number in Script Prototype for " + param1);
         }
         for each(_loc6_ in param4)
         {
            if(TYPENAMES.indexOf(_loc6_) == -1)
            {
               throw new Error("FATAL ERROR: Invalid param type in Script Prototype for " + param1);
            }
         }
      }
      
      public static function getValue(param1:String, param2:String) : Object
      {
         if(param1 == "String")
         {
            return param2;
         }
         if(param1 == "Boolean")
         {
            return param2.toLowerCase() == "true";
         }
         if(param1 == "Coordinate")
         {
            return Map.coordStringToFieldId(param2);
         }
         if(param1 == "Number")
         {
            return Utils.removeAbbr(param2);
         }
         if(param1 == "int")
         {
            return int(Utils.removeAbbr(param2));
         }
         if(param1 == "Resource")
         {
            return param2.toLowerCase() == "none" ? null : Utils.getEstResoBean(param2);
         }
         if(param1 == "Fortification")
         {
            return param2.toLowerCase() == "none" ? null : Utils.getFortifications(param2);
         }
         if(param1 == "Troop")
         {
            return param2.toLowerCase() == "none" ? null : Utils.getTroops(param2);
         }
         throw new Error("FATAL ERROR: Unexpected call to getValue in Script Prototype");
      }
      
      public function hasInvalidArgs(param1:Array) : String
      {
         if(param1.length < this.nParamsRequired)
         {
            if(this.paramTypes.length == this.nParamsRequired)
            {
               return "Not enough params, " + this.nParamsRequired + " are required\nUsage: " + this.describeCmd();
            }
            return "Not enough params, at least " + this.nParamsRequired + " are required\nUsage: " + this.describeCmd();
         }
         if(param1.length > this.params.length && (this.paramTypes.length == 0 || this.paramTypes[this.paramTypes.length - 1] != "*"))
         {
            return "Too many params, usage: " + this.describeCmd();
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(this.paramTypes[_loc2_] == "*")
            {
               break;
            }
            if(!this.isValidType(this.paramTypes[_loc2_],param1[_loc2_]))
            {
               return "Invalid value " + param1[_loc2_] + " for param " + this.params[_loc2_] + "(type " + this.paramTypes[_loc2_] + ")\nUsage: " + this.describeCmd();
            }
            _loc2_++;
         }
         return null;
      }
      
      private function isValidType(param1:String, param2:String) : Boolean
      {
         if(param2.indexOf("%") != -1 || param2.indexOf("{") != -1 || param2.indexOf("$") != -1 || this.cmdName == "if" && param2.charAt(0) == "(" && param2.charAt(param2.length - 1) == ")")
         {
            return true;
         }
         if(param1 == "String")
         {
            return true;
         }
         if(param1 == "Boolean")
         {
            return param2.toLowerCase() == "true" || param2.toLowerCase() == "false";
         }
         if(param1 == "Number")
         {
            return Utils.hasValue(Utils.removeAbbr(param2) + "");
         }
         if(param1 == "int")
         {
            return Utils.hasValue(Utils.removeAbbr(param2) + "") && int(Utils.removeAbbr(param2)) == Utils.removeAbbr(param2);
         }
         if(param1 == "Coordinate")
         {
            return Map.coordStringToFieldId(param2) != -1;
         }
         if(param1 == "Resource")
         {
            return param2.toLowerCase() == "none" || Utils.getEstResoBean(param2) != null;
         }
         if(param1 == "Fortification")
         {
            return param2.toLowerCase() == "none" || Utils.getFortifications(param2) != null;
         }
         if(param1 == "Troop")
         {
            return param2.toLowerCase() == "none" || Utils.getTroops(param2) != null;
         }
         throw new Error("FATAL ERROR: Invalid Script Prototype for " + this.cmdName + ", invalid type: " + param1);
      }
      
      private function describeCmd() : String
      {
         var _loc1_:String = this.cmdName;
         var _loc2_:int = 0;
         while(_loc2_ < this.params.length)
         {
            _loc1_ += " " + (_loc2_ >= this.nParamsRequired ? "[" + this.params[_loc2_] + "]" : this.params[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getCmdInfo() : String
      {
         var _loc1_:String = this.describeCmd();
         var _loc2_:int = 0;
         while(_loc2_ < this.params.length)
         {
            _loc1_ += "\n  " + this.params[_loc2_] + " is of type " + this.paramTypes[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function paramsToArray(param1:Array) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(this.hasInvalidArgs(param1) != null)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(this.paramTypes[_loc3_] == "*")
            {
               break;
            }
            _loc2_.push(getValue(this.paramTypes[_loc3_],param1[_loc3_]));
            _loc3_++;
         }
         if(_loc3_ < this.paramTypes.length && this.paramTypes[_loc3_] == "*")
         {
            _loc4_ = new Array();
            _loc5_ = _loc3_;
            while(_loc5_ < param1.length)
            {
               _loc4_.push(param1[_loc5_]);
               _loc5_++;
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
   }
}

