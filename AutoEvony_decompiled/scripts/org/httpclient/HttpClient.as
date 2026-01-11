package org.httpclient
{
   import com.adobe.net.URI;
   import flash.errors.IllegalOperationError;
   import flash.events.EventDispatcher;
   import org.httpclient.events.HttpListener;
   import org.httpclient.http.Delete;
   import org.httpclient.http.Get;
   import org.httpclient.http.Head;
   import org.httpclient.http.Post;
   import org.httpclient.http.Put;
   import org.httpclient.http.multipart.Multipart;
   
   public class HttpClient extends EventDispatcher
   {
      
      private var _timeout:int;
      
      private var _proxy:URI;
      
      private var _socket:HttpSocket;
      
      private var _listener:*;
      
      public function HttpClient(param1:URI = null, param2:int = 60000)
      {
         super();
         this._timeout = param2;
         this._proxy = param1;
      }
      
      public function post(param1:URI, param2:*, param3:String = null) : void
      {
         var _loc4_:Post = new Post();
         _loc4_.body = param2;
         _loc4_.contentType = param3;
         this.request(param1,_loc4_);
      }
      
      public function get timeout() : int
      {
         return this._timeout;
      }
      
      public function set timeout(param1:int) : void
      {
         this._timeout = param1;
      }
      
      public function del(param1:URI) : void
      {
         this.request(param1,new Delete());
      }
      
      public function put(param1:URI, param2:*, param3:String = null) : void
      {
         var _loc4_:Put = new Put();
         _loc4_.body = param2;
         _loc4_.contentType = param3;
         this.request(param1,_loc4_);
      }
      
      public function set listener(param1:HttpListener) : void
      {
         if(this._listener)
         {
            this._listener.unregister(this);
         }
         this._listener = param1;
         if(this._listener)
         {
            this._listener.register(this);
         }
      }
      
      public function postMultipart(param1:URI, param2:Multipart) : void
      {
         var _loc3_:Post = new Post();
         _loc3_.setMultipart(param2);
         this.request(param1,_loc3_);
      }
      
      public function head(param1:URI) : void
      {
         this.request(param1,new Head());
      }
      
      public function postFormData(param1:URI, param2:Array) : void
      {
         this.request(param1,new Post(param2));
      }
      
      public function upload(param1:URI, param2:*, param3:String = "PUT") : void
      {
         var _loc4_:HttpRequest = null;
         if(param3 == "PUT")
         {
            _loc4_ = new Put();
         }
         else
         {
            if(param3 != "POST")
            {
               throw new ArgumentError("Method must be PUT or POST");
            }
            _loc4_ = new Post();
         }
         throw new IllegalOperationError("Not supported, comment out the line above");
      }
      
      public function get listener() : HttpListener
      {
         if(!this._listener)
         {
            this._listener = new HttpListener();
            this._listener.register(this);
         }
         return this._listener;
      }
      
      public function putFormData(param1:URI, param2:Array) : void
      {
         var _loc3_:Put = new Put();
         _loc3_.setFormData(param2);
         this.request(param1,_loc3_);
      }
      
      public function request(param1:URI, param2:HttpRequest, param3:int = -1, param4:HttpListener = null) : void
      {
         if(param3 == -1)
         {
            param3 = this._timeout;
         }
         var _loc5_:EventDispatcher = null;
         if(param4 != null)
         {
            _loc5_ = param4.register();
         }
         else
         {
            _loc5_ = this;
         }
         this._socket = new HttpSocket(_loc5_,param3,this._proxy);
         this._socket.request(param1,param2);
      }
      
      public function close() : void
      {
         this.cancel();
         this.listener = null;
      }
      
      public function cancel() : void
      {
         this._socket.close();
      }
      
      public function get(param1:URI, param2:HttpListener = null) : void
      {
         this.request(param1,new Get(),-1,param2);
      }
   }
}

