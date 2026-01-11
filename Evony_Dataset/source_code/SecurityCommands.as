package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.common.GetIsSecurityCodeSettedResponse;
   import com.evony.common.module.common.GetProtectOptionResponse;
   
   public class SecurityCommands
   {
      public var _setProtectOption_callback:Function;
      
      public var _setUnlockOption_callback:Function;
      
      public var _removeSecurityCode_callback:Function;
      
      public var _getProtectOption_callback:Function;
      
      public var _setSecurityCode_callback:Function;
      
      public var _cancelRemovingSecurityCodeProcess_callback:Function;
      
      public var _getIsSecurityCodeSetted_callback:Function;
      
      public var _changeSecurityCode_callback:Function;
      
      public var _authSecurityCode_callback:Function;
      
      private var sender:Sender;
      
      public function SecurityCommands()
      {
         super();
      }
      
      public function cancelRemovingSecurityCodeProcess(param1:Function = null) : CommandResponse
      {
         this._cancelRemovingSecurityCodeProcess_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.cancelRemovingSecurityCodeProcess",{});
         }
         return null;
      }
      
      public function setSecurityCode(param1:String, param2:Function = null) : CommandResponse
      {
         this._setSecurityCode_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setSecurityCode",{"code":param1});
         }
         return null;
      }
      
      public function authSecurityCode(param1:String, param2:Function = null) : CommandResponse
      {
         this._authSecurityCode_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.authSecurityCode",{"code":param1});
         }
         return null;
      }
      
      public function changeSecurityCode(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._changeSecurityCode_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.changeSecurityCode",{
               "curCode":param1,
               "newCode":param2
            });
         }
         return null;
      }
      
      public function getIsSecurityCodeSetted(param1:Function = null) : GetIsSecurityCodeSettedResponse
      {
         this._getIsSecurityCodeSetted_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getIsSecurityCodeSetted",{});
         }
         return null;
      }
      
      public function setUnlockOption(param1:int, param2:Function = null) : CommandResponse
      {
         this._setUnlockOption_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setUnlockOption",{"option":param1});
         }
         return null;
      }
      
      public function setProtectOption(param1:int, param2:Function = null) : CommandResponse
      {
         this._setProtectOption_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.setProtectOption",{"option":param1});
         }
         return null;
      }
      
      public function removeSecurityCode(param1:Function = null) : CommandResponse
      {
         this._removeSecurityCode_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.removeSecurityCode",{});
         }
         return null;
      }
      
      public function getProtectOption(param1:Function = null) : GetProtectOptionResponse
      {
         this._getProtectOption_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("common.getProtectOption",{});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

