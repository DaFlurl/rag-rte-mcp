// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CastleCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.castle.AvailableBuilingListResponse;
    import com.evony.common.module.castle.CoinsNeedResponse;
    import com.evony.common.module.castle.CheckOutBuildingResponse;
    import com.evony.common.module.CommandResponse;

    public class CastleCommands 
    {

        public var _cancelBuildingQueue_callback:Function;
        public var _speedUpBuildCommand_callback:Function;
        public var _destructBuilding_callback:Function;
        public var _getAvailableBuildingListInside_callback:Function;
        public var _newBuilding_callback:Function;
        public var _upgradeBuilding_callback:Function;
        public var _cancleBuildCommand_callback:Function;
        public var _checkOutUpgrade_callback:Function;
        internal var sender:Sender;
        public var _getAvailableBuildingListOutside_callback:Function;
        public var _newBuildingQueue_callback:Function;
        public var _speedupBuildingQueue_callback:Function;
        public var _getAvailableBuildingBean_callback:Function;
        public var _getDestructBuildBean_callback:Function;
        public var _UpdateCastleResources_callback:Function;
        public var _getCoinsNeed_callback:Function;
        public var _getBuildingQueueCoinsNeed_callback:Function;
        public var _demolishBuildingQueue_callback:Function;


        public function getAvailableBuildingListInside(_arg_1:int, _arg_2:Function=null):AvailableBuilingListResponse
        {
            this._getAvailableBuildingListInside_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.getAvailableBuildingListInside", {"castleId":_arg_1});
            };
            return (null);
        }

        public function getCoinsNeed(_arg_1:int, _arg_2:int, _arg_3:Function=null):CoinsNeedResponse
        {
            this._getCoinsNeed_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.getCoinsNeed", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function getDestructBuildBean(_arg_1:int, _arg_2:int, _arg_3:Function=null):AvailableBuilingListResponse
        {
            this._getDestructBuildBean_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.getDestructBuildBean", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function checkOutUpgrade(_arg_1:int, _arg_2:int, _arg_3:Function=null):CheckOutBuildingResponse
        {
            this._checkOutUpgrade_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.checkOutUpgrade", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function speedupBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedupBuildingQueue_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.speedupBuildingQueue", {
                    "castleId":_arg_1,
                    "queueId":_arg_2,
                    "itemId":_arg_3
                });
            };
            return (null);
        }

        public function getAvailableBuildingListOutside(_arg_1:int, _arg_2:Function=null):AvailableBuilingListResponse
        {
            this._getAvailableBuildingListOutside_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.getAvailableBuildingListOutside", {"castleId":_arg_1});
            };
            return (null);
        }

        public function demolishBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._demolishBuildingQueue_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.demolishBuildingQueue", {
                    "castleId":_arg_1,
                    "type":_arg_2,
                    "level":_arg_3,
                    "positionId":_arg_4
                });
            };
            return (null);
        }

        public function getAvailableBuildingBean(_arg_1:int, _arg_2:int, _arg_3:Function=null):AvailableBuilingListResponse
        {
            this._getAvailableBuildingBean_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.getAvailableBuildingBean", {
                    "castleId":_arg_1,
                    "typeId":_arg_2
                });
            };
            return (null);
        }

        public function cancelBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancelBuildingQueue_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.cancelBuildingQueue", {
                    "castleId":_arg_1,
                    "queueId":_arg_2
                });
            };
            return (null);
        }

        public function speedUpBuildCommand(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedUpBuildCommand_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.speedUpBuildCommand", {
                    "castleId":_arg_1,
                    "positionId":_arg_2,
                    "itemId":_arg_3
                });
            };
            return (null);
        }

        public function cancleBuildCommand(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancleBuildCommand_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.cancleBuildCommand", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function UpdateCastleResources(_arg_1:int, _arg_2:Function=null):AvailableBuilingListResponse
        {
            this._UpdateCastleResources_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.UpdateCastleResources", {"castleId":_arg_1});
            };
            return (null);
        }

        public function upgradeBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._upgradeBuilding_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.upgradeBuilding", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function newBuilding(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._newBuilding_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.newBuilding", {
                    "castleId":_arg_1,
                    "positionId":_arg_2,
                    "buildingType":_arg_3
                });
            };
            return (null);
        }

        public function getBuildingQueueCoinsNeed(_arg_1:int, _arg_2:int, _arg_3:Function=null):CoinsNeedResponse
        {
            this._getBuildingQueueCoinsNeed_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.getBuildingQueueCoinsNeed", {
                    "castleId":_arg_1,
                    "queueId":_arg_2
                });
            };
            return (null);
        }

        public function destructBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._destructBuilding_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.destructBuilding", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function newBuildingQueue(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._newBuildingQueue_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("castle.newBuildingQueue", {
                    "castleId":_arg_1,
                    "type":_arg_2,
                    "level":_arg_3,
                    "positionId":_arg_4
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

