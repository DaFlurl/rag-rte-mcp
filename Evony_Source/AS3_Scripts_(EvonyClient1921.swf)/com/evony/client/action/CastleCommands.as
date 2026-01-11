// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CastleCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.castle.AvailableBuilingListResponse;
    import com.evony.common.module.castle.CoinsNeedResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.castle.CheckOutBuildingResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class CastleCommands 
    {

        public var _cancelBuildingQueue_callback:Function;
        public var _getAvailableBuildingListInside_callback:Function;
        public var _destructBuilding_callback:Function;
        public var _speedUpBuildCommand_callback:Function;
        public var _newBuilding_callback:Function;
        public var _upgradeBuilding_callback:Function;
        public var _cancleBuildCommand_callback:Function;
        public var _checkOutUpgrade_callback:Function;
        private var sender:Sender;
        public var _getAvailableBuildingListOutside_callback:Function;
        public var _speedupBuildingQueue_callback:Function;
        public var _getAvailableBuildingBean_callback:Function;
        public var _newBuildingQueue_callback:Function;
        public var _getDestructBuildBean_callback:Function;
        public var _UpdateCastleResources_callback:Function;
        public var _getCoinsNeed_callback:Function;
        public var _getBuildingQueueCoinsNeed_callback:Function;
        public var _demolishBuildingQueue_callback:Function;


        public function getAvailableBuildingListInside(_arg_1:int, _arg_2:Function=null):AvailableBuilingListResponse
        {
            this._getAvailableBuildingListInside_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getAvailableBuildingListInside", _local_3);
            };
            return (null);
        }

        public function getCoinsNeed(_arg_1:int, _arg_2:int, _arg_3:Function=null):CoinsNeedResponse
        {
            this._getCoinsNeed_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getCoinsNeed", _local_4);
            };
            return (null);
        }

        public function destructBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._destructBuilding_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.destructBuilding", _local_4);
            };
            return (null);
        }

        public function getDestructBuildBean(_arg_1:int, _arg_2:int, _arg_3:Function=null):AvailableBuilingListResponse
        {
            this._getDestructBuildBean_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getDestructBuildBean", _local_4);
            };
            return (null);
        }

        public function checkOutUpgrade(_arg_1:int, _arg_2:int, _arg_3:Function=null):CheckOutBuildingResponse
        {
            this._checkOutUpgrade_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.checkOutUpgrade", _local_4);
            };
            return (null);
        }

        public function getAvailableBuildingBean(_arg_1:int, _arg_2:int, _arg_3:Function=null):AvailableBuilingListResponse
        {
            this._getAvailableBuildingBean_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.typeId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getAvailableBuildingBean", _local_4);
            };
            return (null);
        }

        public function speedupBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedupBuildingQueue_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.queueId = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.speedupBuildingQueue", _local_5);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function getAvailableBuildingListOutside(_arg_1:int, _arg_2:Function=null):AvailableBuilingListResponse
        {
            this._getAvailableBuildingListOutside_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getAvailableBuildingListOutside", _local_3);
            };
            return (null);
        }

        public function demolishBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._demolishBuildingQueue_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.castleId = _arg_1;
            _local_6.type = _arg_2;
            _local_6.level = _arg_3;
            _local_6.positionId = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("castle.demolishBuildingQueue", _local_6);
            };
            return (null);
        }

        public function cancelBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancelBuildingQueue_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.queueId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.cancelBuildingQueue", _local_4);
            };
            return (null);
        }

        public function speedUpBuildCommand(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedUpBuildCommand_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.positionId = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.speedUpBuildCommand", _local_5);
            };
            return (null);
        }

        public function cancleBuildCommand(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancleBuildCommand_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.cancleBuildCommand", _local_4);
            };
            return (null);
        }

        public function UpdateCastleResources(_arg_1:int, _arg_2:Function=null):AvailableBuilingListResponse
        {
            this._UpdateCastleResources_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.UpdateCastleResources", _local_3);
            };
            return (null);
        }

        public function upgradeBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._upgradeBuilding_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.upgradeBuilding", _local_4);
            };
            return (null);
        }

        public function getBuildingQueueCoinsNeed(_arg_1:int, _arg_2:int, _arg_3:Function=null):CoinsNeedResponse
        {
            this._getBuildingQueueCoinsNeed_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.queueId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getBuildingQueueCoinsNeed", _local_4);
            };
            return (null);
        }

        public function newBuilding(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._newBuilding_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.positionId = _arg_2;
            _local_5.buildingType = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.newBuilding", _local_5);
            };
            return (null);
        }

        public function newBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._newBuildingQueue_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.castleId = _arg_1;
            _local_6.type = _arg_2;
            _local_6.level = _arg_3;
            _local_6.positionId = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("castle.newBuildingQueue", _local_6);
            };
            return (null);
        }


    }
}//package com.evony.client.action

