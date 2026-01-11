package autoevony.management
{
   import autoevony.common.BuildingType;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.beans.ConditionBean;
   import com.evony.common.module.castle.CheckOutBuildingResponse;
   
   public class BuildingManager
   {
      private static var instance:BuildingManager = new BuildingManager();
      
      private var upgradeConditionTimes:Array = new Array();
      
      private var upgradeConditions:Array = new Array();
      
      private var interestedUpgradeCond:CityCondition = null;
      
      private var lastUpgradeTime:Date = null;
      
      public function BuildingManager()
      {
         super();
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_CHECK_OUT_UPGRADE,this.onCheckOutUpgradeResponse);
      }
      
      private static function getKey(param1:int, param2:int) : int
      {
         return param1 * 1000 + param2;
      }
      
      public static function getInstance() : BuildingManager
      {
         return instance;
      }
      
      public function isLastUpgradeTimeLessThan5min() : Boolean
      {
         return this.lastUpgradeTime != null && new Date().getTime() - this.lastUpgradeTime.getTime() < 5 * 60 * 1000;
      }
      
      public function checkOutUpgrade(param1:int, param2:BuildingBean, param3:Function = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(this.isLastUpgradeTimeLessThan5min())
         {
            return;
         }
         this.lastUpgradeTime = new Date();
         this.interestedUpgradeCond = new CityCondition(true,param2.typeId,param2.level);
         if(Version.isTraceOn())
         {
            trace("Requesting requirement for upgrading " + BuildingType.toString(this.interestedUpgradeCond.typeId) + ":" + this.interestedUpgradeCond.level);
         }
         ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(param1,param2.positionId,param3);
      }
      
      public function getCachedUpgradeCondition(param1:int, param2:int) : ConditionBean
      {
         var _loc3_:int = getKey(param1,param2);
         if(this.upgradeConditions[_loc3_] == undefined || this.upgradeConditionTimes[_loc3_] == undefined)
         {
            return null;
         }
         if(new Date().getTime() - this.upgradeConditionTimes[_loc3_].getTime() > 3600 * 1000)
         {
            delete this.upgradeConditions[_loc3_];
            delete this.upgradeConditionTimes[_loc3_];
            return null;
         }
         return this.upgradeConditions[_loc3_];
      }
      
      private function onCheckOutUpgradeResponse(param1:CheckOutBuildingResponse) : void
      {
         this.lastUpgradeTime = null;
         if(this.interestedUpgradeCond == null)
         {
            return;
         }
         if(param1.ok != 1)
         {
            if(Version.isTraceOn())
            {
               trace("checkout upgrade error: " + param1.errorMsg);
            }
            return;
         }
         if(Version.isTraceOn())
         {
            trace("Obtain requirement for upgrading " + BuildingType.toString(this.interestedUpgradeCond.typeId) + ":" + this.interestedUpgradeCond.level);
         }
         if(this.upgradeConditions[getKey(this.interestedUpgradeCond.typeId,this.interestedUpgradeCond.level)] == undefined)
         {
            this.upgradeConditions[getKey(this.interestedUpgradeCond.typeId,this.interestedUpgradeCond.level)] = param1.conditionBean;
            this.upgradeConditionTimes[getKey(this.interestedUpgradeCond.typeId,this.interestedUpgradeCond.level)] = new Date();
         }
         else if(Version.isTraceOn())
         {
            trace("  requirement already obtained");
         }
         this.interestedUpgradeCond = null;
      }
   }
}

