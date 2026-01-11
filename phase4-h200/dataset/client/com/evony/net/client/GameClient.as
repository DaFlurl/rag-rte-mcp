// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.net.client.GameClient

package com.evony.net.client
{
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;

    public class GameClient extends EventDispatcher 
    {

        private static const VERSION_COMMAND:String = "gameClient.version";
        private static const MAX_PACKAGE_LEN:int = 0x100000;

        private var serverIp:String;
        private var version:String = null;
        private var mainBuffer:ByteArray;
        private var amfObj:Object;
        private var processedCount:int;
        private var serverPort:int;
        private var lock:Boolean = false;
        private var readed:int = 0;
        private var dataLength:int = 0;
        private var socket:Socket;

        public function GameClient()
        {
            socket = new Socket();
            socket.addEventListener(Event.CONNECT, connectionHandler);
            socket.addEventListener(Event.CLOSE, disconnectionHandler);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, incomingDataHandler);
            socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorHandler2);
        }

        public function getServerIp():String
        {
            return (serverIp);
        }

        public function isConnectioned():Boolean
        {
            return (socket.connected);
        }

        private function incomingDataHandler(e:ProgressEvent):void
        {
            var needRead:int;
            var tempBuffer:ByteArray;
            if (lock)
            {
                throw (new Error(((((((("Socket.bytesAvailable=" + socket.bytesAvailable) + "\tprocessedCount=") + processedCount) + "\treaded=") + readed) + " dataLength:") + (dataLength & 0x7FFFFFFF))));
            };
            lock = true;
            while (socket.bytesAvailable > 0)
            {
                if (dataLength == 0)
                {
                    dataLength = socket.readInt();
                    readed = 0;
                    if ((((dataLength & 0x7FFFFFFF) > MAX_PACKAGE_LEN) || ((dataLength & 0x7FFFFFFF) < 0)))
                    {
                        throw (new Error(("The package size is illegal. len=" + dataLength)));
                    };
                    mainBuffer = new ByteArray();
                    processedCount = 0;
                };
                needRead = ((dataLength & 0x7FFFFFFF) - readed);
                if (needRead > this.socket.bytesAvailable)
                {
                    needRead = this.socket.bytesAvailable;
                };
                if (needRead < 0)
                {
                    throw (new Error(((((((("The package available size is illegal .lenNeedRead=" + needRead) + "\tremain=") + socket.bytesAvailable) + "\tprocessedCount=") + processedCount) + "\treaded=") + readed)));
                };
                try
                {
                    this.readed = (this.readed + needRead);
                    tempBuffer = new ByteArray();
                    socket.readBytes(tempBuffer, 0, needRead);
                    mainBuffer.writeBytes(tempBuffer);
                    processedCount++;
                }
                catch(err:Error)
                {
                    dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
                };
                if (readed == (dataLength & 0x7FFFFFFF))
                {
                    this.lock = false;
                    mainBuffer.position = 0;
                    if ((dataLength & 0x80000000))
                    {
                        mainBuffer.uncompress();
                        trace(((("mainBuffer " + mainBuffer.length) + "read len : ") + readed));
                        mainBuffer.position = 0;
                    };
                    amfObj = mainBuffer.readObject();
                    mainBuffer = null;
                    dataLength = 0;
                    processedCount = 0;
                    readed = 0;
                    if (!amfObj)
                    {
                        dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
                        return;
                    };
                    if (checkCommand(amfObj))
                    {
                        return;
                    };
                    dispatchEvent(new GameClientEvent(GameClientEvent.ON_EXTENSION_RESPONSE, amfObj));
                };
            };
            this.lock = false;
        }

        private function connectionHandler(_arg_1:Event):void
        {
            trace("socket connection event");
            sendMessage(VERSION_COMMAND, version);
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_CONNECTION));
        }

        private function ioErrorHandler2(_arg_1:SecurityErrorEvent):void
        {
            trace(("the network connection has IOError : " + _arg_1.text));
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
        }

        public function setVersion(_arg_1:String):void
        {
            this.version = _arg_1;
        }

        public function getServerPort():int
        {
            return (serverPort);
        }

        public function connection(_arg_1:String, _arg_2:int):void
        {
            if (!version)
            {
                throw (new RequiredVersionError("the GameClient required a version."));
            };
            trace(("connect the server : " + _arg_1));
            trace(("1 connect the server : " + _arg_1));
            socket.connect(_arg_1, _arg_2);
            dataLength = 0;
        }

        public function sendMessage(_arg_1:String, _arg_2:Object):void
        {
            if (!isConnectioned())
            {
                throw (new NotConnectionedError("the connection is not ready, yet."));
            };
            var _local_3:Object = new Object();
            _local_3.cmd = _arg_1;
            _local_3.data = _arg_2;
            var _local_4:ByteArray = new ByteArray();
            _local_4.writeObject(_local_3);
            socket.writeInt(_local_4.length);
            socket.writeBytes(_local_4);
            socket.flush();
        }

        private function checkCommand(_arg_1:Object):Boolean
        {
            trace(("package id : " + _arg_1.data.packageId));
            switch (_arg_1.cmd)
            {
                case KickoutEvent.KICKOUT:
                    dispatchEvent(new KickoutEvent(KickoutEvent.KICKOUT, _arg_1.data));
                    disconnection();
                    return (true);
                case ErrorVersionEvent.ERROR_VERSION:
                    dispatchEvent(new ErrorVersionEvent(ErrorVersionEvent.ERROR_VERSION, _arg_1.data));
                    disconnection();
                    return (true);
            };
            return (false);
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            trace(("the network connection has IOError : " + _arg_1.text));
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
        }

        public function disconnection():void
        {
            try
            {
                socket.close();
            }
            catch(e:Error)
            {
                trace(e.message);
            };
            disconnectionHandler(new Event(Event.CLOSE));
        }

        private function disconnectionHandler(_arg_1:Event):void
        {
            trace("socket connection was disconnect");
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_CONNECTION_LOST));
        }


    }
}//package com.evony.net.client

