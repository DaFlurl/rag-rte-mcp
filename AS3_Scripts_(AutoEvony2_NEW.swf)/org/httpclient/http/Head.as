// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.http.Head

package org.httpclient.http
{
    import org.httpclient.HttpRequest;

    public class Head extends HttpRequest 
    {

        public function Head()
        {
            super("HEAD");
        }

        override public function get hasResponseBody():Boolean
        {
            return (false);
        }

        override public function get hasRequestBody():Boolean
        {
            return (false);
        }


    }
}//package org.httpclient.http

