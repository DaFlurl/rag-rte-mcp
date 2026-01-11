package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.PlayerInfoResponse;
   import com.evony.common.module.common.ChangeNameResponse;
   import com.evony.common.module.common.ChangeUserFaceResponse;
   import com.evony.common.module.common.ChatResponse;
   import com.evony.common.module.common.CreatePlayerResponse;
   import com.evony.common.module.common.GetCanDeclaredWarAgainstPlayerRespone;
   import com.evony.common.module.common.GetDeclaredWarResponse;
   import com.evony.common.module.common.GetItemDefResponse;
   import com.evony.common.module.common.GetPackageListResponse;
   import com.evony.common.module.common.GetPackageNumberResponse;
   import com.evony.common.module.common.GetPackageResponse;
   import com.evony.common.module.common.GetRelationshipRespone;
   import com.evony.common.module.common.MapCastleResponse;
   import com.evony.common.module.common.MapInfoResponse;
   import com.evony.common.module.common.MapInfoSimpleResponse;
   import com.evony.common.module.common.TroopConfigResponse;
   import com.evony.common.module.common.ZoneInfoResponse;
   
   public class CommonCommands
   {
      
      public var _setEvonyMemberEMail_callback:Function;
      
      public var _addToFavorites_callback:Function;
      
      public var _getRelationship_callback:Function;
      
      public var _getCanDeclaredWarAgainstPlayer_callback:Function;
      
      public var _mapInfo_callback:Function;
      
      public var _setTroopConfig_callback:Function;
      
      private var sender:Sender;
      
      public var _getPlayerDeclaredWarStatus_callback:Function;
      
      public var _facebookConnect_callback:Function;
      
      public var _changeHeadline_callback:Function;
      
      public var _mapCastle_callback:Function;
      
      public var _declaredWarAgainstPlayer_callback:Function;
      
      public var _allianceChat_callback:Function;
      
      public var _getPackageList_callback:Function;
      
      public var _step_callback:Function;
      
      public var _getPlayerInfoByName_callback:Function;
      
      public var _getItemDefXml_callback:Function;
      
      public var _privateChat_callback:Function;
      
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
      
      public var _setEventDone_callback:Function;
      
      public var _setAutoHeal_callback:Function;
      
      public var _zoneInfo_callback:Function;
      
      public function CommonCommands()
      {
         super();
      }
      
      public function setEventDone(param1:int, param2:Function = null) : CommandResponse
      {
         this._setEventDone_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setEventDone",{"id":param1});
         }
         return null;
      }
      
      public function createNewPlayer(param1:String, param2:int, param3:String, param4:String, param5:String, param6:int, param7:String, param8:Function = null) : CreatePlayerResponse
      {
         this._createNewPlayer_callback = param8;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.createNewPlayer",{
               "userName":param1,
               "sex":param2,
               "faceUrl":param3,
               "flag":param4,
               "castleName":param5,
               "zone":param6,
               "accountName":param7
            });
         }
         return null;
      }
      
      public function setReturnReport(param1:Boolean, param2:Function = null) : CommandResponse
      {
         this._setReturnReport_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setReturnReport",{"returnReport":param1});
         }
         return null;
      }
      
      public function getPlayerInfoByName(param1:String, param2:Function = null) : PlayerInfoResponse
      {
         this._getPlayerInfoByName_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getPlayerInfoByName",{"userName":param1});
         }
         return null;
      }
      
      public function getCanDeclaredWarAgainstPlayer(param1:int, param2:Function = null) : GetCanDeclaredWarAgainstPlayerRespone
      {
         this._getCanDeclaredWarAgainstPlayer_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getCanDeclaredWarAgainstPlayer",{"playerId":param1});
         }
         return null;
      }
      
      public function worldChat(param1:String, param2:int, param3:Function = null) : ChatResponse
      {
         this._worldChat_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.worldChat",{
               "msg":param1,
               "languageType":param2
            });
         }
         return null;
      }
      
      public function getPackage(param1:int, param2:String, param3:Function = null) : GetPackageResponse
      {
         this._getPackage_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getPackage",{
               "ruleId":param1,
               "serial":param2
            });
         }
         return null;
      }
      
      public function allianceChat(param1:String, param2:int, param3:Function = null) : ChatResponse
      {
         this._allianceChat_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.allianceChat",{
               "msg":param1,
               "languageType":param2
            });
         }
         return null;
      }
      
      public function mapInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : MapInfoResponse
      {
         this._mapInfo_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.mapInfo",{
               "castleId":param1,
               "x1":param2,
               "y1":param3,
               "x2":param4,
               "y2":param5
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function facebookConnect(param1:String, param2:String, param3:String, param4:Function = null) : CommandResponse
      {
         this._facebookConnect_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.facebookConnect",{
               "facebookId":param1,
               "password":param2,
               "fbsig":param3
            });
         }
         return null;
      }
      
      public function delUniteServerPeaceStatus(param1:Function = null) : CommandResponse
      {
         this._delUniteServerPeaceStatus_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.delUniteServerPeaceStatus",{});
         }
         return null;
      }
      
      public function declaredWarAgainstPlayer(param1:int, param2:Function = null) : CommandResponse
      {
         this._declaredWarAgainstPlayer_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.declaredWarAgainstPlayer",{"playerId":param1});
         }
         return null;
      }
      
      public function changeName(param1:int, param2:String, param3:String, param4:Function = null) : ChangeNameResponse
      {
         this._changeName_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.changeName",{
               "type":param1,
               "nowName":param2,
               "newName":param3
            });
         }
         return null;
      }
      
      public function setTroopConfig(param1:String, param2:TroopBean, param3:Function = null) : TroopConfigResponse
      {
         this._setTroopConfig_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setTroopConfig",{
               "name":param1,
               "config":param2.toObject()
            });
         }
         return null;
      }
      
      public function mapCastle(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : MapCastleResponse
      {
         this._mapCastle_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.mapCastle",{
               "castleId":param1,
               "x1":param2,
               "y1":param3,
               "x2":param4,
               "y2":param5
            });
         }
         return null;
      }
      
      public function getPackageNumber(param1:Function = null) : GetPackageNumberResponse
      {
         this._getPackageNumber_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getPackageNumber",{});
         }
         return null;
      }
      
      public function zoneInfo(param1:Function = null) : ZoneInfoResponse
      {
         this._zoneInfo_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.zoneInfo",{});
         }
         return null;
      }
      
      public function privateChat(param1:String, param2:String, param3:Function = null) : ChatResponse
      {
         this._privateChat_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.privateChat",{
               "targetName":param1,
               "msg":param2
            });
         }
         return null;
      }
      
      public function mapInfoSimple(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : MapInfoSimpleResponse
      {
         this._mapInfoSimple_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.mapInfoSimple",{
               "castleId":param1,
               "x1":param2,
               "y1":param3,
               "x2":param4,
               "y2":param5
            });
         }
         return null;
      }
      
      public function setEovnyMember(param1:Function = null) : CommandResponse
      {
         this._setEovnyMember_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setEovnyMember",{});
         }
         return null;
      }
      
      public function setReceiveIncomingAttack(param1:Boolean, param2:Function = null) : CommandResponse
      {
         this._setReceiveIncomingAttack_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setReceiveIncomingAttack",{"isAccept":param1});
         }
         return null;
      }
      
      public function changeUserFace(param1:String, param2:int, param3:Function = null) : ChangeUserFaceResponse
      {
         this._changeUserFace_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.changeUserFace",{
               "faceUrl":param1,
               "sex":param2
            });
         }
         return null;
      }
      
      public function changeHeadline(param1:String, param2:Function = null) : CommandResponse
      {
         this._changeHeadline_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.changeHeadline",{"headline":param1});
         }
         return null;
      }
      
      public function getRelationship(param1:int, param2:Function = null) : GetRelationshipRespone
      {
         this._getRelationship_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getRelationship",{"playerId":param1});
         }
         return null;
      }
      
      public function setAutoHeal(param1:Boolean, param2:Function = null) : CommandResponse
      {
         this._setAutoHeal_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setAutoHeal",{"autoHeal":param1});
         }
         return null;
      }
      
      public function addToFavorites(param1:Function = null) : CommandResponse
      {
         this._addToFavorites_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.addToFavorites",{});
         }
         return null;
      }
      
      public function getItemDefXml(param1:Function = null) : GetItemDefResponse
      {
         this._getItemDefXml_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getItemDefXml",{});
         }
         return null;
      }
      
      public function denyPlayerSpeak(param1:String, param2:int, param3:Function = null) : CommandResponse
      {
         this._denyPlayerSpeak_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.denyPlayerSpeak",{
               "playername":param1,
               "time":param2
            });
         }
         return null;
      }
      
      public function getPlayerDeclaredWarStatus(param1:int, param2:Function = null) : GetDeclaredWarResponse
      {
         this._getPlayerDeclaredWarStatus_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getPlayerDeclaredWarStatus",{"playerId":param1});
         }
         return null;
      }
      
      public function getPackageList(param1:Function = null) : GetPackageListResponse
      {
         this._getPackageList_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getPackageList",{});
         }
         return null;
      }
      
      public function step(param1:int, param2:Function = null) : CommandResponse
      {
         this._step_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.step",{"tutorialStepId":param1});
         }
         return null;
      }
      
      public function setEvonyMemberEMail(param1:String, param2:Function = null) : CommandResponse
      {
         this._setEvonyMemberEMail_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setEvonyMemberEMail",{"email":param1});
         }
         return null;
      }
      
      public function deleteUserAndRestart(param1:String, param2:Function = null) : CommandResponse
      {
         this._deleteUserAndRestart_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.deleteUserAndRestart",{"pwd":param1});
         }
         return null;
      }
      
      public function saveUnregisteredPlayer(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._saveUnregisteredPlayer_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.saveUnregisteredPlayer",{
               "account":param1,
               "password":param2
            });
         }
         return null;
      }
      
      public function channelChat(param1:String, param2:String, param3:int, param4:Function = null) : ChatResponse
      {
         this._channelChat_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.channelChat",{
               "channel":param1,
               "sendMsg":param2,
               "languageType":param3
            });
         }
         return null;
      }
   }
}

