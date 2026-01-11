// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.net.client.KickoutEvent

package com.evony.net.client
{
    import flash.events.Event;

    public class KickoutEvent extends Event 
    {

        public static const KICKOUT:String = "gameClient.kickout";

        public var message:String;

        public function KickoutEvent(_arg_1:String, _arg_2:Object)
        {
            super(_arg_1);
            message = _arg_2.msg;
            trace(("message is : " + message));
        }

    }
}//package com.evony.net.client

