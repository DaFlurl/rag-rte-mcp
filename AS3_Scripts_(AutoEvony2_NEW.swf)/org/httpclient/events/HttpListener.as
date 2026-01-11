// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.events.HttpListener

package org.httpclient.events
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.ErrorEvent;

    public class HttpListener extends EventDispatcher 
    {

        public var onClose:Function = null;
        public var onData:Function = null;
        public var onConnect:Function = null;
        public var onError:Function = null;
        public var onStatus:Function = null;
        public var onRequest:Function = null;
        public var onComplete:Function = null;

        public function HttpListener(_arg_1:Object=null)
        {
            if (_arg_1)
            {
                if (_arg_1["onClose"] != undefined)
                {
                    this.onClose = _arg_1.onClose;
                };
                if (_arg_1["onComplete"] != undefined)
                {
                    this.onComplete = _arg_1.onComplete;
                };
                if (_arg_1["onConnect"] != undefined)
                {
                    this.onConnect = _arg_1.onConnect;
                };
                if (_arg_1["onData"] != undefined)
                {
                    this.onData = _arg_1.onData;
                };
                if (_arg_1["onError"] != undefined)
                {
                    this.onError = _arg_1.onError;
                };
                if (_arg_1["onStatus"] != undefined)
                {
                    this.onStatus = _arg_1.onStatus;
                };
                if (_arg_1["onRequest"] != undefined)
                {
                    this.onRequest = _arg_1.onRequest;
                };
            };
        }

        public function register(_arg_1:EventDispatcher=null):HttpListener
        {
            if (_arg_1 == null)
            {
                _arg_1 = this;
            };
            _arg_1.addEventListener(Event.CLOSE, this.onInternalClose);
            _arg_1.addEventListener(HttpResponseEvent.COMPLETE, this.onInternalComplete);
            _arg_1.addEventListener(HttpRequestEvent.CONNECT, this.onInternalConnect);
            _arg_1.addEventListener(HttpDataEvent.DATA, this.onInternalData);
            _arg_1.addEventListener(HttpErrorEvent.ERROR, this.onInternalError);
            _arg_1.addEventListener(HttpErrorEvent.TIMEOUT_ERROR, this.onInternalError);
            _arg_1.addEventListener(HttpStatusEvent.STATUS, this.onInternalStatus);
            _arg_1.addEventListener(HttpRequestEvent.COMPLETE, this.onInternalRequest);
            _arg_1.addEventListener(IOErrorEvent.IO_ERROR, this.onInternalError);
            _arg_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onInternalError);
            return (this);
        }

        protected function onInternalData(_arg_1:HttpDataEvent):void
        {
            if (this.onData != null)
            {
                this.onData(_arg_1);
            };
        }

        protected function onInternalError(_arg_1:ErrorEvent):void
        {
            if (this.onError != null)
            {
                this.onError(_arg_1);
            };
        }

        protected function onInternalConnect(_arg_1:HttpRequestEvent):void
        {
            if (this.onConnect != null)
            {
                this.onConnect(_arg_1);
            };
        }

        protected function onInternalClose(_arg_1:Event):void
        {
            if (this.onClose != null)
            {
                this.onClose(_arg_1);
            };
        }

        protected function onInternalComplete(_arg_1:HttpResponseEvent):void
        {
            if (this.onComplete != null)
            {
                this.onComplete(_arg_1);
            };
        }

        protected function onInternalRequest(_arg_1:HttpRequestEvent):void
        {
            if (this.onRequest != null)
            {
                this.onRequest(_arg_1);
            };
        }

        public function unregister(_arg_1:EventDispatcher=null):HttpListener
        {
            if (_arg_1 == null)
            {
                _arg_1 = this;
            };
            _arg_1.removeEventListener(Event.CLOSE, this.onInternalClose);
            _arg_1.removeEventListener(HttpResponseEvent.COMPLETE, this.onInternalComplete);
            _arg_1.removeEventListener(HttpRequestEvent.CONNECT, this.onInternalConnect);
            _arg_1.removeEventListener(HttpDataEvent.DATA, this.onInternalData);
            _arg_1.removeEventListener(HttpErrorEvent.ERROR, this.onInternalError);
            _arg_1.removeEventListener(HttpErrorEvent.TIMEOUT_ERROR, this.onInternalError);
            _arg_1.removeEventListener(HttpStatusEvent.STATUS, this.onInternalStatus);
            _arg_1.removeEventListener(HttpRequestEvent.COMPLETE, this.onInternalRequest);
            _arg_1.removeEventListener(IOErrorEvent.IO_ERROR, this.onInternalError);
            _arg_1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onInternalError);
            return (this);
        }

        protected function onInternalStatus(_arg_1:HttpStatusEvent):void
        {
            if (this.onStatus != null)
            {
                this.onStatus(_arg_1);
            };
        }


    }
}//package org.httpclient.events

