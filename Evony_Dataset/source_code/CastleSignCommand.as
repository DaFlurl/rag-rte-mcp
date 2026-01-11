package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.castle.CastleSignResponse;
   
   public class CastleSignCommand
   {
      internal var sender:Sender;
      
      public var _saveCastleSignList_callback:Function;
      
      public var _deleteCastleSign_callback:Function;
      
      public function CastleSignCommand()
      {
         super();
      }
      
      public function deleteCastleSign(param1:int, param2:Function = null) : CastleSignResponse
      {
         this._deleteCastleSign_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.deleteCastleSign",{"id":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function saveCastleSignList(param1:int, param2:int, param3:int, param4:Function = null) : CastleSignResponse
      {
         this._saveCastleSignList_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.saveCastleSignList",{
               "id":param1,
               "x":param2,
               "y":param3
            });
         }
         return null;
      }
   }
}

