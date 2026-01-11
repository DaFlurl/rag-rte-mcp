// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CommonCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.common.CreatePlayerResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.PlayerInfoResponse;
    import com.evony.common.module.common.GetCanDeclaredWarAgainstPlayerRespone;
    import com.evony.common.module.common.ChatResponse;
    import com.evony.common.module.common.GetPackageResponse;
    import com.evony.common.module.common.MapInfoResponse;
    import com.evony.common.module.common.ChangeNameResponse;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.module.common.TroopConfigResponse;
    import com.evony.common.module.common.MapCastleResponse;
    import com.evony.common.module.common.MapInfoSimpleResponse;
    import com.evony.common.module.common.GetPackageNumberResponse;
    import com.evony.common.module.common.ZoneInfoResponse;
    import com.evony.common.module.common.ChangeUserFaceResponse;
    import com.evony.common.module.common.GetRelationshipRespone;
    import com.evony.common.module.common.GetItemDefResponse;
    import com.evony.common.module.common.GetDeclaredWarResponse;
    import com.evony.common.module.common.GetPackageListResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class CommonCommands 
    {

        public var _setEvonyMemberEMail_callback:Function;
        public var _addToFavorites_callback:Function;
        public var _getRelationship_callback:Function;
        public var _getCanDeclaredWarAgainstPlayer_callback:Function;
        public var _mapInfo_callback:Function;
        public var _setTroopConfig_callback:Function;
        private var sender:Sender;
        public var _facebookConnect_callback:Function;
        public var _changeHeadline_callback:Function;
        public var _getPlayerDeclaredWarStatus_callback:Function;
        public var _mapCastle_callback:Function;
        public var _declaredWarAgainstPlayer_callback:Function;
        public var _allianceChat_callback:Function;
        public var _getPackageList_callback:Function;
        public var _step_callback:Function;
        public var _getPlayerInfoByName_callback:Function;
        public var _privateChat_callback:Function;
        public var _getItemDefXml_callback:Function;
        public var _setReceiveIncomingAttack_callback:Function;
        public var _deleteUserAndRestart_callback:Function;
        public var _worldChat_callback:Function;
        public var _saveUnregisteredPlayer_callback:Function;
        public var _createNewPlayer_callback:Function;
        public var _setEovnyMember_callback:Function;
        public var _setReturnReport_callback:Function;
        public var _mapInfoSimple_callback:Function;
        public var _getPackageNumber_callback:Function;
        public var _changeUserFace_callback:Function;
        public var _getPackage_callback:Function;
        public var _delUniteServerPeaceStatus_callback:Function;
        public var _denyPlayerSpeak_callback:Function;
        public var _channelChat_callback:Function;
        public var _changeName_callback:Function;
        public var _zoneInfo_callback:Function;
        public var _setAutoHeal_callback:Function;
        public var _setEventDone_callback:Function;


        public function createNewPlayer(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:String, _arg_8:Function=null):CreatePlayerResponse
        {
            this._createNewPlayer_callback = _arg_8;
            var _local_9:Object = new Object();
            _local_9.userName = _arg_1;
            _local_9.sex = _arg_2;
            _local_9.faceUrl = _arg_3;
            _local_9.flag = _arg_4;
            _local_9.castleName = _arg_5;
            _local_9.zone = _arg_6;
            _local_9.accountName = _arg_7;
            if (this.sender != null)
            {
                sender.sendMessage("common.createNewPlayer", _local_9);
            };
            return (null);
        }

        public function setReturnReport(_arg_1:Boolean, _arg_2:Function=null):CommandResponse
        {
            this._setReturnReport_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.returnReport = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.setReturnReport", _local_3);
            };
            return (null);
        }

        public function getPlayerInfoByName(_arg_1:String, _arg_2:Function=null):PlayerInfoResponse
        {
            this._getPlayerInfoByName_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.getPlayerInfoByName", _local_3);
            };
            return (null);
        }

        public function getCanDeclaredWarAgainstPlayer(_arg_1:int, _arg_2:Function=null):GetCanDeclaredWarAgainstPlayerRespone
        {
            this._getCanDeclaredWarAgainstPlayer_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.playerId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.getCanDeclaredWarAgainstPlayer", _local_3);
            };
            return (null);
        }

        public function worldChat(_arg_1:String, _arg_2:int, _arg_3:Function=null):ChatResponse
        {
            this._worldChat_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.msg = _arg_1;
            _local_4.languageType = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.worldChat", _local_4);
            };
            return (null);
        }

        public function getPackage(_arg_1:int, _arg_2:String, _arg_3:Function=null):GetPackageResponse
        {
            this._getPackage_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.ruleId = _arg_1;
            _local_4.serial = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.getPackage", _local_4);
            };
            return (null);
        }

        public function mapInfo(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):MapInfoResponse
        {
            this._mapInfo_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.x1 = _arg_2;
            _local_7.y1 = _arg_3;
            _local_7.x2 = _arg_4;
            _local_7.y2 = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("common.mapInfo", _local_7);
            };
            return (null);
        }

        public function allianceChat(_arg_1:String, _arg_2:int, _arg_3:Function=null):ChatResponse
        {
            this._allianceChat_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.msg = _arg_1;
            _local_4.languageType = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.allianceChat", _local_4);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function facebookConnect(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._facebookConnect_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.facebookId = _arg_1;
            _local_5.password = _arg_2;
            _local_5.fbsig = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("common.facebookConnect", _local_5);
            };
            return (null);
        }

        public function delUniteServerPeaceStatus(_arg_1:Function=null):CommandResponse
        {
            this._delUniteServerPeaceStatus_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.delUniteServerPeaceStatus", _local_2);
            };
            return (null);
        }

        public function declaredWarAgainstPlayer(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._declaredWarAgainstPlayer_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.playerId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.declaredWarAgainstPlayer", _local_3);
            };
            return (null);
        }

        public function changeName(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Function=null):ChangeNameResponse
        {
            this._changeName_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.type = _arg_1;
            _local_5.nowName = _arg_2;
            _local_5.newName = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("common.changeName", _local_5);
            };
            return (null);
        }

        public function setTroopConfig(_arg_1:String, _arg_2:TroopBean, _arg_3:Function=null):TroopConfigResponse
        {
            this._setTroopConfig_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.name = _arg_1;
            _local_4.config = _arg_2.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("common.setTroopConfig", _local_4);
            };
            return (null);
        }

        public function mapCastle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):MapCastleResponse
        {
            this._mapCastle_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.x1 = _arg_2;
            _local_7.y1 = _arg_3;
            _local_7.x2 = _arg_4;
            _local_7.y2 = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("common.mapCastle", _local_7);
            };
            return (null);
        }

        public function privateChat(_arg_1:String, _arg_2:String, _arg_3:Function=null):ChatResponse
        {
            this._privateChat_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.targetName = _arg_1;
            _local_4.msg = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.privateChat", _local_4);
            };
            return (null);
        }

        public function mapInfoSimple(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):MapInfoSimpleResponse
        {
            this._mapInfoSimple_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.x1 = _arg_2;
            _local_7.y1 = _arg_3;
            _local_7.x2 = _arg_4;
            _local_7.y2 = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("common.mapInfoSimple", _local_7);
            };
            return (null);
        }

        public function getPackageNumber(_arg_1:Function=null):GetPackageNumberResponse
        {
            this._getPackageNumber_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.getPackageNumber", _local_2);
            };
            return (null);
        }

        public function zoneInfo(_arg_1:Function=null):ZoneInfoResponse
        {
            this._zoneInfo_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.zoneInfo", _local_2);
            };
            return (null);
        }

        public function setEovnyMember(_arg_1:Function=null):CommandResponse
        {
            this._setEovnyMember_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.setEovnyMember", _local_2);
            };
            return (null);
        }

        public function setReceiveIncomingAttack(_arg_1:Boolean, _arg_2:Function=null):CommandResponse
        {
            this._setReceiveIncomingAttack_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.isAccept = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.setReceiveIncomingAttack", _local_3);
            };
            return (null);
        }

        public function changeUserFace(_arg_1:String, _arg_2:int, _arg_3:Function=null):ChangeUserFaceResponse
        {
            this._changeUserFace_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.faceUrl = _arg_1;
            _local_4.sex = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.changeUserFace", _local_4);
            };
            return (null);
        }

        public function changeHeadline(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._changeHeadline_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.headline = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.changeHeadline", _local_3);
            };
            return (null);
        }

        public function getRelationship(_arg_1:int, _arg_2:Function=null):GetRelationshipRespone
        {
            this._getRelationship_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.playerId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.getRelationship", _local_3);
            };
            return (null);
        }

        public function setAutoHeal(_arg_1:Boolean, _arg_2:Function=null):CommandResponse
        {
            this._setAutoHeal_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.autoHeal = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.setAutoHeal", _local_3);
            };
            return (null);
        }

        public function addToFavorites(_arg_1:Function=null):CommandResponse
        {
            this._addToFavorites_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.addToFavorites", _local_2);
            };
            return (null);
        }

        public function getItemDefXml(_arg_1:Function=null):GetItemDefResponse
        {
            this._getItemDefXml_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.getItemDefXml", _local_2);
            };
            return (null);
        }

        public function denyPlayerSpeak(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._denyPlayerSpeak_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.playername = _arg_1;
            _local_4.time = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.denyPlayerSpeak", _local_4);
            };
            return (null);
        }

        public function getPlayerDeclaredWarStatus(_arg_1:int, _arg_2:Function=null):GetDeclaredWarResponse
        {
            this._getPlayerDeclaredWarStatus_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.playerId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.getPlayerDeclaredWarStatus", _local_3);
            };
            return (null);
        }

        public function getPackageList(_arg_1:Function=null):GetPackageListResponse
        {
            this._getPackageList_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.getPackageList", _local_2);
            };
            return (null);
        }

        public function step(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._step_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.tutorialStepId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.step", _local_3);
            };
            return (null);
        }

        public function setEvonyMemberEMail(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._setEvonyMemberEMail_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.email = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.setEvonyMemberEMail", _local_3);
            };
            return (null);
        }

        public function deleteUserAndRestart(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._deleteUserAndRestart_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.pwd = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.deleteUserAndRestart", _local_3);
            };
            return (null);
        }

        public function saveUnregisteredPlayer(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._saveUnregisteredPlayer_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.account = _arg_1;
            _local_4.password = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("common.saveUnregisteredPlayer", _local_4);
            };
            return (null);
        }

        public function setEventDone(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._setEventDone_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.id = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("common.setEventDone", _local_3);
            };
            return (null);
        }

        public function channelChat(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:Function=null):ChatResponse
        {
            this._channelChat_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.channel = _arg_1;
            _local_5.sendMsg = _arg_2;
            _local_5.languageType = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("common.channelChat", _local_5);
            };
            return (null);
        }


    }
}//package com.evony.client.action

