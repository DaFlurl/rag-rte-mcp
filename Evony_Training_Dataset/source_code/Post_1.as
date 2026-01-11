package org.httpclient.http
{
   import org.httpclient.HttpRequest;
   
   public class Post extends HttpRequest
   {
      public function Post(param1:Array = null)
      {
         super("POST");
         if(param1)
         {
            setFormData(param1);
         }
      }
      
      override public function get hasResponseBody() : Boolean
      {
         return true;
      }
      
      override public function get hasRequestBody() : Boolean
      {
         return true;
      }
   }
}

