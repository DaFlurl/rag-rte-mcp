// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.HttpClient

package org.httpclient
{
    import flash.events.EventDispatcher;
    import com.adobe.net.URI;
    import org.httpclient.http.Post;
    import org.httpclient.http.Delete;
    import org.httpclient.http.Put;
    import org.httpclient.events.HttpListener;
    import org.httpclient.http.multipart.Multipart;
    import org.httpclient.http.Head;
    import flash.errors.IllegalOperationError;
    import org.httpclient.http.Get;

    public class HttpClient extends EventDispatcher 
    {

        private var _timeout:int;
        private var _proxy:URI;
        private var _socket:HttpSocket;
        private var _listener:*;

        public function HttpClient(_arg_1:URI=null, _arg_2:int=60000)
        {
            this._timeout = _arg_2;
            this._proxy = _arg_1;
        }

        public function post(_arg_1:URI, _arg_2:*, _arg_3:String=null):void
        {
            var _local_4:Post = new Post();
            _local_4.body = _arg_2;
            _local_4.contentType = _arg_3;
            this.request(_arg_1, _local_4);
        }

        public function get timeout():int
        {
            return (this._timeout);
        }

        public function set timeout(_arg_1:int):void
        {
            this._timeout = _arg_1;
        }

        public function del(_arg_1:URI):void
        {
            this.request(_arg_1, new Delete());
        }

        public function put(_arg_1:URI, _arg_2:*, _arg_3:String=null):void
        {
            var _local_4:Put = new Put();
            _local_4.body = _arg_2;
            _local_4.contentType = _arg_3;
            this.request(_arg_1, _local_4);
        }

        public function set listener(_arg_1:HttpListener):void
        {
            if (this._listener)
            {
                this._listener.unregister(this);
            };
            this._listener = _arg_1;
            if (this._listener)
            {
                this._listener.register(this);
            };
        }

        public function postMultipart(_arg_1:URI, _arg_2:Multipart):void
        {
            var _local_3:Post = new Post();
            _local_3.setMultipart(_arg_2);
            this.request(_arg_1, _local_3);
        }

        public function head(_arg_1:URI):void
        {
            this.request(_arg_1, new Head());
        }

        public function postFormData(_arg_1:URI, _arg_2:Array):void
        {
            this.request(_arg_1, new Post(_arg_2));
        }

        public function upload(_arg_1:URI, _arg_2:*, _arg_3:String="PUT"):void
        {
            var _local_4:HttpRequest;
            if (_arg_3 == "PUT")
            {
                _local_4 = new Put();
            }
            else
            {
                if (_arg_3 == "POST")
                {
                    _local_4 = new Post();
                }
                else
                {
                    throw (new ArgumentError("Method must be PUT or POST"));
                };
            };
            throw (new IllegalOperationError("Not supported, comment out the line above"));
        }

        public function get listener():HttpListener
        {
            if (!this._listener)
            {
                this._listener = new HttpListener();
                this._listener.register(this);
            };
            return (this._listener);
        }

        public function putFormData(_arg_1:URI, _arg_2:Array):void
        {
            var _local_3:Put = new Put();
            _local_3.setFormData(_arg_2);
            this.request(_arg_1, _local_3);
        }

        public function request(_arg_1:URI, _arg_2:HttpRequest, _arg_3:int=-1, _arg_4:HttpListener=null):void
        {
            if (_arg_3 == -1)
            {
                _arg_3 = this._timeout;
            };
            var _local_5:EventDispatcher;
            if (_arg_4 != null)
            {
                _local_5 = _arg_4.register();
            }
            else
            {
                _local_5 = this;
            };
            this._socket = new HttpSocket(_local_5, _arg_3, this._proxy);
            this._socket.request(_arg_1, _arg_2);
        }

        public function close():void
        {
            this.cancel();
            this.listener = null;
        }

        public function cancel():void
        {
            this._socket.close();
        }

        public function get(_arg_1:URI, _arg_2:HttpListener=null):void
        {
            this.request(_arg_1, new Get(), -1, _arg_2);
        }


    }
}//package org.httpclient

