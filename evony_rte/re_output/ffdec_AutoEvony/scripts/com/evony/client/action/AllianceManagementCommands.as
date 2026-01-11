package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.alliance.AllianceFriendshipResponse;
   import com.evony.common.module.alliance.AllianceInviteBeanResponse;
   import com.evony.common.module.alliance.AllianceInviteOnClientBeanResponse;
   import com.evony.common.module.alliance.AllianceManagementResponse;
   import com.evony.common.module.alliance.AlliancePowerLevelResponse;
   import com.evony.common.module.alliance.AllianceUserAddResponse;
   import com.evony.common.module.alliance.HasAllianceResponse;
   import com.evony.common.module.alliance.WantedAllianceResponse;
   
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
      
      public function AllianceManagementCommands()
      {
         super();
      }
      
      public function resetTopPowerForAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
      {
         this._resetTopPowerForAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.resetTopPowerForAlliance",{"userName":param1});
         }
         return null;
      }
      
      public function agreeComeinAllianceList(param1:Function = null) : AllianceUserAddResponse
      {
         this._agreeComeinAllianceList_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.agreeComeinAllianceList",{});
         }
         return null;
      }
      
      public function resignForAlliance(param1:Function = null) : AllianceManagementResponse
      {
         this._resignForAlliance_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.resignForAlliance",{});
         }
         return null;
      }
      
      public function cancelUserWantInAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
      {
         this._cancelUserWantInAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.cancelUserWantInAlliance",{"allianceName":param1});
         }
         return null;
      }
      
      public function rejectComeinAlliance(param1:String, param2:Function = null) : AllianceUserAddResponse
      {
         this._rejectComeinAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.rejectComeinAlliance",{"allianceName":param1});
         }
         return null;
      }
      
      public function cancelagreeComeinAlliance(param1:String, param2:Function = null) : AllianceUserAddResponse
      {
         this._cancelagreeComeinAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.cancelagreeComeinAlliance",{"userName":param1});
         }
         return null;
      }
      
      public function addUsertoAllianceList(param1:Function = null) : AllianceInviteBeanResponse
      {
         this._addUsertoAllianceList_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.addUsertoAllianceList",{});
         }
         return null;
      }
      
      public function canceladdUsertoAlliance(param1:String, param2:Function = null) : AllianceInviteBeanResponse
      {
         this._canceladdUsertoAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.canceladdUsertoAlliance",{"userName":param1});
         }
         return null;
      }
      
      public function agreeComeinAllianceByLeader(param1:String, param2:Function = null) : AllianceManagementResponse
      {
         this._agreeComeinAllianceByLeader_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.agreeComeinAllianceByLeader",{"userName":param1});
         }
         return null;
      }
      
      public function sayByetoAlliance(param1:Function = null) : AllianceManagementResponse
      {
         this._sayByetoAlliance_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.sayByetoAlliance",{});
         }
         return null;
      }
      
      public function getAllianceFriendshipList(param1:Function = null) : AllianceFriendshipResponse
      {
         this._getAllianceFriendshipList_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceFriendshipList",{});
         }
         return null;
      }
      
      public function agreeComeinAllianceByUser(param1:int, param2:String, param3:Function = null) : AllianceUserAddResponse
      {
         this._agreeComeinAllianceByUser_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.agreeComeinAllianceByUser",{
               "castleId":param1,
               "allianceName":param2
            });
         }
         return null;
      }
      
      public function setAllInfoForAlliance(param1:String, param2:String, param3:String, param4:Function = null) : AllianceManagementResponse
      {
         this._setAllInfoForAlliance_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.setAllInfoForAlliance",{
               "allianceName":param1,
               "infoText":param2,
               "noteText":param3
            });
         }
         return null;
      }
      
      public function getAllianceWanted(param1:Function = null) : WantedAllianceResponse
      {
         this._getAllianceWanted_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceWanted",{});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function createAlliance(param1:int, param2:String, param3:Function = null) : AllianceManagementResponse
      {
         this._createAlliance_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.createAlliance",{
               "castleId":param1,
               "allianceName":param2
            });
         }
         return null;
      }
      
      public function userWantInAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
      {
         this._userWantInAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.userWantInAlliance",{"allianceName":param1});
         }
         return null;
      }
      
      public function dropAllianceFriendshipRelation(param1:String, param2:Function = null) : AllianceFriendshipResponse
      {
         this._dropAllianceFriendshipRelation_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.dropAllianceFriendshipRelation",{"targetAllianceName":param1});
         }
         return null;
      }
      
      public function addUsertoAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
      {
         this._addUsertoAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.addUsertoAlliance",{"userName":param1});
         }
         return null;
      }
      
      public function setAllianceFriendship(param1:String, param2:int, param3:Function = null) : AllianceManagementResponse
      {
         this._setAllianceFriendship_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.setAllianceFriendship",{
               "targetAllianceName":param1,
               "type":param2
            });
         }
         return null;
      }
      
      public function isHasAlliance(param1:Function = null) : HasAllianceResponse
      {
         this._isHasAlliance_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.isHasAlliance",{});
         }
         return null;
      }
      
      public function getPowerFromAlliance(param1:Function = null) : AlliancePowerLevelResponse
      {
         this._getPowerFromAlliance_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getPowerFromAlliance",{});
         }
         return null;
      }
      
      public function kickOutMemberfromAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
      {
         this._kickOutMemberfromAlliance_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.kickOutMemberfromAlliance",{"userName":param1});
         }
         return null;
      }
      
      public function messagesForAllianceMember(param1:String, param2:String, param3:int, param4:Function = null) : AllianceManagementResponse
      {
         this._messagesForAllianceMember_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.messagesForAllianceMember",{
               "title":param1,
               "message":param2,
               "type":param3
            });
         }
         return null;
      }
      
      public function leaderWantUserInAllianceList(param1:Function = null) : AllianceInviteOnClientBeanResponse
      {
         this._leaderWantUserInAllianceList_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.leaderWantUserInAllianceList",{});
         }
         return null;
      }
      
      public function setPowerForUserByAlliance(param1:String, param2:int, param3:Function = null) : AllianceManagementResponse
      {
         this._setPowerForUserByAlliance_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.setPowerForUserByAlliance",{
               "userName":param1,
               "typeId":param2
            });
         }
         return null;
      }
   }
}

