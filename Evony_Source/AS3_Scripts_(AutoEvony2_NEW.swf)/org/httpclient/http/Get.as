// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.http.Get

package org.httpclient.http
{
    import org.httpclient.HttpRequest;

    public class Get extends HttpRequest 
    {

        public function Get()
        {
            super("GET");
        }

        override public function get hasResponseBody():Boolean
        {
            return (true);
        }

        override public function get hasRequestBody():Boolean
        {
            return (false);
        }


    }
}//package org.httpclient.http

