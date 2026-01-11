package org.httpclient.http
{
   import org.httpclient.HttpRequest;
   
   public class Delete extends HttpRequest
   {
      
      public function Delete()
      {
         super("DELETE");
      }
      
      override public function get hasResponseBody() : Boolean
      {
         return true;
      }
      
      override public function get hasRequestBody() : Boolean
      {
         return false;
      }
   }
}

