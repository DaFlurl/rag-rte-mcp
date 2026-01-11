// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.SecurityCommands

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


        public function cancelRemovingSecurityCodeProcess(_arg_1:Function=null):CommandResponse
        {
            this._cancelRemovingSecurityCodeProcess_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.cancelRemovingSecurityCodeProcess", {});
            };
            return (null);
        }

        public function setSecurityCode(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._setSecurityCode_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.setSecurityCode", {"code":_arg_1});
            };
            return (null);
        }

        public function authSecurityCode(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._authSecurityCode_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.authSecurityCode", {"code":_arg_1});
            };
            return (null);
        }

        public function changeSecurityCode(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._changeSecurityCode_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.changeSecurityCode", {
                    "curCode":_arg_1,
                    "newCode":_arg_2
                });
            };
            return (null);
        }

        public function getIsSecurityCodeSetted(_arg_1:Function=null):GetIsSecurityCodeSettedResponse
        {
            this._getIsSecurityCodeSetted_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.getIsSecurityCodeSetted", {});
            };
            return (null);
        }

        public function setUnlockOption(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._setUnlockOption_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.setUnlockOption", {"option":_arg_1});
            };
            return (null);
        }

        public function setProtectOption(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._setProtectOption_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.setProtectOption", {"option":_arg_1});
            };
            return (null);
        }

        public function removeSecurityCode(_arg_1:Function=null):CommandResponse
        {
            this._removeSecurityCode_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.removeSecurityCode", {});
            };
            return (null);
        }

        public function getProtectOption(_arg_1:Function=null):GetProtectOptionResponse
        {
            this._getProtectOption_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("common.getProtectOption", {});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

