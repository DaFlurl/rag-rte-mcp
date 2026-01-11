// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.net.Connection

package autoevony.net
{
    import flash.display.Sprite;
    import com.evony.common.Sender;
    import flash.utils.Timer;
    import flash.utils.ByteArray;
    import com.adobe.net.proxies.ProxySocket;
    import autoevony.common.Utils;
    import autoevony.player.LoginHelper;
    import com.evony.common.constants.CommonConstants;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import com.evony.net.client.GameClientEvent;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import autoevony.gui.MainScreen;
    import autoevony.management.CityManager;
    import flash.errors.IOError;
    import com.evony.common.server.events.LoginResponse;
    import org.httpclient.HttpClient;
    import org.httpclient.HttpRequest;
    import org.httpclient.http.Get;
    import com.adobe.net.URI;
    import org.httpclient.events.HttpResponseEvent;
    import flash.events.ErrorEvent;
    import flash.net.URLVariables;
    import org.httpclient.http.Post;
    import com.adobe.serialization.json.JSON;
    import org.httpclient.events.HttpDataEvent;

    public class Connection extends Sprite implements Sender 
    {

        private static const MAX_PACKAGE_SIZE:int = 0x100000;
        private static const VERSION_COMMAND:String = "gameClient.version";
        private static const traceOn:Boolean = Version.isTraceConnectionOn();
        private static var conn:Connection = null;

        private var lastConnectionTime:Number = 0;
        private var EvonySessionCookies:String = null;
        private var sendTimer:Timer = null;
        public var authenticated:Boolean;
        public var paused:Boolean;
        private var lastPackageTime:Number = 0;
        private var buffer:ByteArray;
        private var loginAttempts:int = 0;
        private var connectAttempts:int = 0;
        private var initialized:Boolean = false;
        public var ok:int = 1;
        private var hasReceivedData:Boolean = false;
        private var packageSize:int;
        public var p:uint = 1323456301;
        private var socket:ProxySocket;
        private var FBSessionCookies:String = null;
        private var busy:Boolean;

        public var reconnectTimer:Timer = new Timer(10000);
        private var connectionCheckTimer:Timer = new Timer(300000);
        private var sendQueue:Array = new Array();
        private var sentQueue:Array = new Array();

        public function Connection()
        {
            conn = this;
            super();
        }

        public static function getInstance():Connection
        {
            if (conn == null)
            {
                conn = new (Connection)();
            };
            return (conn);
        }


        private function connectHandler(_arg_1:Event):void
        {
            var _local_2:Object;
            if (traceOn)
            {
                trace((Utils.getTimeStr(Utils.getServerTime()) + " - send version"));
            };
            this.directSendMessage(VERSION_COMMAND, Version.getGameClientVersion());
            if (traceOn)
            {
                trace((Utils.getTimeStr(Utils.getServerTime()) + " - send login info"));
            };
            this.logMsg("Connected, sending login info and waiting for reply...");
            if (LoginHelper.getInstance().isFbLoginType())
            {
                this.directSendMessage(CommonConstants.LOGIN_FB_CMD, LoginHelper.getInstance().getFbLoginObj());
            }
            else
            {
                _local_2 = new Object();
                _local_2[CommonConstants.LOGIN_PARAM_USER] = LoginHelper.getInstance().username;
                _local_2[CommonConstants.LOGIN_PARAM_PASSWORD] = LoginHelper.getInstance().getHashedEvonyPw();
                this.directSendMessage(CommonConstants.LOGIN_CMD, _local_2);
            };
            this.hasReceivedData = false;
        }

        public function getSendQueueLength():int
        {
            return (this.sendQueue.length);
        }

        public function reconnectHandler(event:TimerEvent=null):void
        {
            if (this.paused)
            {
                return;
            };
            if (this.authenticated)
            {
                this.reconnectTimer.stop();
                return;
            };
            if (!this.reconnectTimer.running)
            {
                Utils.callLater(5000, this.reconnectTimer.start);
            };
            var time:Number = new Date().getTime();
            if (this.socket.connected)
            {
                if (time < (this.lastConnectionTime + ((15 * 60) * 1000)))
                {
                    return;
                };
                this.logMsg("Closing existing connection...");
                try
                {
                    this.socket.close();
                }
                catch(e:Error)
                {
                };
                if (((this.reconnectTimer.delay < ((15 * 60) * 1000)) && (this.reconnectTimer.running)))
                {
                    return;
                };
            };
            var MAXQUICKATTEMPTS:int = 3;
            this.connect();
            this.connectAttempts++;
            this.lastConnectionTime = time;
            if (this.connectAttempts > MAXQUICKATTEMPTS)
            {
                if ((this.connectAttempts % MAXQUICKATTEMPTS) == 1)
                {
                    if (this.reconnectTimer.delay < ((5 * 60) * 1000))
                    {
                        this.reconnectTimer.delay = Utils.rand(((5 * 60) * 1000), ((8 * 60) * 1000));
                        this.logMsg(("  ...next attempt will be in " + Utils.formatTime((this.reconnectTimer.delay / 1000))));
                    }
                    else
                    {
                        if (this.reconnectTimer.delay < ((30 * 60) * 1000))
                        {
                            this.reconnectTimer.delay = (this.reconnectTimer.delay * (1 + Math.random()));
                            this.logMsg(("  ...next attempt will be in " + Utils.formatTime((this.reconnectTimer.delay / 1000))));
                        };
                    };
                };
            }
            else
            {
                if (this.reconnectTimer.delay < ((2 * 60) * 1000))
                {
                    this.reconnectTimer.delay = Utils.rand(((2 * 60) * 1000), ((5 * 60) * 1000));
                };
                if (this.reconnectTimer.delay > ((15 * 60) * 1000))
                {
                    this.reconnectTimer.delay = Utils.rand(((15 * 60) * 1000), ((20 * 60) * 1000));
                };
                this.logMsg(("  ...next attempt will be in " + Utils.formatTime((this.reconnectTimer.delay / 1000))));
            };
        }

        public function init():void
        {
            if (this.initialized)
            {
                return;
            };
            this.initialized = true;
            this.socket = new ProxySocket();
            this.sendTimer = new Timer(50);
            this.sendTimer.addEventListener(TimerEvent.TIMER, this.onSendTimer);
            this.reconnectTimer.addEventListener(TimerEvent.TIMER, this.reconnectHandler);
            this.connectionCheckTimer.addEventListener(TimerEvent.TIMER, this.onConnectionCheckTimer);
            this.connectionCheckTimer.start();
            addEventListener(GameClientEvent.ON_EXTENSION_RESPONSE, this.onExtensionResponseHandle);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, this.onLogin);
            this.socket.addEventListener(Event.CONNECT, this.connectHandler);
            this.socket.addEventListener(Event.CLOSE, this.closeHandler);
            this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.socketDataHandler);
            this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this.connect();
            Utils.callLater((60 * 1000), this.reconnectTimer.start);
        }

        private function securityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            this.authenticated = false;
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
        }

        private function onExtensionResponseHandle(_arg_1:GameClientEvent):void
        {
            ResponseDispatcher.getInstance().dispatch(_arg_1.cmd, _arg_1.data);
        }

        private function onConnectionCheckTimer(_arg_1:TimerEvent=null):void
        {
            if (this.paused)
            {
                return;
            };
            if ((Utils.getServerTime() - this.lastPackageTime) < this.connectionCheckTimer.delay)
            {
                return;
            };
            this.logMsg(" *** BAD CONNECTION STATE: No package received recently ***");
            this.disconnect();
            this.reconnectTimer.delay = Utils.rand(10000, 30000);
            this.reconnectTimer.start();
            this.lastPackageTime = Utils.getServerTime();
        }

        public function disconnect():void
        {
            MainScreen.getInstance().disableLogoutButton();
            try
            {
                this.socket.close();
            }
            catch(e:Error)
            {
            };
            this.authenticated = false;
            this.packageSize = -1;
            this.lastPackageTime = Utils.getServerTime();
        }

        private function logMsg(_arg_1:String):void
        {
            MainScreen.getInstance().logMsg(_arg_1);
        }

        private function closeHandler(evt:Event):void
        {
            this.authenticated = false;
            if (this.paused)
            {
                this.logMsg("Disconnected from server");
            }
            else
            {
                if (!this.hasReceivedData)
                {
                    if (this.reconnectTimer.delay < ((5 * 60) * 1000))
                    {
                        this.reconnectTimer.delay = Utils.rand(((5 * 60) * 1000), ((6 * 60) * 1000));
                    };
                };
                this.reconnectTimer.delay = (this.reconnectTimer.delay + CityManager.getMatime());
                this.logMsg(("Disconnected from server, retry in " + Utils.formatTime((this.reconnectTimer.delay / 1000))));
                this.reconnectTimer.start();
            };
            try
            {
                this.disconnect();
            }
            catch(e:IOError)
            {
            };
            dispatchEvent(new GameClientEvent(ResponseDispatcher.SERVER_CONNECTION_LOST));
        }

        private function directSendMessage(_arg_1:String, _arg_2:Object):void
        {
            var _local_3:ByteArray;
            if (this.socket.connected)
            {
                if (traceOn)
                {
                    trace(((((Utils.getTimeStr(Utils.getServerTime()) + " - Sending: ") + _arg_1) + " ") + _arg_2.toString()));
                };
                _local_3 = new ByteArray();
                _local_3.writeObject({
                    "cmd":_arg_1,
                    "data":_arg_2
                });
                this.socket.writeInt(_local_3.length);
                this.socket.writeBytes(_local_3);
                this.socket.flush();
            };
        }

        private function socketDataHandler(evt:ProgressEvent):void
        {
            var nBytes:int;
            var amfObj:Object;
            this.hasReceivedData = true;
            if (this.busy)
            {
                return;
            };
            this.busy = true;
            try
            {
                while (this.socket.bytesAvailable > 0)
                {
                    if (this.packageSize == -1)
                    {
                        if (this.socket.bytesAvailable < 4)
                        {
                            this.busy = false;
                            return;
                        };
                        try
                        {
                            this.packageSize = this.socket.readInt();
                        }
                        catch(e1:Error)
                        {
                            this.logMsg("An error occurred while talking to the server (read package size). Reconnect...");
                            reconnectTimer.delay = Utils.rand(((8 * 60) * 1000), ((10 * 60) * 1000));
                            closeHandler(null);
                            return;
                        };
                        if (((this.packageSize < 0) || (this.packageSize > MAX_PACKAGE_SIZE)))
                        {
                            this.reconnectTimer.delay = Utils.rand(((8 * 60) * 1000), ((10 * 60) * 1000));
                            this.logMsg((("An error occurred while talking to the server (invalid package size " + this.packageSize) + "). Reconnect..."));
                            this.closeHandler(null);
                            return;
                        };
                        this.buffer = new ByteArray();
                    }
                    else
                    {
                        nBytes = Math.min(this.socket.bytesAvailable, (this.packageSize - this.buffer.length));
                        try
                        {
                            this.socket.readBytes(this.buffer, this.buffer.length, nBytes);
                        }
                        catch(e2:Error)
                        {
                            reconnectTimer.delay = Utils.rand(((8 * 60) * 1000), ((10 * 60) * 1000));
                            this.logMsg("An error occurred while talking to the server (read object). Reconnect...");
                            closeHandler(null);
                            return;
                        };
                        if (this.buffer.length == this.packageSize)
                        {
                            if (traceOn)
                            {
                                trace((Utils.getTimeStr(Utils.getServerTime()) + " - Package read"));
                            };
                            try
                            {
                                amfObj = this.buffer.readObject();
                            }
                            catch(e3:Error)
                            {
                                reconnectTimer.delay = Utils.rand(((8 * 60) * 1000), ((10 * 60) * 1000));
                                this.logMsg("An error occurred while talking to the server (convert object). Reconnect...");
                                closeHandler(null);
                                return;
                            };
                            if ((((!(amfObj)) || (amfObj.cmd == undefined)) || (amfObj.data == undefined)))
                            {
                                this.reconnectTimer.delay = Utils.rand(((8 * 60) * 1000), ((10 * 60) * 1000));
                                this.logMsg("An error occurred while talking to the server (invalid object). Reconnect...");
                                this.closeHandler(null);
                                return;
                            };
                            if (traceOn)
                            {
                                trace(((((Utils.getTimeStr(Utils.getServerTime()) + " - Read: ") + amfObj.cmd) + " ") + amfObj.data.toString()));
                            };
                            this.packageSize = -1;
                            dispatchEvent(new GameClientEvent(GameClientEvent.ON_EXTENSION_RESPONSE, amfObj));
                            this.lastPackageTime = Utils.getServerTime();
                        };
                    };
                };
            }
            catch(e4:Error)
            {
                this.logMsg("Unknown error reading data from server");
                if (traceOn)
                {
                    trace(((Utils.getTimeStr(Utils.getServerTime()) + " - ") + e4.getStackTrace()));
                };
            };
            this.busy = false;
        }

        private function onLogin(_arg_1:LoginResponse):void
        {
            if (traceOn)
            {
                trace((Utils.getTimeStr(Utils.getServerTime()) + " - receive login response"));
            };
            this.loginAttempts++;
            if (_arg_1.player == null)
            {
                switch (_arg_1.ok)
                {
                    case LoginResponse.LOGIN_RESULT_NEED_CREATE_PLAYER:
                        this.logMsg("You have not logged in to this server ever before. Use the real game client to setup your name and other details, then use this client to connect.");
                        return;
                    case LoginResponse.LOGIN_RESULT_SERVER_FULL:
                        this.logMsg("Server full, please try again later");
                        return;
                    case LoginResponse.LOGIN_RESULT_ERROR_USERNAME:
                        if (this.loginAttempts > 10)
                        {
                            this.logMsg("Invalid user name or password, please try again");
                        }
                        else
                        {
                            this.reconnectTimer.delay = Utils.rand(((this.loginAttempts * 60) * 1000), (((this.loginAttempts + 1) * 60) * 1000));
                            this.logMsg(("Invalid password, next retry in " + Utils.formatTime((this.reconnectTimer.delay / 1000))));
                            this.disconnect();
                        };
                        return;
                    default:
                        this.logMsg(("Login failed: " + _arg_1.errorMsg));
                };
                return;
            };
            this.reconnectTimer.delay = Utils.rand(30000, 60000);
            this.authenticated = true;
            this.connectAttempts = 0;
            this.loginAttempts = 0;
        }

        public function getLastCmdInSendQueue():String
        {
            if (this.sendQueue.length == 0)
            {
                return (null);
            };
            return (this.sendQueue[(this.sendQueue.length - 1)].cmd);
        }

        private function initFbLogin():void
        {
            var onResultHandler:Function;
            var onFaultEventHandler:Function;
            var http:HttpClient;
            this.logMsg(" --> Attempt connect using fb credentials...");
            onResultHandler = function (_arg_1:HttpResponseEvent):void
            {
                var _local_2:HttpRequest;
                var _local_3:String;
                if (FBSessionCookies != "")
                {
                    FBSessionCookies = (FBSessionCookies + "; ");
                };
                FBSessionCookies = (FBSessionCookies + _arg_1.response.header.cookies);
                http.listener.unregister();
                http = null;
                if (_arg_1.response.code == "302")
                {
                    logMsg(("Redirecting to.... " + _local_3));
                    http = new HttpClient();
                    _local_2 = new Get();
                    _local_2.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                    _local_2.addHeader("Accept-Encoding", "identity");
                    _local_2.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                    _local_2.addHeader("Cookie", FBSessionCookies);
                    http.listener.onComplete = onResultHandler;
                    http.listener.onError = onFaultEventHandler;
                    _local_3 = _arg_1.response.header.getValue("Location");
                    _local_3 = Utils.trim(_local_3);
                    if (_local_3 != null)
                    {
                        http.request(new URI(_local_3), _local_2);
                        return;
                    };
                };
                if (_arg_1.response.code != "200")
                {
                    logMsg(" *** Error logging in to FB, authentication failed ***");
                    return;
                };
                LoginHelper.getInstance().setIsFBLoggedIn(true);
                logMsg(" --> Successfully logged into fb...");
                initFbConnect();
            };
            onFaultEventHandler = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(_arg_1.toString());
                logMsg(" *** ERROR while logging into fb ***");
            };
            var postVars:URLVariables = new URLVariables();
            postVars.email = LoginHelper.getInstance().username;
            postVars.pass = LoginHelper.getInstance().password;
            var req:Post = new Post();
            req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding", "identity");
            req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
            req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            var v:ByteArray = new ByteArray();
            v.writeUTFBytes(postVars.toString());
            v.position = 0;
            req.body = v;
            this.FBSessionCookies = "";
            http = new HttpClient();
            http.listener.onComplete = onResultHandler;
            http.listener.onError = onFaultEventHandler;
            http.request(new URI("https://m.facebook.com/login.php"), req);
        }

        private function initFbConnect():void
        {
            var postVars:URLVariables;
            var access_token:String;
            var onTokenResultHandler:Function;
            var onTokenFaultEventHandler:Function;
            var onSessionResultHandler:Function;
            var onSessionFaultEventHandler:Function;
            var onEvonyResultHandler:Function;
            var onEvonyFaultEventHandler:Function;
            var handleHttpData:Function;
            var response:String;
            var getVars:URLVariables;
            var http:HttpClient;
            var req:HttpRequest;
            this.logMsg(" --> Attempt to get fb connect token...");
            postVars = null;
            access_token = null;
            var onFbResultHandler:Function = function (evt:HttpResponseEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" --> Attempt token validation with server...");
                try
                {
                    LoginHelper.getInstance().tokenExpires = ((new Date().getTime() + (parseInt(response.match(new RegExp('expires_in=(.*?)[&|"]'))[1]) * 1000)) - 10000);
                    getVars = new URLVariables();
                    getVars.access_token = response.match(new RegExp('access_token=(.*?)[&|"]'))[1];
                    postVars = new URLVariables();
                    postVars.access_token = response.match(new RegExp('access_token=(.*?)[&|"]'))[1];
                    access_token = postVars.access_token;
                    postVars.signed_request = response.match(new RegExp('signed_request=(.*?)[&|"]'))[1];
                    postVars.expires_in = response.match(new RegExp('expires_in=(.*?)[&|"]'))[1];
                }
                catch(ee:Error)
                {
                    logMsg(" *** FB login seems to have been unsuccessful, double check your password ***");
                    return;
                };
                getVars.method = "get";
                getVars.pretty = "0";
                getVars.sdk = "joey";
                response = "";
                http = new HttpClient();
                req = new Get();
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                http.listener.onComplete = onTokenResultHandler;
                http.listener.onError = onTokenFaultEventHandler;
                http.listener.onData = handleHttpData;
                http.request(new URI(("https://graph.facebook.com/v2.3/me?" + getVars.toString())), req);
            };
            var onFbFaultEventHandler:Function = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" *** ERROR while getting fb connect token ***");
            };
            onTokenResultHandler = function (_arg_1:HttpResponseEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" --> Attempt to open session...");
                postVars.user_id = response.match(new RegExp('"id":"([0-9]*)'))[1];
                response = "";
                http = new HttpClient();
                req = new Post();
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                var _local_2:ByteArray = new ByteArray();
                _local_2.writeUTFBytes(postVars.toString());
                _local_2.position = 0;
                req.body = _local_2;
                http.listener.onComplete = onSessionResultHandler;
                http.listener.onError = onSessionFaultEventHandler;
                http.listener.onData = handleHttpData;
                http.request(new URI("http://www.evony.com/facebook/facebook.Ajax.php?Method=UserFacebookReg&Type=2"), req);
            };
            onTokenFaultEventHandler = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" *** ERROR while validating token ***");
            };
            onSessionResultHandler = function (_arg_1:HttpResponseEvent):void
            {
                EvonySessionCookies = _arg_1.response.header.cookies;
                http.listener.unregister();
                http = null;
                logMsg(" --> Attempt to validate session...");
                http = new HttpClient();
                response = "";
                postVars = new URLVariables();
                postVars.access_token = access_token;
                req = new Post();
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.addHeader("Cookie", EvonySessionCookies);
                var _local_2:ByteArray = new ByteArray();
                _local_2.writeUTFBytes(postVars.toString());
                _local_2.position = 0;
                req.body = _local_2;
                http.listener.onComplete = onEvonyResultHandler;
                http.listener.onError = onEvonyFaultEventHandler;
                http.listener.onData = handleHttpData;
                http.request(new URI(("http://www.evony.com/facebook/facebook.Ajax.php?Method=UserFacebookPlayGame&ID=" + LoginHelper.getInstance().sid)), req);
            };
            onSessionFaultEventHandler = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" *** ERROR while validating game session with ***");
            };
            onEvonyResultHandler = function (_arg_1:HttpResponseEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" --> Attempt to connect to server...");
                var _local_2:Object = com.adobe.serialization.json.JSON.decode(response);
                LoginHelper.getInstance().setFbPwObj(_local_2["URL"].match(new RegExp('loginid=(.*?)[&|"]'))[1]);
                LoginHelper.getInstance().setIsEvonyLoggedIn(true);
                connect();
            };
            onEvonyFaultEventHandler = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                logMsg(" *** ERROR while getting session id ***");
            };
            handleHttpData = function (_arg_1:HttpDataEvent):void
            {
                response = (response + _arg_1.readUTFBytes());
            };
            response = "";
            getVars = new URLVariables();
            getVars.app_id = "372268249833";
            getVars.client_id = "372268249833";
            getVars.display = "popup";
            getVars.domain = "www.evony.com";
            getVars.e2e = "{}";
            getVars.locale = "en_US";
            getVars.origin = "1";
            getVars.redirect_uri = "http://staticxx.facebook.com/connect/xd_arbiter/r/Sh-3BhStODe.js?version=42#cb=f123922615ca27c&domain=www.evony.com&origin=http%3A%2F%2Fwww.evony.com%2Ff1b46b056bdcb7a&relation=opener&frame=f33cffbe3a0a40c";
            getVars.response_type = "token,signed_request";
            getVars.scope = "public_profile,user_friends";
            getVars.sdk = "joey";
            getVars.version = "v2.3";
            http = new HttpClient();
            req = new Get();
            req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding", "identity");
            req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            req.addHeader("Referer", "http://www.evony.com");
            req.addHeader("Cookie", this.FBSessionCookies);
            http.listener.onComplete = onFbResultHandler;
            http.listener.onError = onFbFaultEventHandler;
            http.listener.onData = handleHttpData;
            http.request(new URI(("https://www.facebook.com/v2.3/dialog/oauth?" + getVars.toString())), req);
        }

        public function sendMessage(_arg_1:String, _arg_2:Object, _arg_3:Function=null):void
        {
            var _local_4:Object;
            if (this.authenticated)
            {
                _local_4 = {
                    "cmd":_arg_1,
                    "data":_arg_2
                };
                this.sendQueue.push(_local_4);
                if (!this.sendTimer.running)
                {
                    this.sendTimer.start();
                };
            };
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            this.authenticated = false;
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
        }

        public function connect():void
        {
            var _local_2:String;
            var _local_3:String;
            if (((LoginHelper.getInstance().isFbLoginType()) && ((!(LoginHelper.getInstance().isFBLoggedIn())) || (!(LoginHelper.getInstance().isEvonyLoggedIn())))))
            {
                this.initFbLogin();
                return;
            };
            this.logMsg("Attempt to connect...");
            this.busy = false;
            this.packageSize = -1;
            this.lastPackageTime = Utils.getServerTime();
            var _local_1:LoginHelper = LoginHelper.getInstance();
            if (_local_1.proxyType != "")
            {
                _local_2 = (((((_local_1.proxyType + "://") + ((_local_1.proxyUn != "") ? (((_local_1.proxyUn + ":") + _local_1.proxyPw) + "@") : "")) + _local_1.proxyHost) + ":") + _local_1.proxyPort);
                _local_3 = this.socket.setProxyInfo(_local_2);
                if (_local_3)
                {
                    this.logMsg(((("Ignoring invalid proxy info: " + _local_2) + "  because: ") + _local_3));
                    _local_1.proxyType = "";
                }
                else
                {
                    this.logMsg(("Using proxy info:  " + _local_2));
                };
            };
            this.socket.connect(LoginHelper.getInstance().serverIP, 443);
            MainScreen.getInstance().enableLogoutButton();
        }

        private function onSendTimer(_arg_1:Object=null):void
        {
            if (!this.authenticated)
            {
                if (this.sendQueue.length > 0)
                {
                    this.sendQueue = new Array();
                };
                if (this.sentQueue.length > 0)
                {
                    this.sentQueue = new Array();
                };
                return;
            };
            if (this.sendQueue.length == 0)
            {
                return;
            };
            if (this.sendQueue.length > 5)
            {
                this.sendTimer.delay = 100;
            }
            else
            {
                if (this.sendQueue.length < 5)
                {
                    this.sendTimer.delay = 50;
                };
            };
            var _local_2:Object = this.sendQueue.shift();
            this.directSendMessage(_local_2.cmd, _local_2.data);
        }


    }
}//package autoevony.net

