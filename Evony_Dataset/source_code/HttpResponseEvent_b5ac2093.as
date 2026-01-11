// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.events.HttpResponseEvent

package org.httpclient.events
{
    import flash.events.Event;
    import org.httpclient.HttpResponse;

    public class HttpResponseEvent extends Event 
    {

        public static const COMPLETE:String = "responseComplete";

        private var _response:HttpResponse;

        public function HttpResponseEvent(_arg_1:HttpResponse, _arg_2:String="responseComplete", _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            super(_arg_2, _arg_3, _arg_4);
            this._response = _arg_1;
        }

        public function get response():HttpResponse
        {
            return (this._response);
        }


    }
}//package org.httpclient.events

