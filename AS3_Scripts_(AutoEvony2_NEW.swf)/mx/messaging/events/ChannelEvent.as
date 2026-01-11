// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.events.ChannelEvent

package mx.messaging.events
{
    import flash.events.Event;
    import mx.messaging.Channel;

    public class ChannelEvent extends Event 
    {

        public static const CONNECT:String = "channelConnect";
        public static const DISCONNECT:String = "channelDisconnect";

        public var channel:Channel;
        public var connected:Boolean;
        public var reconnecting:Boolean;
        public var rejected:Boolean;

        public function ChannelEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Channel=null, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.channel = _arg_4;
            this.reconnecting = _arg_5;
            this.rejected = _arg_6;
            this.connected = _arg_7;
        }

        public static function createEvent(_arg_1:String, _arg_2:Channel=null, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false):ChannelEvent
        {
            return (new ChannelEvent(_arg_1, false, false, _arg_2, _arg_3, _arg_4, _arg_5));
        }


        override public function toString():String
        {
            return (formatToString("ChannelEvent", "channelId", "reconnecting", "rejected", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new ChannelEvent(type, bubbles, cancelable, channel, reconnecting, rejected, connected));
        }

        public function get channelId():String
        {
            if (channel != null)
            {
                return (channel.id);
            };
            return (null);
        }


    }
}//package mx.messaging.events

