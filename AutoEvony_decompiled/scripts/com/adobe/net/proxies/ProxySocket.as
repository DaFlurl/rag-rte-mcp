package com.adobe.net.proxies
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   
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
      
      public function ProxySocket(param1:String = null, param2:int = 0)
      {
         super(param1,param2);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.redirectConnectEvent();
         this.redirectSocketDataEvent();
         this.fail("Cannot connect to proxy");
      }
      
      private function ss5Authenticate() : void
      {
         this.writeByte(1);
         this.writeByte(this.proxyUserName.length);
         this.writeUTFBytes(this.proxyUserName);
         this.writeByte(this.proxyPassword.length);
         this.writeUTFBytes(this.proxyPassword);
         this.flush();
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == Event.CONNECT || param1 == ProgressEvent.SOCKET_DATA || param1 == IOErrorEvent.IO_ERROR)
         {
            this.deferredEventHandlers[param1] = {
               "listener":param2,
               "useCapture":param3,
               "priority":param4,
               "useWeakReference":param5
            };
         }
         else
         {
            super.addEventListener(param1,param2,param3,param4,param5);
         }
      }
      
      private function redirectConnectEvent() : void
      {
         super.removeEventListener(Event.CONNECT,this.onConnect);
         var _loc1_:Object = this.deferredEventHandlers[Event.CONNECT];
         if(_loc1_ != null)
         {
            super.addEventListener(Event.CONNECT,_loc1_.listener,_loc1_.useCapture,_loc1_.priority,_loc1_.useWeakReference);
         }
      }
      
      private function ss5Connect() : void
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
      
      private function acceptResponse(param1:ProgressEvent) : void
      {
         this.redirectSocketDataEvent();
         this.dispatchEvent(new Event(Event.CONNECT));
         if(bytesAvailable > 0)
         {
            this.dispatchEvent(param1);
         }
         this.buffer = null;
      }
      
      private function onConnect(param1:Event) : void
      {
         if(this.proxyProtocol == PROXY_TYPE_HTTP)
         {
            this.writeUTFBytes("CONNECT " + this.host + ":" + this.port + " HTTP/1.1\r\n");
            this.writeUTFBytes("Host: " + this.host + ":" + this.port + "\r\n");
            this.writeUTFBytes("\r\n");
         }
         else if(this.proxyProtocol == PROXY_TYPE_SOCKS4)
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
         else if(this.proxyProtocol == PROXY_TYPE_SOCKS5)
         {
            this.ss5Stage = 0;
            this.writeByte(5);
            if(this.proxyUserName != "")
            {
               this.writeByte(2);
               this.writeByte(0);
               this.writeByte(2);
            }
            else
            {
               this.writeByte(1);
               this.writeByte(0);
            }
         }
         this.flush();
         this.redirectConnectEvent();
      }
      
      private function redirectSocketDataEvent() : void
      {
         super.removeEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         var _loc1_:Object = this.deferredEventHandlers[ProgressEvent.SOCKET_DATA];
         if(_loc1_ != null)
         {
            super.addEventListener(ProgressEvent.SOCKET_DATA,_loc1_.listener,_loc1_.useCapture,_loc1_.priority,_loc1_.useWeakReference);
         }
         super.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         _loc1_ = this.deferredEventHandlers[IOErrorEvent.IO_ERROR];
         if(_loc1_ != null)
         {
            super.addEventListener(IOErrorEvent.IO_ERROR,_loc1_.listener,_loc1_.useCapture,_loc1_.priority,_loc1_.useWeakReference);
         }
      }
      
      private function fail(param1:String) : void
      {
         var _loc2_:ProxyErrorEvent = new ProxyErrorEvent(IOErrorEvent.IO_ERROR);
         _loc2_.text = "Error connecting to the " + this.proxyProtocol + " proxy [" + this.proxyHost + "] on port [" + this.proxyPort + "]: " + param1;
         this.dispatchEvent(_loc2_);
         this.buffer = null;
      }
      
      override public function connect(param1:String, param2:int) : void
      {
         if(this.proxyHost == null)
         {
            this.redirectConnectEvent();
            this.redirectSocketDataEvent();
            super.connect(param1,param2);
         }
         else
         {
            this.host = param1;
            this.port = param2;
            super.addEventListener(Event.CONNECT,this.onConnect);
            super.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
            super.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            super.connect(this.proxyHost,this.proxyPort);
         }
      }
      
      override public function close() : void
      {
         try
         {
            super.close();
         }
         catch(e:Error)
         {
         }
         this.buffer = "";
      }
      
      public function setProxyInfo(param1:String) : String
      {
         var _loc7_:Array = null;
         var _loc2_:RegExp = /(\w+):\/\/((\w+):([^@]*)@)?([^:]+):(\d+)/;
         var _loc3_:Array = param1.match(_loc2_);
         if(!_loc3_ || _loc3_.length != 7)
         {
            _loc7_ = param1.match(/([^:]+):(\d+)/);
            if(!_loc7_ || _loc7_.length != 3)
            {
               return "Incorrect proxy string provided: " + param1;
            }
            _loc3_ = [null,"http",null,null,null,_loc7_[1],_loc7_[2]];
         }
         if((_loc3_[1] = (_loc3_[1] as String).toLowerCase()) != PROXY_TYPE_HTTP && _loc3_[1] != PROXY_TYPE_SOCKS4 && _loc3_[1] != PROXY_TYPE_SOCKS5)
         {
            return "Invalid or unkown proxy protocol specified: " + _loc3_[1];
         }
         if(isNaN(parseInt(_loc3_[6])))
         {
            return "Incorrect proxy port specified: " + _loc3_[6];
         }
         this.proxyProtocol = _loc3_[1];
         this.proxyUserName = _loc3_[3] ? _loc3_[3] : "";
         this.proxyPassword = _loc3_[4] ? _loc3_[4] : "";
         this.proxyHost = _loc3_[5];
         this.proxyPort = _loc3_[6];
         var _loc4_:Object = this.deferredEventHandlers[ProgressEvent.SOCKET_DATA];
         var _loc5_:Object = this.deferredEventHandlers[Event.CONNECT];
         var _loc6_:Object = this.deferredEventHandlers[IOErrorEvent.IO_ERROR];
         if(_loc4_ != null)
         {
            super.removeEventListener(ProgressEvent.SOCKET_DATA,_loc4_.listener,_loc4_.useCapture);
         }
         if(_loc5_ != null)
         {
            super.removeEventListener(Event.CONNECT,_loc5_.listener,_loc5_.useCapture);
         }
         if(_loc6_ != null)
         {
            super.removeEventListener(IOErrorEvent.IO_ERROR,_loc6_.listener,_loc6_.useCapture);
         }
         return null;
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         if(!connected)
         {
            return;
         }
         if(this.proxyProtocol == PROXY_TYPE_HTTP)
         {
            while(bytesAvailable > 0)
            {
               this.buffer += readUTFBytes(1);
               if(this.buffer.search(/\r?\n\r?\n$/) != -1)
               {
                  _loc6_ = this.buffer.substr(this.buffer.indexOf(" ") + 1,3);
                  if(_loc6_.search(/^2/) == -1)
                  {
                     this.fail(this.buffer);
                     break;
                  }
                  this.acceptResponse(param1);
                  break;
               }
            }
         }
         else if(this.proxyProtocol == PROXY_TYPE_SOCKS4)
         {
            if(bytesAvailable < 8)
            {
               return;
            }
            if(this.readByte() != 0)
            {
               this.fail("Badly formed server response.");
               return;
            }
            _loc4_ = this.readByte();
            _loc7_ = this.readShort();
            _loc2_ = this.readShort();
            _loc3_ = this.readShort();
            if(_loc4_ != 90)
            {
               this.fail("Server rejected request.");
            }
            else
            {
               this.acceptResponse(param1);
            }
         }
         else if(this.proxyProtocol == PROXY_TYPE_SOCKS5)
         {
            switch(this.ss5Stage)
            {
               case 0:
                  if(bytesAvailable < 2)
                  {
                     return;
                  }
                  _loc5_ = this.readByte();
                  this.selectedAuthMethod = this.readByte();
                  switch(this.selectedAuthMethod)
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
                  }
                  break;
               case 1:
                  if(bytesAvailable < 2)
                  {
                     return;
                  }
                  _loc5_ = this.readByte();
                  if(this.readByte() != 0)
                  {
                     this.fail("Authentication failed.");
                     return;
                  }
                  this.ss5Connect();
                  this.ss5Stage = 2;
                  break;
               case 2:
                  if(bytesAvailable < 4)
                  {
                     return;
                  }
                  _loc5_ = this.readByte();
                  if(_loc5_ != 5)
                  {
                     this.fail("Badly formed connection request server response (1).");
                     return;
                  }
                  _loc4_ = this.readByte();
                  if(_loc4_ != 0)
                  {
                     this.fail("Server rejected connection request with status: " + _loc4_);
                     return;
                  }
                  _loc8_ = this.readByte();
                  if(_loc8_ != 0)
                  {
                     this.fail("Badly formed connection request server response (2).");
                     return;
                  }
                  this.ss5addrType = this.readByte();
                  this.ss5Stage = 3;
               case 3:
                  switch(this.ss5addrType)
                  {
                     case 1:
                        if(bytesAvailable < 6)
                        {
                           return;
                        }
                        _loc2_ = this.readShort();
                        _loc3_ = this.readShort();
                        _loc7_ = this.readShort();
                        this.acceptResponse(param1);
                        return;
                        break;
                     case 3:
                        if(bytesAvailable < 1)
                        {
                           return;
                        }
                        this.ss5DomainLength = this.readByte();
                        this.ss5Stage = 4;
                        break;
                     case 4:
                        if(bytesAvailable < 18)
                        {
                           return;
                        }
                        _loc10_ = 0;
                        while(_loc10_ < 16)
                        {
                           this.readByte();
                           _loc10_++;
                        }
                        _loc7_ = this.readShort();
                        this.acceptResponse(param1);
                        return;
                  }
               case 4:
                  if(bytesAvailable < this.ss5DomainLength + 2)
                  {
                     return;
                  }
                  _loc9_ = readUTFBytes(this.ss5DomainLength);
                  _loc7_ = this.readShort();
                  this.acceptResponse(param1);
            }
         }
      }
   }
}

