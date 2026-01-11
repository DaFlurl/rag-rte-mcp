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
        private var sender:Sender;
        public var _sayByetoAlliance_callback:Function;
        public var _agreeComeinAllianceList_callback:Function;
        public var _isHasAlliance_callback:Function;
        public var _kickOutMemberfromAlliance_callback:Function;
        public var _resetTopPowerForAlliance_callback:Function;
        public var _getAllianceFriendshipList_callback:Function;
        public var _getPowerFromAlliance_callback:Function;
        public var _cancelUserWantInAlliance_callback:Function;
        public var _agreeComeinAllianceByUser_callback:Function;
        public var _agreeComeinAllianceByLeader_callback:Function;
        public var _canceladdUsertoAlliance_callback:Function;
        public var _leaderWantUserInAllianceList_callback:Function;
        public var _setAllInfoForAlliance_callback:Function;
        public var _cancelagreeComeinAlliance_callback:Function;
        public var _createAlliance_callback:Function;
        public var _userWantInAlliance_callback:Function;


        public function resetTopPowerForAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._resetTopPowerForAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.resetTopPowerForAlliance", {"userName":_arg_1});
            };
            return (null);
        }

        public function agreeComeinAllianceList(_arg_1:Function=null):AllianceUserAddResponse
        {
            this._agreeComeinAllianceList_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.agreeComeinAllianceList", {});
            };
            return (null);
        }

        public function resignForAlliance(_arg_1:Function=null):AllianceManagementResponse
        {
            this._resignForAlliance_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.resignForAlliance", {});
            };
            return (null);
        }

        public function cancelUserWantInAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._cancelUserWantInAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.cancelUserWantInAlliance", {"allianceName":_arg_1});
            };
            return (null);
        }

        public function rejectComeinAlliance(_arg_1:String, _arg_2:Function=null):AllianceUserAddResponse
        {
            this._rejectComeinAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.rejectComeinAlliance", {"allianceName":_arg_1});
            };
            return (null);
        }

        public function cancelagreeComeinAlliance(_arg_1:String, _arg_2:Function=null):AllianceUserAddResponse
        {
            this._cancelagreeComeinAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.cancelagreeComeinAlliance", {"userName":_arg_1});
            };
            return (null);
        }

        public function addUsertoAllianceList(_arg_1:Function=null):AllianceInviteBeanResponse
        {
            this._addUsertoAllianceList_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.addUsertoAllianceList", {});
            };
            return (null);
        }

        public function canceladdUsertoAlliance(_arg_1:String, _arg_2:Function=null):AllianceInviteBeanResponse
        {
            this._canceladdUsertoAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.canceladdUsertoAlliance", {"userName":_arg_1});
            };
            return (null);
        }

        public function agreeComeinAllianceByLeader(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._agreeComeinAllianceByLeader_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.agreeComeinAllianceByLeader", {"userName":_arg_1});
            };
            return (null);
        }

        public function sayByetoAlliance(_arg_1:Function=null):AllianceManagementResponse
        {
            this._sayByetoAlliance_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.sayByetoAlliance", {});
            };
            return (null);
        }

        public function getAllianceFriendshipList(_arg_1:Function=null):AllianceFriendshipResponse
        {
            this._getAllianceFriendshipList_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceFriendshipList", {});
            };
            return (null);
        }

        public function agreeComeinAllianceByUser(_arg_1:int, _arg_2:String, _arg_3:Function=null):AllianceUserAddResponse
        {
            this._agreeComeinAllianceByUser_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.agreeComeinAllianceByUser", {
                    "castleId":_arg_1,
                    "allianceName":_arg_2
                });
            };
            return (null);
        }

        public function setAllInfoForAlliance(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Function=null):AllianceManagementResponse
        {
            this._setAllInfoForAlliance_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.setAllInfoForAlliance", {
                    "allianceName":_arg_1,
                    "infoText":_arg_2,
                    "noteText":_arg_3
                });
            };
            return (null);
        }

        public function getAllianceWanted(_arg_1:Function=null):WantedAllianceResponse
        {
            this._getAllianceWanted_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceWanted", {});
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
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.createAlliance", {
                    "castleId":_arg_1,
                    "allianceName":_arg_2
                });
            };
            return (null);
        }

        public function userWantInAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._userWantInAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.userWantInAlliance", {"allianceName":_arg_1});
            };
            return (null);
        }

        public function dropAllianceFriendshipRelation(_arg_1:String, _arg_2:Function=null):AllianceFriendshipResponse
        {
            this._dropAllianceFriendshipRelation_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.dropAllianceFriendshipRelation", {"targetAllianceName":_arg_1});
            };
            return (null);
        }

        public function addUsertoAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._addUsertoAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.addUsertoAlliance", {"userName":_arg_1});
            };
            return (null);
        }

        public function setAllianceFriendship(_arg_1:String, _arg_2:int, _arg_3:Function=null):AllianceManagementResponse
        {
            this._setAllianceFriendship_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.setAllianceFriendship", {
                    "targetAllianceName":_arg_1,
                    "type":_arg_2
                });
            };
            return (null);
        }

        public function isHasAlliance(_arg_1:Function=null):HasAllianceResponse
        {
            this._isHasAlliance_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.isHasAlliance", {});
            };
            return (null);
        }

        public function getPowerFromAlliance(_arg_1:Function=null):AlliancePowerLevelResponse
        {
            this._getPowerFromAlliance_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getPowerFromAlliance", {});
            };
            return (null);
        }

        public function kickOutMemberfromAlliance(_arg_1:String, _arg_2:Function=null):AllianceManagementResponse
        {
            this._kickOutMemberfromAlliance_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.kickOutMemberfromAlliance", {"userName":_arg_1});
            };
            return (null);
        }

        public function messagesForAllianceMember(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:Function=null):AllianceManagementResponse
        {
            this._messagesForAllianceMember_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.messagesForAllianceMember", {
                    "title":_arg_1,
                    "message":_arg_2,
                    "type":_arg_3
                });
            };
            return (null);
        }

        public function leaderWantUserInAllianceList(_arg_1:Function=null):AllianceInviteOnClientBeanResponse
        {
            this._leaderWantUserInAllianceList_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.leaderWantUserInAllianceList", {});
            };
            return (null);
        }

        public function setPowerForUserByAlliance(_arg_1:String, _arg_2:int, _arg_3:Function=null):AllianceManagementResponse
        {
            this._setPowerForUserByAlliance_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.setPowerForUserByAlliance", {
                    "userName":_arg_1,
                    "typeId":_arg_2
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

