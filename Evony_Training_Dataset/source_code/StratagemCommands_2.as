package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   
   public class StratagemCommands
   {
      private var sender:Sender;
      
      public var _useStratagem_callback:Function;
      
      public function StratagemCommands()
      {
         super();
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function useStratagem(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._useStratagem_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("stratagem.useStratagem",{
               "castleId":param1,
               "heroId":param2,
               "straId":param3
            });
         }
         return null;
      }
   }
}

