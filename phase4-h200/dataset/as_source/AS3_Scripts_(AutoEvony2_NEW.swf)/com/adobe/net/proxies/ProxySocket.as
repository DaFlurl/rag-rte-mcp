// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.adobe.net.proxies.ProxySocket

package com.adobe.net.proxies
{
    import flash.net.Socket;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.Event;

    public class ProxySocket extends Socket 
    {

        public static const PROXY_TYPE_SOCKS4:String = "ss4";
        public static const PROXY_TYPE_SOCKS5:String = "ss5";
        public static const PROXY_TYPE_HTTP:String = "http";

        private var buffer:String = "";
        private var port:int = 0;
        private var proxyUserName:String = "";
        private var deferredEventHandlers:Object = new Object();
        private var proxyPort:int = 0;
        private var ss5addrType:int;
        private var selectedAuthMethod:int = -1;
        private var proxyProtocol:String = null;
        private var host:String = null;
        private var proxyPassword:String = "";
        private var ss5Stage:int;
        private var proxyHost:String = null;
        private var ss5DomainLength:int;

        public function ProxySocket(_arg_1:String=null, _arg_2:int=0)
        {
            super(_arg_1, _arg_2);
        }

        private function onIOError(_arg_1:IOErrorEvent):void
        {
            this.redirectConnectEvent();
            this.redirectSocketDataEvent();
            this.fail("Cannot connect to proxy");
        }

        private function ss5Authenticate():void
        {
            this.writeByte(1);
            this.writeByte(this.proxyUserName.length);
            this.writeUTFBytes(this.proxyUserName);
            this.writeByte(this.proxyPassword.length);
            this.writeUTFBytes(this.proxyPassword);
            this.flush();
        }

        override public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            if ((((_arg_1 == Event.CONNECT) || (_arg_1 == ProgressEvent.SOCKET_DATA)) || (_arg_1 == IOErrorEvent.IO_ERROR)))
            {
                this.deferredEventHandlers[_arg_1] = {
                    "listener":_arg_2,
                    "useCapture":_arg_3,
                    "priority":_arg_4,
                    "useWeakReference":_arg_5
                };
            }
            else
            {
                super.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }

        private function redirectConnectEvent():void
        {
            super.removeEventListener(Event.CONNECT, this.onConnect);
            var _local_1:Object = this.deferredEventHandlers[Event.CONNECT];
            if (_local_1 != null)
            {
                super.addEventListener(Event.CONNECT, _local_1.listener, _local_1.useCapture, _local_1.priority, _local_1.useWeakReference);
            };
        }

        private function ss5Connect():void
        {
            this.writeByte(5);
            this.writeByte(1);
            this.writeByte(0);
            this.writeByte(3);
            this.writeByte(this.host.length);
            this.writeUTFBytes(this.host);
            this.writeShort(this.port);
            this.flush();
        }

        private function acceptResponse(_arg_1:ProgressEvent):void
        {
            this.redirectSocketDataEvent();
            this.dispatchEvent(new Event(Event.CONNECT));
            if (bytesAvailable > 0)
            {
                this.dispatchEvent(_arg_1);
            };
            this.buffer = null;
        }

        private function onConnect(_arg_1:Event):void
        {
            if (this.proxyProtocol == PROXY_TYPE_HTTP)
            {
                this.writeUTFBytes((((("CONNECT " + this.host) + ":") + this.port) + " HTTP/1.1\r\n"));
                this.writeUTFBytes((((("Host: " + this.host) + ":") + this.port) + "\r\n"));
                this.writeUTFBytes("\r\n");
            }
            else
            {
                if (this.proxyProtocol == PROXY_TYPE_SOCKS4)
                {
                    this.writeByte(4);
                    this.writeByte(1);
                    this.writeShort(this.port);
                    this.writeInt(1);
                    this.writeUTFBytes(this.proxyUserName);
                    this.writeByte(0);
                    this.writeUTFBytes(this.proxyHost);
                    this.writeByte(0);
                }
                else
                {
                    if (this.proxyProtocol == PROXY_TYPE_SOCKS5)
                    {
                        this.ss5Stage = 0;
                        this.writeByte(5);
                        if (this.proxyUserName != "")
                        {
                            this.writeByte(2);
                            this.writeByte(0);
                            this.writeByte(2);
                        }
                        else
                        {
                            this.writeByte(1);
                            this.writeByte(0);
                        };
                    };
                };
            };
            this.flush();
            this.redirectConnectEvent();
        }

        private function redirectSocketDataEvent():void
        {
            super.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            var _local_1:Object = this.deferredEventHandlers[ProgressEvent.SOCKET_DATA];
            if (_local_1 != null)
            {
                super.addEventListener(ProgressEvent.SOCKET_DATA, _local_1.listener, _local_1.useCapture, _local_1.priority, _local_1.useWeakReference);
            };
            super.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            _local_1 = this.deferredEventHandlers[IOErrorEvent.IO_ERROR];
            if (_local_1 != null)
            {
                super.addEventListener(IOErrorEvent.IO_ERROR, _local_1.listener, _local_1.useCapture, _local_1.priority, _local_1.useWeakReference);
            };
        }

        private function fail(_arg_1:String):void
        {
            var _local_2:ProxyErrorEvent = new ProxyErrorEvent(IOErrorEvent.IO_ERROR);
            _local_2.text = ((((((("Error connecting to the " + this.proxyProtocol) + " proxy [") + this.proxyHost) + "] on port [") + this.proxyPort) + "]: ") + _arg_1);
            this.dispatchEvent(_local_2);
            this.buffer = null;
        }

        override public function connect(_arg_1:String, _arg_2:int):void
        {
            if (this.proxyHost == null)
            {
                this.redirectConnectEvent();
                this.redirectSocketDataEvent();
                super.connect(_arg_1, _arg_2);
            }
            else
            {
                this.host = _arg_1;
                this.port = _arg_2;
                super.addEventListener(Event.CONNECT, this.onConnect);
                super.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
                super.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                super.connect(this.proxyHost, this.proxyPort);
            };
        }

        override public function close():void
        {
            try
            {
                super.close();
            }
            catch(e:Error)
            {
            };
            this.buffer = "";
        }

        public function setProxyInfo(_arg_1:String):String
        {
            var _local_7:Array;
            var _local_2:RegExp = /(\w+):\/\/((\w+):([^@]*)@)?([^:]+):(\d+)/;
            var _local_3:Array = _arg_1.match(_local_2);
            if (((!(_local_3)) || (!(_local_3.length == 7))))
            {
                _local_7 = _arg_1.match(/([^:]+):(\d+)/);
                if (((!(_local_7)) || (!(_local_7.length == 3))))
                {
                    return ("Incorrect proxy string provided: " + _arg_1);
                };
                _local_3 = [null, "http", null, null, null, _local_7[1], _local_7[2]];
            };
            if ((((!((_local_3[1] = (_local_3[1] as String).toLowerCase()) == PROXY_TYPE_HTTP)) && (!(_local_3[1] == PROXY_TYPE_SOCKS4))) && (!(_local_3[1] == PROXY_TYPE_SOCKS5))))
            {
                return ("Invalid or unkown proxy protocol specified: " + _local_3[1]);
            };
            if (isNaN(parseInt(_local_3[6])))
            {
                return ("Incorrect proxy port specified: " + _local_3[6]);
            };
            this.proxyProtocol = _local_3[1];
            this.proxyUserName = ((_local_3[3]) ? _local_3[3] : "");
            this.proxyPassword = ((_local_3[4]) ? _local_3[4] : "");
            this.proxyHost = _local_3[5];
            this.proxyPort = _local_3[6];
            var _local_4:Object = this.deferredEventHandlers[ProgressEvent.SOCKET_DATA];
            var _local_5:Object = this.deferredEventHandlers[Event.CONNECT];
            var _local_6:Object = this.deferredEventHandlers[IOErrorEvent.IO_ERROR];
            if (_local_4 != null)
            {
                super.removeEventListener(ProgressEvent.SOCKET_DATA, _local_4.listener, _local_4.useCapture);
            };
            if (_local_5 != null)
            {
                super.removeEventListener(Event.CONNECT, _local_5.listener, _local_5.useCapture);
            };
            if (_local_6 != null)
            {
                super.removeEventListener(IOErrorEvent.IO_ERROR, _local_6.listener, _local_6.useCapture);
            };
            return (null);
        }

        private function onSocketData(_arg_1:ProgressEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:int;
            var _local_8:int;
            var _local_9:String;
            var _local_10:int;
            if (!connected)
            {
                return;
            };
            if (this.proxyProtocol == PROXY_TYPE_HTTP)
            {
                while (bytesAvailable > 0)
                {
                    this.buffer = (this.buffer + readUTFBytes(1));
                    if (this.buffer.search(/\r?\n\r?\n$/) != -1)
                    {
                        _local_6 = this.buffer.substr((this.buffer.indexOf(" ") + 1), 3);
                        if (_local_6.search(/^2/) == -1)
                        {
                            this.fail(this.buffer);
                        }
                        else
                        {
                            this.acceptResponse(_arg_1);
                        };
                        break;
                    };
                };
            }
            else
            {
                if (this.proxyProtocol == PROXY_TYPE_SOCKS4)
                {
                    if (bytesAvailable < 8)
                    {
                        return;
                    };
                    if (this.readByte() != 0)
                    {
                        this.fail("Badly formed server response.");
                        return;
                    };
                    _local_4 = this.readByte();
                    _local_7 = this.readShort();
                    _local_2 = this.readShort();
                    _local_3 = this.readShort();
                    if (_local_4 != 90)
                    {
                        this.fail("Server rejected request.");
                    }
                    else
                    {
                        this.acceptResponse(_arg_1);
                    };
                }
                else
                {
                    if (this.proxyProtocol == PROXY_TYPE_SOCKS5)
                    {
                        switch (this.ss5Stage)
                        {
                            case 0:
                                if (bytesAvailable < 2)
                                {
                                    return;
                                };
                                _local_5 = this.readByte();
                                this.selectedAuthMethod = this.readByte();
                                switch (this.selectedAuthMethod)
                                {
                                    case 0:
                                        this.ss5Connect();
                                        this.ss5Stage = 2;
                                        return;
                                    case 2:
                                        this.ss5Authenticate();
                                        this.ss5Stage = 1;
                                        return;
                                    default:
                                        this.fail("Cannot agree on an authentication method.");
                                        return;
                                };
                            case 1:
                                if (bytesAvailable < 2)
                                {
                                    return;
                                };
                                _local_5 = this.readByte();
                                if (this.readByte() != 0)
                                {
                                    this.fail("Authentication failed.");
                                    return;
                                };
                                this.ss5Connect();
                                this.ss5Stage = 2;
                                return;
                            case 2:
                                if (bytesAvailable < 4)
                                {
                                    return;
                                };
                                _local_5 = this.readByte();
                                if (_local_5 != 5)
                                {
                                    this.fail("Badly formed connection request server response (1).");
                                    return;
                                };
                                _local_4 = this.readByte();
                                if (_local_4 != 0)
                                {
                                    this.fail(("Server rejected connection request with status: " + _local_4));
                                    return;
                                };
                                _local_8 = this.readByte();
                                if (_local_8 != 0)
                                {
                                    this.fail("Badly formed connection request server response (2).");
                                    return;
                                };
                                this.ss5addrType = this.readByte();
                                this.ss5Stage = 3;
                            case 3:
                                switch (this.ss5addrType)
                                {
                                    case 1:
                                        if (bytesAvailable < 6)
                                        {
                                            return;
                                        };
                                        _local_2 = this.readShort();
                                        _local_3 = this.readShort();
                                        _local_7 = this.readShort();
                                        this.acceptResponse(_arg_1);
                                        return;
                                    case 3:
                                        if (bytesAvailable < 1)
                                        {
                                            return;
                                        };
                                        this.ss5DomainLength = this.readByte();
                                        this.ss5Stage = 4;
                                        break;
                                    case 4:
                                        if (bytesAvailable < 18)
                                        {
                                            return;
                                        };
                                        _local_10 = 0;
                                        while (_local_10 < 16)
                                        {
                                            this.readByte();
                                            _local_10++;
                                        };
                                        _local_7 = this.readShort();
                                        this.acceptResponse(_arg_1);
                                        return;
                                };
                            case 4:
                                if (bytesAvailable < (this.ss5DomainLength + 2))
                                {
                                    return;
                                };
                                _local_9 = readUTFBytes(this.ss5DomainLength);
                                _local_7 = this.readShort();
                                this.acceptResponse(_arg_1);
                                return;
                        };
                    };
                };
            };
        }


    }
}//package com.adobe.net.proxies

