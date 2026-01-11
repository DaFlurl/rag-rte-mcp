// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.VisitorHelpEvent

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class VisitorHelpEvent extends BaseBean 
    {

        public var visitorID:String;
        public var visitorName:String;

        public function VisitorHelpEvent(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.visitorID != null)
            {
                this.visitorID = _arg_2.visitorID;
            };
            if (_arg_2.visitorName != null)
            {
                this.visitorName = _arg_2.visitorName;
            };
        }

        public function copyTo(_arg_1:VisitorHelpEvent):void
        {
            _arg_1.visitorID = this.visitorID;
            _arg_1.visitorName = this.visitorName;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- VisitorHelpEvent ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "visitorID = ") + this.visitorID) + "\n"));
            return (_local_2 + (((_arg_1 + "visitorName = ") + this.visitorName) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.visitorID = this.visitorID;
            _local_1.visitorName = this.visitorName;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

