// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.SystemInfoMsg

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class SystemInfoMsg extends BaseBean 
    {

        public var msg:String;
        public var tV:Boolean;
        public var tVContext:String;
        public var noSenderSystemInfo:Boolean;
        public var sender:String;
        public var alliance:Boolean;

        public function SystemInfoMsg(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.sender != null)
            {
                this.sender = _arg_2.sender;
            };
            if (_arg_2.tVContext != null)
            {
                this.tVContext = _arg_2.tVContext;
            };
            if (_arg_2.alliance != null)
            {
                this.alliance = _arg_2.alliance;
            };
            if (_arg_2.noSenderSystemInfo != null)
            {
                this.noSenderSystemInfo = _arg_2.noSenderSystemInfo;
            };
            if (_arg_2.tV != null)
            {
                this.tV = _arg_2.tV;
            };
        }

        public function copyTo(_arg_1:SystemInfoMsg):void
        {
            _arg_1.msg = this.msg;
            _arg_1.sender = this.sender;
            _arg_1.tVContext = this.tVContext;
            _arg_1.alliance = this.alliance;
            _arg_1.noSenderSystemInfo = this.noSenderSystemInfo;
            _arg_1.tV = this.tV;
        }

        public function toObject():Object
        {
            return ({
                "msg":this.msg,
                "sender":this.sender,
                "tVContext":this.tVContext,
                "alliance":this.alliance,
                "noSenderSystemInfo":this.noSenderSystemInfo,
                "tV":this.tV
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (((((("---- SystemInfoMsg ----\n" + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "sender = ") + this.sender) + "\n")) + (((_arg_1 + "tVContext = ") + this.tVContext) + "\n")) + (((_arg_1 + "alliance = ") + this.alliance) + "\n")) + (((_arg_1 + "noSenderSystemInfo = ") + this.noSenderSystemInfo) + "\n")) + (((_arg_1 + "tV = ") + this.tV) + "\n"));
        }


    }
}//package com.evony.common.server.events

