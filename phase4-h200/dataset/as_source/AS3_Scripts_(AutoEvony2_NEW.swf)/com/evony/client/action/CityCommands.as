// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CityCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.city.StoreListResponse;

    public class CityCommands 
    {

        public var _advMoveCastle_callback:Function;
        public var _modifyCastleName_callback:Function;
        public var _WarMoveCastle_callback:Function;
        public var _modifyUserName_callback:Function;
        public var _modifyCastleIcon_callback:Function;
        public var _getStoreList_callback:Function;
        public var _modifyFlag_callback:Function;
        public var _giveupCastle_callback:Function;
        public var _moveCastle_callback:Function;
        public var _modifyStorePercent_callback:Function;
        public var _uniteAdvMoveCastle_callback:Function;
        public var _constructCastle_callback:Function;
        internal var sender:Sender;
        public var _setStopWarState_callback:Function;


        public function giveupCastle(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._giveupCastle_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.giveupCastle", {
                    "password":_arg_1,
                    "castleId":_arg_2
                });
            };
            return (null);
        }

        public function modifyStorePercent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._modifyStorePercent_callback = _arg_6;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.modifyStorePercent", {
                    "castleId":_arg_1,
                    "foodrate":_arg_2,
                    "woodrate":_arg_3,
                    "stonerate":_arg_4,
                    "ironrate":_arg_5
                });
            };
            return (null);
        }

        public function modifyFlag(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._modifyFlag_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.modifyFlag", {"newFlag":_arg_1});
            };
            return (null);
        }

        public function WarMoveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._WarMoveCastle_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.WarMoveCastle", {
                    "castleId":_arg_1,
                    "targetId":_arg_2
                });
            };
            return (null);
        }

        public function modifyUserName(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._modifyUserName_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.modifyUserName", {
                    "userName":_arg_1,
                    "itemId":_arg_2
                });
            };
            return (null);
        }

        public function uniteAdvMoveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._uniteAdvMoveCastle_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.uniteAdvMoveCastle", {
                    "castleId":_arg_1,
                    "targetId":_arg_2
                });
            };
            return (null);
        }

        public function getStoreList(_arg_1:int, _arg_2:Function=null):StoreListResponse
        {
            this._getStoreList_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.getStoreList", {"castleId":_arg_1});
            };
            return (null);
        }

        public function modifyCastleIcon(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._modifyCastleIcon_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.modifyCastleIcon", {
                    "castleId":_arg_1,
                    "icon":_arg_2
                });
            };
            return (null);
        }

        public function setStopWarState(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._setStopWarState_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.setStopWarState", {
                    "ItemId":_arg_1,
                    "passWord":_arg_2
                });
            };
            return (null);
        }

        public function constructCastle(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Function=null):CommandResponse
        {
            this._constructCastle_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.constructCastle", {
                    "castleId":_arg_1,
                    "fieldId":_arg_2,
                    "isTroopBack":_arg_3
                });
            };
            return (null);
        }

        public function moveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._moveCastle_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.moveCastle", {
                    "castleId":_arg_1,
                    "zoneId":_arg_2
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function advMoveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._advMoveCastle_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.advMoveCastle", {
                    "castleId":_arg_1,
                    "targetId":_arg_2
                });
            };
            return (null);
        }

        public function modifyCastleName(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._modifyCastleName_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("city.modifyCastleName", {
                    "castleId":_arg_1,
                    "name":_arg_2,
                    "logUrl":_arg_3
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

