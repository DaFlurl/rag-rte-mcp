// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.DeclaredWarStatusChange

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class DeclaredWarStatusChange extends BaseBean 
    {

        public var status:int;
        public var userName:String;

        public function DeclaredWarStatusChange(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.status != null)
            {
                this.status = _arg_2.status;
            };
            if (_arg_2.userName != null)
            {
                this.userName = _arg_2.userName;
            };
        }

        public function copyTo(_arg_1:DeclaredWarStatusChange):void
        {
            _arg_1.status = this.status;
            _arg_1.userName = this.userName;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- DeclaredWarStatusChange ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            return (_local_2 + (((_arg_1 + "userName = ") + this.userName) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.status = this.status;
            _local_1.userName = this.userName;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

