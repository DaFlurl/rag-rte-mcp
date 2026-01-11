// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.ConnectionLost

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class ConnectionLost extends BaseBean 
    {

        public static const KICK_BY_SERVER:int = 0;
        public static const SERVER_START:int = 1;
        public static const SERVER_SHUTDOWN:int = 2;
        public static const KICK_BY_OTHER:int = 3;
        public static const SERVER_MAINTAIN:int = 4;
        public static const ILLEGAL_NAME:int = 5;
        public static const LOGIN_FREQUENTLY:int = 6;

        public var reasonCode:int;
        public var msg:String;

        public function ConnectionLost(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.reasonCode != null)
            {
                this.reasonCode = _arg_2.reasonCode;
            };
        }

        public function copyTo(_arg_1:ConnectionLost):void
        {
            _arg_1.msg = this.msg;
            _arg_1.reasonCode = this.reasonCode;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.msg = this.msg;
            _local_1.reasonCode = this.reasonCode;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- ConnectionLost ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            return (_local_2 + (((_arg_1 + "reasonCode = ") + this.reasonCode) + "\n"));
        }


    }
}//package com.evony.common.server.events

