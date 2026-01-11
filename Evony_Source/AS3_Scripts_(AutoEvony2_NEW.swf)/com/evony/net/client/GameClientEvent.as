// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.net.client.GameClientEvent

package com.evony.net.client
{
    import flash.events.Event;
    import flash.events.*;

    public class GameClientEvent extends Event 
    {

        public static const ON_CONNECTION:String = "gameClient.onConnection";
        public static const ON_CONNECTION_LOST:String = "gameClient.onConnectionLost";
        public static const ON_EXTENSION_RESPONSE:String = "gameClient.onExtensionResponse";
        public static const ON_ERROR:String = "gameClient.onError";

        public var data:Object;
        public var cmd:String;

        public function GameClientEvent(_arg_1:String, _arg_2:Object=null)
        {
            super(_arg_1);
            if (_arg_2)
            {
                if (_arg_2.data)
                {
                    this.data = _arg_2.data;
                };
                if (_arg_2.cmd)
                {
                    this.cmd = _arg_2.cmd;
                };
                if (Version.isTraceOn())
                {
                    trace(("dispatch Event:" + this.cmd));
                };
            };
        }

    }
}//package com.evony.net.client

