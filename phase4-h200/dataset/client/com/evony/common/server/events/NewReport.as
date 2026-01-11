// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.NewReport

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class NewReport extends BaseBean 
    {

        public var other_count:int;
        public var scout_cout:int;
        public var army_count:int;
        public var count:int;
        public var trade_count:int;

        public function NewReport(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.army_count != null)
            {
                this.army_count = _arg_2.army_count;
            };
            if (_arg_2.count != null)
            {
                this.count = _arg_2.count;
            };
            if (_arg_2.other_count != null)
            {
                this.other_count = _arg_2.other_count;
            };
            if (_arg_2.scout_cout != null)
            {
                this.scout_cout = _arg_2.scout_cout;
            };
            if (_arg_2.trade_count != null)
            {
                this.trade_count = _arg_2.trade_count;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.army_count = this.army_count;
            _local_1.count = this.count;
            _local_1.other_count = this.other_count;
            _local_1.scout_cout = this.scout_cout;
            _local_1.trade_count = this.trade_count;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- NewReport ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "army_count = ") + this.army_count) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "count = ") + this.count) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "other_count = ") + this.other_count) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "scout_cout = ") + this.scout_cout) + "\n"));
            return (_local_2 + (((_arg_1 + "trade_count = ") + this.trade_count) + "\n"));
        }

        public function copyTo(_arg_1:NewReport):void
        {
            _arg_1.army_count = this.army_count;
            _arg_1.count = this.count;
            _arg_1.other_count = this.other_count;
            _arg_1.scout_cout = this.scout_cout;
            _arg_1.trade_count = this.trade_count;
        }


    }
}//package com.evony.common.server.events

