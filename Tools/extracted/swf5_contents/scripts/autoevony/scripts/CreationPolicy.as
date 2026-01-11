package autoevony.scripts
{
   import autoevony.common.BuildingType;
   import autoevony.common.ScriptError;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.constants.BuildingConstants;
   import mx.collections.ArrayCollection;
   
   public class CreationPolicy
   {
      public function CreationPolicy()
      {
         super();
      }
      
      internal static function getPositionByPolicy(param1:Array, param2:String, param3:String) : int
      {
         var _loc4_:int = BuildingType.fromString(param2);
         var _loc5_:Array = getAvailablePositionList(param1,BuildingType.isExteriorBuilding(_loc4_));
         if(_loc5_.length == 0)
         {
            return -1;
         }
         if(_loc4_ == BuildingConstants.TYPE_WALL)
         {
            if(Version.isTraceOn())
            {
               trace("CreationPolicy-select: Wall was provided, overrode to POSITION_WALL");
            }
            return BuildingConstants.POSITION_WALL;
         }
         if(param3.toLocaleLowerCase() == "firstavailable")
         {
            return _loc5_[0];
         }
         if(positionIsAvailable(parseInt(param3),param1,BuildingType.isExteriorBuilding(_loc4_)))
         {
            return parseInt(param3);
         }
         throw new ScriptError("Invalid creation policy!",-1);
      }
      
      private static function getAvailablePositionList(param1:Array, param2:Boolean) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:BuildingBean = null;
         var _loc7_:int = 0;
         var _loc5_:ArrayCollection = new ArrayCollection();
         if(param2)
         {
            _loc7_ = 0;
            for each(_loc4_ in param1)
            {
               if(_loc4_.typeId == BuildingConstants.TYPE_TOWN_HALL)
               {
                  _loc7_ = _loc4_.level;
               }
            }
            _loc3_ = BuildingConstants.BUILDING_OUTSIDE_MIN;
            while(_loc3_ < BuildingConstants.BUILDING_OUTSIDE_MIN + 10 + _loc7_ * 3)
            {
               _loc5_.addItem(_loc3_);
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = BuildingConstants.BUILDING_INSIDE_MIN;
            while(_loc3_ <= BuildingConstants.BUILDING_INSIDE_MAX)
            {
               _loc5_.addItem(_loc3_);
               _loc3_++;
            }
         }
         var _loc6_:int = 0;
         for each(_loc4_ in param1)
         {
            _loc6_ = int(_loc4_.positionId);
            if(_loc5_.contains(_loc6_))
            {
               _loc5_.removeItemAt(_loc5_.getItemIndex(_loc6_));
            }
         }
         return _loc5_.toArray();
      }
      
      private static function positionIsAvailable(param1:int, param2:Array, param3:Boolean) : Boolean
      {
         var _loc4_:Array = getAvailablePositionList(param2,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(param1 == _loc4_[_loc5_])
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
   }
}

