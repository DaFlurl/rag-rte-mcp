// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.adobe.net.proxies.ProxyErrorEvent

package com.adobe.net.proxies
{
    import flash.events.IOErrorEvent;
    import flash.events.Event;

    public class ProxyErrorEvent extends IOErrorEvent 
    {

        public function ProxyErrorEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function toString():String
        {
            return (formatToString("ProxyErrorEvent", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new ProxyErrorEvent(type, bubbles, cancelable));
        }


    }
}//package com.adobe.net.proxies

