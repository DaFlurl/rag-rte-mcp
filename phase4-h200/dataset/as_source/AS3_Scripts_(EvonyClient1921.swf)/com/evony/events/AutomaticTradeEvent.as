// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.AutomaticTradeEvent

package com.evony.events
{
    import flash.events.Event;

    public class AutomaticTradeEvent extends Event 
    {

        public static const EVENT_NAME:String = "Market.automatictrade";

        public var tradeType:String;
        public var count:String;

        public function AutomaticTradeEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this.tradeType = _arg_2;
            this.count = _arg_3;
        }

    }
}//package com.evony.events

