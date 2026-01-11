// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.events.HttpRequestEvent

package org.httpclient.events
{
    import flash.events.Event;
    import org.httpclient.HttpRequest;

    public class HttpRequestEvent extends Event 
    {

        public static const CONNECT:String = "requestConnect";
        public static const COMPLETE:String = "requestComplete";

        private var _request:HttpRequest;
        private var _header:String;

        public function HttpRequestEvent(_arg_1:HttpRequest, _arg_2:String, _arg_3:String="requestComplete", _arg_4:Boolean=false, _arg_5:Boolean=false):void
        {
            super(_arg_3, _arg_4, _arg_5);
            this._request = _arg_1;
            this._header = _arg_2;
        }

        public function get header():String
        {
            return (this._header);
        }

        public function get request():HttpRequest
        {
            return (this._request);
        }


    }
}//package org.httpclient.events

