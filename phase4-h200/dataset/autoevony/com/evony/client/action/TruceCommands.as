// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.TruceCommands

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


        public function cancelDreamTruce(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._cancelDreamTruce_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("truce.cancelDreamTruce", {"password":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function setDreamTruce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._setDreamTruce_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("truce.setDreamTruce", {
                    "hour":_arg_1,
                    "minute":_arg_2,
                    "second":_arg_3,
                    "password":_arg_4
                });
            };
            return (null);
        }

        public function changeDreamTruceTime(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._changeDreamTruceTime_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("truce.changeDreamTruceTime", {
                    "hour":_arg_1,
                    "minute":_arg_2,
                    "second":_arg_3,
                    "password":_arg_4
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

