// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.NewMail

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class NewMail extends BaseBean 
    {

        public var count_inbox:int;
        public var count:int;
        public var count_system:int;

        public function NewMail(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.count != null)
            {
                this.count = _arg_2.count;
            };
            if (_arg_2.count_inbox != null)
            {
                this.count_inbox = _arg_2.count_inbox;
            };
            if (_arg_2.count_system != null)
            {
                this.count_system = _arg_2.count_system;
            };
        }

        public function copyTo(_arg_1:NewMail):void
        {
            _arg_1.count = this.count;
            _arg_1.count_inbox = this.count_inbox;
            _arg_1.count_system = this.count_system;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- NewMail ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "count = ") + this.count) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "count_inbox = ") + this.count_inbox) + "\n"));
            return (_local_2 + (((_arg_1 + "count_system = ") + this.count_system) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.count = this.count;
            _local_1.count_inbox = this.count_inbox;
            _local_1.count_system = this.count_system;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

