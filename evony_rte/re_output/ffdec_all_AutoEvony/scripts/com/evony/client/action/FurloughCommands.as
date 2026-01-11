package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.furlough.FurloughResponse;
   
   public class FurloughCommands
   {
      
      public var _cancelFurlought_callback:Function;
      
      private var sender:Sender;
      
      public var _isFurlought_callback:Function;
      
      public function FurloughCommands()
      {
         super();
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function isFurlought(param1:int, param2:int, param3:String, param4:Boolean, param5:Function = null) : FurloughResponse
      {
         this._isFurlought_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("furlough.isFurlought",{
               "playerId":param1,
               "day":param2,
               "password":param3,
               "isAutoFurlough":param4
            });
         }
         return null;
      }
      
      public function cancelFurlought(param1:int, param2:Function = null) : FurloughResponse
      {
         this._cancelFurlought_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("furlough.cancelFurlought",{"playerId":param1});
         }
         return null;
      }
   }
}

