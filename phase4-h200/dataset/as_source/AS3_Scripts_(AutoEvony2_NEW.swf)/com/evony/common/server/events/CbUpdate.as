// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.CbUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.*;

    public class CbUpdate extends BaseBean 
    {

        public var tp:int;
        public var text:String;

        public function CbUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.text != null)
            {
                this.text = _arg_2.text;
            };
            if (_arg_2.tp != null)
            {
                this.tp = _arg_2.tp;
            };
        }

        public function copyTo(_arg_1:CbUpdate):void
        {
            _arg_1.text = this.text;
            _arg_1.tp = this.tp;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- CbUpdate ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "text = ") + this.text) + "\n"));
            return (_local_3 + (((_arg_1 + "tp = ") + this.tp) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.text = this.text;
            _local_1.tp = this.tp;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

