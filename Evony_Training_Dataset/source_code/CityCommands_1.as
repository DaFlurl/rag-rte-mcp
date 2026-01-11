// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CityCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.city.StoreListResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class CityCommands 
    {

        public var _advMoveCastle_callback:Function;
        public var _modifyCastleName_callback:Function;
        public var _WarMoveCastle_callback:Function;
        public var _modifyUserName_callback:Function;
        public var _modifyCastleIcon_callback:Function;
        public var _moveCastle_callback:Function;
        public var _modifyFlag_callback:Function;
        public var _giveupCastle_callback:Function;
        public var _getStoreList_callback:Function;
        public var _modifyStorePercent_callback:Function;
        public var _constructCastle_callback:Function;
        private var sender:Sender;
        public var _setStopWarState_callback:Function;
        public var _uniteAdvMoveCastle_callback:Function;


        public function giveupCastle(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._giveupCastle_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.password = _arg_1;
            _local_4.castleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.giveupCastle", _local_4);
            };
            return (null);
        }

        public function modifyStorePercent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._modifyStorePercent_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.foodrate = _arg_2;
            _local_7.woodrate = _arg_3;
            _local_7.stonerate = _arg_4;
            _local_7.ironrate = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyStorePercent", _local_7);
            };
            return (null);
        }

        public function modifyFlag(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._modifyFlag_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.newFlag = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyFlag", _local_3);
            };
            return (null);
        }

        public function WarMoveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._WarMoveCastle_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.WarMoveCastle", _local_4);
            };
            return (null);
        }

        public function modifyUserName(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._modifyUserName_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.userName = _arg_1;
            _local_4.itemId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyUserName", _local_4);
            };
            return (null);
        }

        public function uniteAdvMoveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._uniteAdvMoveCastle_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.uniteAdvMoveCastle", _local_4);
            };
            return (null);
        }

        public function getStoreList(_arg_1:int, _arg_2:Function=null):StoreListResponse
        {
            this._getStoreList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("city.getStoreList", _local_3);
            };
            return (null);
        }

        public function modifyCastleIcon(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._modifyCastleIcon_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.icon = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyCastleIcon", _local_4);
            };
            return (null);
        }

        public function setStopWarState(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._setStopWarState_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.ItemId = _arg_1;
            _local_4.passWord = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.setStopWarState", _local_4);
            };
            return (null);
        }

        public function constructCastle(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Function=null):CommandResponse
        {
            this._constructCastle_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.fieldId = _arg_2;
            _local_5.isTroopBack = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("city.constructCastle", _local_5);
            };
            return (null);
        }

        public function moveCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._moveCastle_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.zoneId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.moveCastle", _local_4);
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
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("city.advMoveCastle", _local_4);
            };
            return (null);
        }

        public function modifyCastleName(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._modifyCastleName_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.name = _arg_2;
            _local_5.logUrl = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyCastleName", _local_5);
            };
            return (null);
        }


    }
}//package com.evony.client.action

