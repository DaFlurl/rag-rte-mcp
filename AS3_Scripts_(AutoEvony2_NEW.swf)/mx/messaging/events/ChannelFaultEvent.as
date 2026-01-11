// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.events.ChannelFaultEvent

package mx.messaging.events
{
    import mx.messaging.Channel;
    import flash.events.Event;
    import mx.messaging.messages.ErrorMessage;

    public class ChannelFaultEvent extends ChannelEvent 
    {

        public static const FAULT:String = "channelFault";

        public var faultString:String;
        public var rootCause:Object;
        public var faultDetail:String;
        public var faultCode:String;

        public function ChannelFaultEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Channel=null, _arg_5:Boolean=false, _arg_6:String=null, _arg_7:String=null, _arg_8:String=null, _arg_9:Boolean=false, _arg_10:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_9, _arg_10);
            faultCode = _arg_6;
            faultString = _arg_7;
            faultDetail = _arg_8;
        }

        public static function createEvent(_arg_1:Channel, _arg_2:Boolean=false, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false, _arg_7:Boolean=false):ChannelFaultEvent
        {
            return (new ChannelFaultEvent(ChannelFaultEvent.FAULT, false, false, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
        }


        override public function clone():Event
        {
            var _local_1:ChannelFaultEvent = new ChannelFaultEvent(type, bubbles, cancelable, channel, reconnecting, faultCode, faultString, faultDetail, rejected, connected);
            _local_1.rootCause = rootCause;
            return (_local_1);
        }

        public function createErrorMessage():ErrorMessage
        {
            var _local_1:ErrorMessage = new ErrorMessage();
            _local_1.faultCode = faultCode;
            _local_1.faultString = faultString;
            _local_1.faultDetail = faultDetail;
            _local_1.rootCause = rootCause;
            return (_local_1);
        }

        override public function toString():String
        {
            return (formatToString("ChannelFaultEvent", "faultCode", "faultString", "faultDetail", "channelId", "type", "bubbles", "cancelable", "eventPhase"));
        }


    }
}//package mx.messaging.events

