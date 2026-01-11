package autoevony.common
{
   public class GearType
   {
      
      private static var gearAbrNames:Array = new Array("","we","shi","mo","ne","cha","ri","he","sho","che","ba","ga","be","le","fo");
      
      private static var gearExtNames:Array = new Array("","weapon","shield","mount","necklace","charm","ring","head","shoulder","chest","back","gauntlets","belts","legs","foot");
      
      public function GearType()
      {
         super();
      }
      
      public static function toAbbrString(param1:int) : String
      {
         return gearAbrNames[param1];
      }
      
      public static function toNameString(param1:int) : String
      {
         return gearExtNames[param1];
      }
      
      public static function fromString(param1:String) : int
      {
         var _loc2_:int = 0;
         param1 = param1.toLowerCase();
         _loc2_ = int(gearExtNames.indexOf(param1));
         if(_loc2_ == -1)
         {
            _loc2_ = int(gearAbrNames.indexOf(param1));
         }
         return _loc2_;
      }
   }
}

