package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.alliance.AllianceArmyResponse;
   import com.evony.common.module.alliance.AllianceEventListResponse;
   import com.evony.common.module.alliance.AllianceInfoResponse;
   import com.evony.common.module.alliance.AllianceListResponse;
   import com.evony.common.module.alliance.AllianceMembersResponse;
   import com.evony.common.module.alliance.MilitarySituationListResponse;
   
   public class AllianceCommands
   {
      
      public var _getAllianceArmyReport_callback:Function;
      
      public var _getAllianceInfo_callback:Function;
      
      public var _getMilitarySituationList_callback:Function;
      
      private var sender:Sender;
      
      public var _getAllianceList_callback:Function;
      
      public var _getAllianceMembers_callback:Function;
      
      public var _getAllianceEventList_callback:Function;
      
      public function AllianceCommands()
      {
         super();
      }
      
      public function getMilitarySituationList(param1:int, param2:int, param3:Function = null) : MilitarySituationListResponse
      {
         this._getMilitarySituationList_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getMilitarySituationList",{
               "pageNo":param1,
               "pageSize":param2
            });
         }
         return null;
      }
      
      public function getAllianceList(param1:int, param2:int, param3:int, param4:String, param5:Function = null) : AllianceListResponse
      {
         this._getAllianceList_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceList",{
               "pageSize":param1,
               "pageNum":param2,
               "ranking":param3,
               "name":param4
            });
         }
         return null;
      }
      
      public function getAllianceMembers(param1:Function = null) : AllianceMembersResponse
      {
         this._getAllianceMembers_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceMembers",{});
         }
         return null;
      }
      
      public function getAllianceEventList(param1:int, param2:Function = null) : AllianceEventListResponse
      {
         this._getAllianceEventList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceEventList",{"pageNo":param1});
         }
         return null;
      }
      
      public function getAllianceArmyReport(param1:int, param2:Function = null) : AllianceArmyResponse
      {
         this._getAllianceArmyReport_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceArmyReport",{"armyId":param1});
         }
         return null;
      }
      
      public function getAllianceInfo(param1:String, param2:Function = null) : AllianceInfoResponse
      {
         this._getAllianceInfo_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("alliance.getAllianceInfo",{"allianceName":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

