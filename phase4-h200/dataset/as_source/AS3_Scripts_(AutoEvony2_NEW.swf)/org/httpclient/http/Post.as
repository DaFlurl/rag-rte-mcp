// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.http.Post

package org.httpclient.http
{
    import org.httpclient.HttpRequest;

    public class Post extends HttpRequest 
    {

        public function Post(_arg_1:Array=null)
        {
            super("POST");
            if (_arg_1)
            {
                setFormData(_arg_1);
            };
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

