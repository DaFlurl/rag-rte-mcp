package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.npchero.NpcHeroListResponse;
   
   public class NpcHeroCommand
   {
      
      public var _getNpcHerosList_callback:Function;
      
      public var _getNpcHerosListByFilter_callback:Function;
      
      public var _getNpcHerosListByMoney_callback:Function;
      
      private var sender:Sender;
      
      public var _getNpcHeroInfroByID_callback:Function;
      
      public function NpcHeroCommand()
      {
         super();
      }
      
      public function getNpcHeroInfroByID(param1:int, param2:int, param3:Function = null) : NpcHeroListResponse
      {
         this._getNpcHeroInfroByID_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("npchero.getNpcHeroInfroByID",{
               "npcid":param1,
               "castleId":param2
            });
         }
         return null;
      }
      
      public function getNpcHerosList(param1:int, param2:Function = null) : NpcHeroListResponse
      {
         this._getNpcHerosList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("npchero.getNpcHerosList",{"castleId":param1});
         }
         return null;
      }
      
      public function getNpcHerosListByFilter(param1:String, param2:int, param3:Function = null) : NpcHeroListResponse
      {
         this._getNpcHerosListByFilter_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("npchero.getNpcHerosListByFilter",{
               "filter":param1,
               "castleId":param2
            });
         }
         return null;
      }
      
      public function getNpcHerosListByMoney(param1:int, param2:Function = null) : NpcHeroListResponse
      {
         this._getNpcHerosListByMoney_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("npchero.getNpcHerosListByMoney",{"castleId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

