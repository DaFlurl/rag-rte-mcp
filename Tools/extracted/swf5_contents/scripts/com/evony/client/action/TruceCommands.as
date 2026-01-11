package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   
   public class TruceCommands
   {
      public var _setDreamTruce_callback:Function;
      
      public var _changeDreamTruceTime_callback:Function;
      
      private var sender:Sender;
      
      public var _cancelDreamTruce_callback:Function;
      
      public function TruceCommands()
      {
         super();
      }
      
      public function cancelDreamTruce(param1:String, param2:Function = null) : CommandResponse
      {
         this._cancelDreamTruce_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("truce.cancelDreamTruce",{"password":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function setDreamTruce(param1:int, param2:int, param3:int, param4:String, param5:Function = null) : CommandResponse
      {
         this._setDreamTruce_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("truce.setDreamTruce",{
               "hour":param1,
               "minute":param2,
               "second":param3,
               "password":param4
            });
         }
         return null;
      }
      
      public function changeDreamTruceTime(param1:int, param2:int, param3:int, param4:String, param5:Function = null) : CommandResponse
      {
         this._changeDreamTruceTime_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("truce.changeDreamTruceTime",{
               "hour":param1,
               "minute":param2,
               "second":param3,
               "password":param4
            });
         }
         return null;
      }
   }
}

