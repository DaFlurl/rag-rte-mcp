// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.FurloughCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.furlough.FurloughResponse;

    public class FurloughCommands 
    {

        public var _cancelFurlought_callback:Function;
        private var sender:Sender;
        public var _isFurlought_callback:Function;


        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function isFurlought(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Function=null):FurloughResponse
        {
            this._isFurlought_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("furlough.isFurlought", {
                    "playerId":_arg_1,
                    "day":_arg_2,
                    "password":_arg_3,
                    "isAutoFurlough":_arg_4
                });
            };
            return (null);
        }

        public function cancelFurlought(_arg_1:int, _arg_2:Function=null):FurloughResponse
        {
            this._cancelFurlought_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("furlough.cancelFurlought", {"playerId":_arg_1});
            };
            return (null);
        }


    }
}//package com.evony.client.action

