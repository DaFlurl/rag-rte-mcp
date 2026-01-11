// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.CommonProduceEvent

package com.evony.events
{
    import flash.events.Event;
    import com.evony.common.beans.ProduceBean;
    import com.evony.eum.ItemEum;
    import com.evony.MsgDispacther;

    public class CommonProduceEvent extends Event 
    {

        public var eventData:Object;
        public var eventName:String;
        public var produceNum:int;
        public var toIdle:Boolean;
        public var produceBean:ProduceBean;
        public var typeId:int;
        public var speedUpItem:ItemEum;
        public var isShareTroop:Boolean;

        public function CommonProduceEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public static function produce(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:Boolean):void
        {
            var _local_6:CommonProduceEvent = new CommonProduceEvent(_arg_1);
            _local_6.typeId = _arg_2;
            _local_6.produceNum = _arg_3;
            _local_6.isShareTroop = _arg_4;
            _local_6.toIdle = _arg_5;
            MsgDispacther.getInstance().dispatchEvent(_local_6);
        }

        public static function cancel(_arg_1:String, _arg_2:ProduceBean):void
        {
            var _local_3:CommonProduceEvent = new CommonProduceEvent(_arg_1);
            _local_3.produceBean = _arg_2;
            MsgDispacther.getInstance().dispatchEvent(_local_3);
        }

        public static function refresh(_arg_1:String):void
        {
            var _local_2:CommonProduceEvent = new CommonProduceEvent(_arg_1);
            MsgDispacther.getInstance().dispatchEvent(_local_2);
        }

        public static function speedup(_arg_1:String, _arg_2:ProduceBean, _arg_3:ItemEum=null):void
        {
            var _local_4:CommonProduceEvent = new CommonProduceEvent(_arg_1);
            _local_4.produceBean = _arg_2;
            if (_arg_3 != null)
            {
                _local_4.speedUpItem = _arg_3;
            };
            _local_4.eventName = _arg_1;
            MsgDispacther.getInstance().dispatchEvent(_local_4);
        }


    }
}//package com.evony.events

