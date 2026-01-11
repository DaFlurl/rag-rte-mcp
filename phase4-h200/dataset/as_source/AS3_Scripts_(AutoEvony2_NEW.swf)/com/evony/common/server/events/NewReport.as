// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.NewReport

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class NewReport extends BaseBean 
    {

        public var other_count:int;
        public var scout_cout:int;
        public var army_count:int;
        public var count:int;
        public var trade_count:int;

        public function NewReport(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
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
            return ({
                "army_count":this.army_count,
                "count":this.count,
                "other_count":this.other_count,
                "scout_cout":this.scout_cout,
                "trade_count":this.trade_count
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((((("---- NewReport ----\n" + (((_arg_1 + "army_count = ") + this.army_count) + "\n")) + (((_arg_1 + "count = ") + this.count) + "\n")) + (((_arg_1 + "other_count = ") + this.other_count) + "\n")) + (((_arg_1 + "scout_cout = ") + this.scout_cout) + "\n")) + (((_arg_1 + "trade_count = ") + this.trade_count) + "\n"));
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

