// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.events.HttpErrorEvent

package org.httpclient.events
{
    import flash.events.ErrorEvent;

    public class HttpErrorEvent extends ErrorEvent 
    {

        public static const ERROR:String = "httpError";
        public static const TIMEOUT_ERROR:String = "httpTimeoutError";

        public function HttpErrorEvent(_arg_1:String="httpError", _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String="", _arg_5:int=0):void
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

    }
}//package org.httpclient.events

