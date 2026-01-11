// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.net.client.ErrorVersionEvent

package com.evony.net.client
{
    import flash.events.Event;

    public class ErrorVersionEvent extends Event 
    {

        public static const ERROR_VERSION:String = "gameClient.errorVersion";

        public var requiredVersion:String;
        public var message:String;

        public function ErrorVersionEvent(_arg_1:String, _arg_2:Object)
        {
            super(_arg_1);
            message = _arg_2.msg;
            trace(("message is : " + message));
            requiredVersion = _arg_2.version;
            trace(("required version is : " + requiredVersion));
        }

    }
}//package com.evony.net.client

