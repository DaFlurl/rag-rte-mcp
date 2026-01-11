// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.events.HttpStatusEvent

package org.httpclient.events
{
    import flash.events.Event;
    import org.httpclient.HttpResponse;
    import org.httpclient.HttpHeader;

    public class HttpStatusEvent extends Event 
    {

        public static const STATUS:String = "httpStatus";

        private var _response:HttpResponse;

        public function HttpStatusEvent(_arg_1:HttpResponse, _arg_2:String="httpStatus", _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            super(_arg_2, _arg_3, _arg_4);
            this._response = _arg_1;
        }

        public function get response():HttpResponse
        {
            return (this._response);
        }

        public function get code():String
        {
            return (this._response.code);
        }

        public function get header():HttpHeader
        {
            return (this._response.header);
        }


    }
}//package org.httpclient.events

