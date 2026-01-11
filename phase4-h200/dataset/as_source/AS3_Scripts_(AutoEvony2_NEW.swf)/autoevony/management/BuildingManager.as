// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.management.BuildingManager

package autoevony.management
{
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.common.BuildingType;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.beans.ConditionBean;
    import com.evony.common.module.castle.CheckOutBuildingResponse;

    public class BuildingManager 
    {

        private static var instance:BuildingManager = new (BuildingManager)();

        private var interestedUpgradeCond:CityCondition = null;
        private var lastUpgradeTime:Date = null;

        private var upgradeConditions:Array = new Array();
        private var upgradeConditionTimes:Array = new Array();

        public function BuildingManager()
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_CHECK_OUT_UPGRADE, this.onCheckOutUpgradeResponse);
        }

        private static function getKey(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 * 1000) + _arg_2);
        }

        public static function getInstance():BuildingManager
        {
            return (instance);
        }


        public function isLastUpgradeTimeLessThan5min():Boolean
        {
            return ((!(this.lastUpgradeTime == null)) && ((new Date().getTime() - this.lastUpgradeTime.getTime()) < ((5 * 60) * 1000)));
        }

        public function checkOutUpgrade(_arg_1:int, _arg_2:BuildingBean, _arg_3:Function=null):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            if (this.isLastUpgradeTimeLessThan5min())
            {
                return;
            };
            this.lastUpgradeTime = new Date();
            this.interestedUpgradeCond = new CityCondition(true, _arg_2.typeId, _arg_2.level);
            if (Version.isTraceOn())
            {
                trace(((("Requesting requirement for upgrading " + BuildingType.toString(this.interestedUpgradeCond.typeId)) + ":") + this.interestedUpgradeCond.level));
            };
            ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(_arg_1, _arg_2.positionId, _arg_3);
        }

        public function getCachedUpgradeCondition(_arg_1:int, _arg_2:int):ConditionBean
        {
            var _local_3:int = getKey(_arg_1, _arg_2);
            if (((this.upgradeConditions[_local_3] == undefined) || (this.upgradeConditionTimes[_local_3] == undefined)))
            {
                return (null);
            };
            if ((new Date().getTime() - this.upgradeConditionTimes[_local_3].getTime()) > (3600 * 1000))
            {
                delete this.upgradeConditions[_local_3];
                delete this.upgradeConditionTimes[_local_3];
                return (null);
            };
            return (this.upgradeConditions[_local_3]);
        }

        private function onCheckOutUpgradeResponse(_arg_1:CheckOutBuildingResponse):void
        {
            this.lastUpgradeTime = null;
            if (this.interestedUpgradeCond == null)
            {
                return;
            };
            if (_arg_1.ok != 1)
            {
                if (Version.isTraceOn())
                {
                    trace(("checkout upgrade error: " + _arg_1.errorMsg));
                };
                return;
            };
            if (Version.isTraceOn())
            {
                trace(((("Obtain requirement for upgrading " + BuildingType.toString(this.interestedUpgradeCond.typeId)) + ":") + this.interestedUpgradeCond.level));
            };
            if (this.upgradeConditions[getKey(this.interestedUpgradeCond.typeId, this.interestedUpgradeCond.level)] == undefined)
            {
                this.upgradeConditions[getKey(this.interestedUpgradeCond.typeId, this.interestedUpgradeCond.level)] = _arg_1.conditionBean;
                this.upgradeConditionTimes[getKey(this.interestedUpgradeCond.typeId, this.interestedUpgradeCond.level)] = new Date();
            }
            else
            {
                if (Version.isTraceOn())
                {
                    trace("  requirement already obtained");
                };
            };
            this.interestedUpgradeCond = null;
        }


    }
}//package autoevony.management

