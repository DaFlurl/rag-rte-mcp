// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.AllianceManagementCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.common.module.alliance.AllianceUserAddResponse;
    import com.evony.common.module.alliance.AllianceInviteBeanResponse;
    import com.evony.common.module.alliance.AllianceFriendshipResponse;
    import com.evony.common.module.alliance.WantedAllianceResponse;
    import com.evony.common.module.alliance.HasAllianceResponse;
    import com.evony.common.module.alliance.AlliancePowerLevelResponse;
    import com.evony.common.module.alliance.AllianceInviteOnClientBeanResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class AllianceManagementCommands 
    {

        public var _rejectComeinAlliance_callback:Function;
        public var _getAllianceWanted_callback:Function;
        public var _dropAllianceFriendshipRelation_callback:Function;
        public var _messagesForAllianceMember_callback:Function;
        public var _setPowerForUserByAlliance_callback:Function;
        public var _addUsertoAlliance_callback:Function;
        public var _addUsertoAllianceList_callback:Function;
        public var _setAllianceFriendship_callback:Function;
        public var _resignForAlliance_callback:Function;
        public var _getPowerFromAlliance_callback:Function;
        public var _sayByetoAlliance_callback:Function;
        public var _agreeComeinAllianceList_callback:Function;
        public var _isHasAlliance_callback:Function;
        public var _kickOutMemberfromAlliance_callback:Function;
        public var _resetTopPowerForAlliance_callback:Function;
        public var _getAllianceFriendshipList_callback:Function;
        private var sender:Sender;
        public var _cancelUserWantInAlliance_callback:Function;
        public var _agreeComeinAllianceByUser_callback:Function;
        public var _agreeComeinAllianceByLeader_callback:Function;
        public var _canceladdUsertoAlliance_callback:Function;
        public var _leaderWantUserInAllianceList_callback:Function;
        public var _setAllInfoForAlliance_callback:Function;
        public var _createAlliance_callback:Function;
        public var _userWantInAlliance_callback:Function;
        public var _cancelagreeComeinAlliance_callback:Function;


        public function resetTopPowerForAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._resetTopPowerForAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.resetTopPowerForAlliance", _local_3);
            };
            return (null);
        }

        public function userWantInAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._userWantInAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.allianceName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.userWantInAlliance", _local_3);
            };
            return (null);
        }

        public function agreeComeinAllianceList(_arg_1:Function=null):AllianceUserAddResponse
        {
            this._agreeComeinAllianceList_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.agreeComeinAllianceList", _local_2);
            };
            return (null);
        }

        public function resignForAlliance(_arg_1:Function=null):AllianceManagementResponse
        {
            this._resignForAlliance_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.resignForAlliance", _local_2);
            };
            return (null);
        }

        public function cancelUserWantInAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._cancelUserWantInAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.allianceName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.cancelUserWantInAlliance", _local_3);
            };
            return (null);
        }

        public function rejectComeinAlliance(_arg_1:String, _arg_2:Function=null):AllianceUserAddResponse
        {
            this._rejectComeinAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.allianceName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.rejectComeinAlliance", _local_3);
            };
            return (null);
        }

        public function cancelagreeComeinAlliance(_arg_1:String, _arg_2:Function=null):AllianceUserAddResponse
        {
            this._cancelagreeComeinAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.cancelagreeComeinAlliance", _local_3);
            };
            return (null);
        }

        public function addUsertoAllianceList(_arg_1:Function=null):AllianceInviteBeanResponse
        {
            this._addUsertoAllianceList_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.addUsertoAllianceList", _local_2);
            };
            return (null);
        }

        public function setPowerForUserByAlliance(_arg_1:String, _arg_2:int, _arg_3:Function=null):AllianceManagementResponse
        {
            this._setPowerForUserByAlliance_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.userName = _arg_1;
            _local_4.typeId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.setPowerForUserByAlliance", _local_4);
            };
            return (null);
        }

        public function canceladdUsertoAlliance(_arg_1:String, _arg_2:Function=null):AllianceInviteBeanResponse
        {
            this._canceladdUsertoAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.canceladdUsertoAlliance", _local_3);
            };
            return (null);
        }

        public function agreeComeinAllianceByLeader(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._agreeComeinAllianceByLeader_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.agreeComeinAllianceByLeader", _local_3);
            };
            return (null);
        }

        public function sayByetoAlliance(_arg_1:Function=null):AllianceManagementResponse
        {
            this._sayByetoAlliance_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.sayByetoAlliance", _local_2);
            };
            return (null);
        }

        public function getAllianceFriendshipList(_arg_1:Function=null):AllianceFriendshipResponse
        {
            this._getAllianceFriendshipList_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceFriendshipList", _local_2);
            };
            return (null);
        }

        public function setAllInfoForAlliance(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Function=null):AllianceManagementResponse
        {
            this._setAllInfoForAlliance_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.allianceName = _arg_1;
            _local_5.infoText = _arg_2;
            _local_5.noteText = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.setAllInfoForAlliance", _local_5);
            };
            return (null);
        }

        public function agreeComeinAllianceByUser(_arg_1:int, _arg_2:String, _arg_3:Function=null):AllianceUserAddResponse
        {
            this._agreeComeinAllianceByUser_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.allianceName = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.agreeComeinAllianceByUser", _local_4);
            };
            return (null);
        }

        public function getAllianceWanted(_arg_1:Function=null):WantedAllianceResponse
        {
            this._getAllianceWanted_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceWanted", _local_2);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function createAlliance(_arg_1:int, _arg_2:String, _arg_3:Function=null):AllianceManagementResponse
        {
            this._createAlliance_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.allianceName = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.createAlliance", _local_4);
            };
            return (null);
        }

        public function addUsertoAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._addUsertoAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.addUsertoAlliance", _local_3);
            };
            return (null);
        }

        public function dropAllianceFriendshipRelation(_arg_1:String, _arg_2:Function=null):AllianceFriendshipResponse
        {
            this._dropAllianceFriendshipRelation_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.targetAllianceName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.dropAllianceFriendshipRelation", _local_3);
            };
            return (null);
        }

        public function setAllianceFriendship(_arg_1:String, _arg_2:int, _arg_3:Function=null):AllianceManagementResponse
        {
            this._setAllianceFriendship_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.targetAllianceName = _arg_1;
            _local_4.type = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.setAllianceFriendship", _local_4);
            };
            return (null);
        }

        public function isHasAlliance(_arg_1:Function=null):HasAllianceResponse
        {
            this._isHasAlliance_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.isHasAlliance", _local_2);
            };
            return (null);
        }

        public function getPowerFromAlliance(_arg_1:Function=null):AlliancePowerLevelResponse
        {
            this._getPowerFromAlliance_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getPowerFromAlliance", _local_2);
            };
            return (null);
        }

        public function kickOutMemberfromAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._kickOutMemberfromAlliance_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.userName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.kickOutMemberfromAlliance", _local_3);
            };
            return (null);
        }

        public function messagesForAllianceMember(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:Function=null):AllianceManagementResponse
        {
            this._messagesForAllianceMember_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.title = _arg_1;
            _local_5.message = _arg_2;
            _local_5.type = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.messagesForAllianceMember", _local_5);
            };
            return (null);
        }

        public function leaderWantUserInAllianceList(_arg_1:Function=null):AllianceInviteOnClientBeanResponse
        {
            this._leaderWantUserInAllianceList_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.leaderWantUserInAllianceList", _local_2);
            };
            return (null);
        }


    }
}//package com.evony.client.action

