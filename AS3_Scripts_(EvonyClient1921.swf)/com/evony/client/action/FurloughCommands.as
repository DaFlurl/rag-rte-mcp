// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.FurloughCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.furlough.FurloughResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class FurloughCommands 
    {

        public var _cancelFurlought_callback:Function;
        private var sender:Sender;
        public var _isFurlought_callback:Function;


        public function isFurlought(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Function=null):FurloughResponse
        {
            this._isFurlought_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.playerId = _arg_1;
            _local_6.day = _arg_2;
            _local_6.password = _arg_3;
            _local_6.isAutoFurlough = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("furlough.isFurlought", _local_6);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function cancelFurlought(_arg_1:int, _arg_2:Function=null):FurloughResponse
        {
            this._cancelFurlought_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.playerId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("furlough.cancelFurlought", _local_3);
            };
            return (null);
        }


    }
}//package com.evony.client.action

