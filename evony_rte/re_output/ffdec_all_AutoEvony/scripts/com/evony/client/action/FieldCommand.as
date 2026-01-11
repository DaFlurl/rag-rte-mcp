package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.field.CastleFieldInfoResponse;
   import com.evony.common.module.field.OtherFieldInfoResponse;
   
   public class FieldCommand
   {
      
      public var _getOtherFieldInfo_callback:Function;
      
      public var _getCastleFieldInfo_callback:Function;
      
      private var sender:Sender;
      
      public var _giveUpField_callback:Function;
      
      public function FieldCommand()
      {
         super();
      }
      
      public function giveUpField(param1:int, param2:Function = null) : CommandResponse
      {
         this._giveUpField_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("field.giveUpField",{"fieldId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function getCastleFieldInfo(param1:int, param2:Function = null) : CastleFieldInfoResponse
      {
         this._getCastleFieldInfo_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("field.getCastleFieldInfo",{"castleId":param1});
         }
         return null;
      }
      
      public function getOtherFieldInfo(param1:int, param2:int, param3:Function = null) : OtherFieldInfoResponse
      {
         this._getOtherFieldInfo_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("field.getOtherFieldInfo",{
               "castleId":param1,
               "fieldId":param2
            });
         }
         return null;
      }
   }
}

