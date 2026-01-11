// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.http.Put

package org.httpclient.http
{
    import org.httpclient.HttpRequest;

    public class Put extends HttpRequest 
    {

        public function Put()
        {
            super("PUT");
        }

        override public function get hasResponseBody():Boolean
        {
            return (true);
        }

        override public function get hasRequestBody():Boolean
        {
            return (true);
        }


    }
}//package org.httpclient.http

