// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.KickedOut

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class KickedOut extends BaseBean 
    {

        public var ip:String;

        public function KickedOut(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.ip != null)
            {
                this.ip = _arg_2.ip;
            };
        }

        public function copyTo(_arg_1:KickedOut):void
        {
            _arg_1.ip = this.ip;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- KickedOut ----\n";
            return (_local_2 + (((_arg_1 + "ip = ") + this.ip) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.ip = this.ip;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

