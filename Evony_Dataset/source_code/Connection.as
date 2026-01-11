package autoevony.net
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import autoevony.management.CityManager;
   import autoevony.player.LoginHelper;
   import com.adobe.net.URI;
   import com.adobe.net.proxies.ProxySocket;
   import com.adobe.serialization.json.JSON;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.Sender;
   import com.evony.common.constants.CommonConstants;
   import com.evony.common.server.events.LoginResponse;
   import com.evony.net.client.GameClientEvent;
   import flash.display.Sprite;
   import flash.errors.IOError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import org.httpclient.HttpClient;
   import org.httpclient.HttpRequest;
   import org.httpclient.events.HttpDataEvent;
   import org.httpclient.events.HttpResponseEvent;
   import org.httpclient.http.Get;
   import org.httpclient.http.Post;
   
   public class Connection extends Sprite implements Sender
   {
      private static const MAX_PACKAGE_SIZE:int = 1048576;
      
      private static const VERSION_COMMAND:String = "gameClient.version";
      
      private static const traceOn:Boolean = Version.isTraceConnectionOn();
      
      private static var conn:Connection = null;
      
      private var lastConnectionTime:Number = 0;
      
      private var EvonySessionCookies:String = null;
      
      private var connectionCheckTimer:Timer = new Timer(300000);
      
      private var sendTimer:Timer = null;
      
      public var reconnectTimer:Timer = new Timer(10000);
      
      public var authenticated:Boolean;
      
      public var paused:Boolean;
      
      private var lastPackageTime:Number = 0;
      
      private var buffer:ByteArray;
      
      private var loginAttempts:int = 0;
      
      private var connectAttempts:int = 0;
      
      private var initialized:Boolean = false;
      
      private var sentQueue:Array = new Array();
      
      public var ok:int = 1;
      
      private var hasReceivedData:Boolean = false;
      
      private var packageSize:int;
      
      private var sendQueue:Array = new Array();
      
      public var p:uint = 1323456301;
      
      private var socket:ProxySocket;
      
      private var FBSessionCookies:String = null;
      
      private var busy:Boolean;
      
      public function Connection()
      {
         conn = this;
         super();
      }
      
      public static function getInstance() : Connection
      {
         if(conn == null)
         {
            conn = new Connection();
         }
         return conn;
      }
      
      private function connectHandler(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(traceOn)
         {
            trace(Utils.getTimeStr(Utils.getServerTime()) + " - send version");
         }
         this.directSendMessage(VERSION_COMMAND,Version.getGameClientVersion());
         if(traceOn)
         {
            trace(Utils.getTimeStr(Utils.getServerTime()) + " - send login info");
         }
         this.logMsg("Connected, sending login info and waiting for reply...");
         if(LoginHelper.getInstance().isFbLoginType())
         {
            this.directSendMessage(CommonConstants.LOGIN_FB_CMD,LoginHelper.getInstance().getFbLoginObj());
         }
         else
         {
            _loc2_ = new Object();
            _loc2_[CommonConstants.LOGIN_PARAM_USER] = LoginHelper.getInstance().username;
            _loc2_[CommonConstants.LOGIN_PARAM_PASSWORD] = LoginHelper.getInstance().getHashedEvonyPw();
            this.directSendMessage(CommonConstants.LOGIN_CMD,_loc2_);
         }
         this.hasReceivedData = false;
      }
      
      public function getSendQueueLength() : int
      {
         return this.sendQueue.length;
      }
      
      public function reconnectHandler(param1:TimerEvent = null) : void
      {
         var time:Number;
         var MAXQUICKATTEMPTS:int;
         var event:TimerEvent = param1;
         if(this.paused)
         {
            return;
         }
         if(this.authenticated)
         {
            this.reconnectTimer.stop();
            return;
         }
         if(!this.reconnectTimer.running)
         {
            Utils.callLater(5000,this.reconnectTimer.start);
         }
         time = Number(new Date().getTime());
         if(this.socket.connected)
         {
            if(time < this.lastConnectionTime + 15 * 60 * 1000)
            {
               return;
            }
            this.logMsg("Closing existing connection...");
            try
            {
               this.socket.close();
            }
            catch(e:Error)
            {
            }
            if(this.reconnectTimer.delay < 15 * 60 * 1000 && this.reconnectTimer.running)
            {
               return;
            }
         }
         MAXQUICKATTEMPTS = 3;
         this.connect();
         ++this.connectAttempts;
         this.lastConnectionTime = time;
         if(this.connectAttempts > MAXQUICKATTEMPTS)
         {
            if(this.connectAttempts % MAXQUICKATTEMPTS == 1)
            {
               if(this.reconnectTimer.delay < 5 * 60 * 1000)
               {
                  this.reconnectTimer.delay = Utils.rand(5 * 60 * 1000,8 * 60 * 1000);
                  this.logMsg("  ...next attempt will be in " + Utils.formatTime(this.reconnectTimer.delay / 1000));
               }
               else if(this.reconnectTimer.delay < 30 * 60 * 1000)
               {
                  this.reconnectTimer.delay *= 1 + Math.random();
                  this.logMsg("  ...next attempt will be in " + Utils.formatTime(this.reconnectTimer.delay / 1000));
               }
            }
         }
         else
         {
            if(this.reconnectTimer.delay < 2 * 60 * 1000)
            {
               this.reconnectTimer.delay = Utils.rand(2 * 60 * 1000,5 * 60 * 1000);
            }
            if(this.reconnectTimer.delay > 15 * 60 * 1000)
            {
               this.reconnectTimer.delay = Utils.rand(15 * 60 * 1000,20 * 60 * 1000);
            }
            this.logMsg("  ...next attempt will be in " + Utils.formatTime(this.reconnectTimer.delay / 1000));
         }
      }
      
      public function init() : void
      {
         if(this.initialized)
         {
            return;
         }
         this.initialized = true;
         this.socket = new ProxySocket();
         this.sendTimer = new Timer(50);
         this.sendTimer.addEventListener(TimerEvent.TIMER,this.onSendTimer);
         this.reconnectTimer.addEventListener(TimerEvent.TIMER,this.reconnectHandler);
         this.connectionCheckTimer.addEventListener(TimerEvent.TIMER,this.onConnectionCheckTimer);
         this.connectionCheckTimer.start();
         addEventListener(GameClientEvent.ON_EXTENSION_RESPONSE,this.onExtensionResponseHandle);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.onLogin);
         this.socket.addEventListener(Event.CONNECT,this.connectHandler);
         this.socket.addEventListener(Event.CLOSE,this.closeHandler);
         this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.socketDataHandler);
         this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this.connect();
         Utils.callLater(60 * 1000,this.reconnectTimer.start);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         this.authenticated = false;
         dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
      }
      
      private function onExtensionResponseHandle(param1:GameClientEvent) : void
      {
         ResponseDispatcher.getInstance().dispatch(param1.cmd,param1.data);
      }
      
      private function onConnectionCheckTimer(param1:TimerEvent = null) : void
      {
         if(this.paused)
         {
            return;
         }
         if(Utils.getServerTime() - this.lastPackageTime < this.connectionCheckTimer.delay)
         {
            return;
         }
         this.logMsg(" *** BAD CONNECTION STATE: No package received recently ***");
         this.disconnect();
         this.reconnectTimer.delay = Utils.rand(10000,30000);
         this.reconnectTimer.start();
         this.lastPackageTime = Utils.getServerTime();
      }
      
      public function disconnect() : void
      {
         MainScreen.getInstance().disableLogoutButton();
         try
         {
            this.socket.close();
         }
         catch(e:Error)
         {
         }
         this.authenticated = false;
         this.packageSize = -1;
         this.lastPackageTime = Utils.getServerTime();
      }
      
      private function logMsg(param1:String) : void
      {
         MainScreen.getInstance().logMsg(param1);
      }
      
      private function closeHandler(param1:Event) : void
      {
         var evt:Event = param1;
         this.authenticated = false;
         if(this.paused)
         {
            this.logMsg("Disconnected from server");
         }
         else
         {
            if(!this.hasReceivedData)
            {
               if(this.reconnectTimer.delay < 5 * 60 * 1000)
               {
                  this.reconnectTimer.delay = Utils.rand(5 * 60 * 1000,6 * 60 * 1000);
               }
            }
            this.reconnectTimer.delay += CityManager.getMatime();
            this.logMsg("Disconnected from server, retry in " + Utils.formatTime(this.reconnectTimer.delay / 1000));
            this.reconnectTimer.start();
         }
         try
         {
            this.disconnect();
         }
         catch(e:IOError)
         {
         }
         dispatchEvent(new GameClientEvent(ResponseDispatcher.SERVER_CONNECTION_LOST));
      }
      
      private function directSendMessage(param1:String, param2:Object) : void
      {
         var _loc3_:ByteArray = null;
         if(this.socket.connected)
         {
            if(traceOn)
            {
               trace(Utils.getTimeStr(Utils.getServerTime()) + " - Sending: " + param1 + " " + param2.toString());
            }
            _loc3_ = new ByteArray();
            _loc3_.writeObject({
               "cmd":param1,
               "data":param2
            });
            this.socket.writeInt(_loc3_.length);
            this.socket.writeBytes(_loc3_);
            this.socket.flush();
         }
      }
      
      private function socketDataHandler(param1:ProgressEvent) : void
      {
         var evt:ProgressEvent = param1;
         var nBytes:int = 0;
         var amfObj:Object = null;
         this.hasReceivedData = true;
         if(this.busy)
         {
            return;
         }
         this.busy = true;
         try
         {
            while(this.socket.bytesAvailable > 0)
            {
               if(this.packageSize == -1)
               {
                  if(this.socket.bytesAvailable < 4)
                  {
                     this.busy = false;
                     return;
                  }
                  try
                  {
                     this.packageSize = this.socket.readInt();
                  }
                  catch(e1:Error)
                  {
                     this.logMsg("An error occurred while talking to the server (read package size). Reconnect...");
                     reconnectTimer.delay = Utils.rand(8 * 60 * 1000,10 * 60 * 1000);
                     closeHandler(null);
                     return;
                  }
                  if(this.packageSize < 0 || this.packageSize > MAX_PACKAGE_SIZE)
                  {
                     this.reconnectTimer.delay = Utils.rand(8 * 60 * 1000,10 * 60 * 1000);
                     this.logMsg("An error occurred while talking to the server (invalid package size " + this.packageSize + "). Reconnect...");
                     this.closeHandler(null);
                     return;
                  }
                  this.buffer = new ByteArray();
               }
               else
               {
                  nBytes = Math.min(this.socket.bytesAvailable,this.packageSize - this.buffer.length);
                  try
                  {
                     this.socket.readBytes(this.buffer,this.buffer.length,nBytes);
                  }
                  catch(e2:Error)
                  {
                     reconnectTimer.delay = Utils.rand(8 * 60 * 1000,10 * 60 * 1000);
                     this.logMsg("An error occurred while talking to the server (read object). Reconnect...");
                     closeHandler(null);
                     return;
                  }
                  if(this.buffer.length == this.packageSize)
                  {
                     if(traceOn)
                     {
                        trace(Utils.getTimeStr(Utils.getServerTime()) + " - Package read");
                     }
                     try
                     {
                        amfObj = this.buffer.readObject();
                     }
                     catch(e3:Error)
                     {
                        reconnectTimer.delay = Utils.rand(8 * 60 * 1000,10 * 60 * 1000);
                        this.logMsg("An error occurred while talking to the server (convert object). Reconnect...");
                        closeHandler(null);
                        return;
                     }
                     if(!amfObj || amfObj.cmd == undefined || amfObj.data == undefined)
                     {
                        this.reconnectTimer.delay = Utils.rand(8 * 60 * 1000,10 * 60 * 1000);
                        this.logMsg("An error occurred while talking to the server (invalid object). Reconnect...");
                        this.closeHandler(null);
                        return;
                     }
                     if(traceOn)
                     {
                        trace(Utils.getTimeStr(Utils.getServerTime()) + " - Read: " + amfObj.cmd + " " + amfObj.data.toString());
                     }
                     this.packageSize = -1;
                     dispatchEvent(new GameClientEvent(GameClientEvent.ON_EXTENSION_RESPONSE,amfObj));
                     this.lastPackageTime = Utils.getServerTime();
                  }
               }
            }
         }
         catch(e4:Error)
         {
            this.logMsg("Unknown error reading data from server");
            if(traceOn)
            {
               trace(Utils.getTimeStr(Utils.getServerTime()) + " - " + e4.getStackTrace());
            }
         }
         this.busy = false;
      }
      
      private function onLogin(param1:LoginResponse) : void
      {
         if(traceOn)
         {
            trace(Utils.getTimeStr(Utils.getServerTime()) + " - receive login response");
         }
         ++this.loginAttempts;
         if(param1.player == null)
         {
            switch(param1.ok)
            {
               case LoginResponse.LOGIN_RESULT_NEED_CREATE_PLAYER:
                  this.logMsg("You have not logged in to this server ever before. Use the real game client to setup your name and other details, then use this client to connect.");
                  break;
               case LoginResponse.LOGIN_RESULT_SERVER_FULL:
                  this.logMsg("Server full, please try again later");
                  break;
               case LoginResponse.LOGIN_RESULT_ERROR_USERNAME:
                  if(this.loginAttempts > 10)
                  {
                     this.logMsg("Invalid user name or password, please try again");
                  }
                  else
                  {
                     this.reconnectTimer.delay = Utils.rand(this.loginAttempts * 60 * 1000,(this.loginAttempts + 1) * 60 * 1000);
                     this.logMsg("Invalid password, next retry in " + Utils.formatTime(this.reconnectTimer.delay / 1000));
                     this.disconnect();
                  }
                  break;
               default:
                  this.logMsg("Login failed: " + param1.errorMsg);
            }
            return;
         }
         this.reconnectTimer.delay = Utils.rand(30000,60000);
         this.authenticated = true;
         this.connectAttempts = 0;
         this.loginAttempts = 0;
      }
      
      public function getLastCmdInSendQueue() : String
      {
         if(this.sendQueue.length == 0)
         {
            return null;
         }
         return this.sendQueue[this.sendQueue.length - 1].cmd;
      }
      
      private function initFbLogin() : void
      {
         var req:Post;
         var postVars:URLVariables;
         var v:ByteArray;
         var onResultHandler:Function = null;
         var onFaultEventHandler:Function = null;
         var http:HttpClient = null;
         this.logMsg(" --> Attempt connect using fb credentials...");
         onResultHandler = function(param1:HttpResponseEvent):void
         {
            var _loc2_:HttpRequest = null;
            var _loc3_:String = null;
            if(FBSessionCookies != "")
            {
               FBSessionCookies += "; ";
            }
            FBSessionCookies += param1.response.header.cookies;
            http.listener.unregister();
            http = null;
            if(param1.response.code == "302")
            {
               logMsg("Redirecting to.... " + _loc3_);
               http = new HttpClient();
               _loc2_ = new Get();
               _loc2_.addHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
               _loc2_.addHeader("Accept-Encoding","identity");
               _loc2_.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
               _loc2_.addHeader("Cookie",FBSessionCookies);
               http.listener.onComplete = onResultHandler;
               http.listener.onError = onFaultEventHandler;
               _loc3_ = param1.response.header.getValue("Location");
               _loc3_ = Utils.trim(_loc3_);
               if(_loc3_ != null)
               {
                  http.request(new URI(_loc3_),_loc2_);
                  return;
               }
            }
            if(param1.response.code != "200")
            {
               logMsg(" *** Error logging in to FB, authentication failed ***");
               return;
            }
            LoginHelper.getInstance().setIsFBLoggedIn(true);
            logMsg(" --> Successfully logged into fb...");
            initFbConnect();
         };
         onFaultEventHandler = function(param1:ErrorEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(param1.toString());
            logMsg(" *** ERROR while logging into fb ***");
         };
         postVars = new URLVariables();
         postVars.email = LoginHelper.getInstance().username;
         postVars.pass = LoginHelper.getInstance().password;
         req = new Post();
         req.addHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
         req.addHeader("Accept-Encoding","identity");
         req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
         req.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
         v = new ByteArray();
         v.writeUTFBytes(postVars.toString());
         v.position = 0;
         req.body = v;
         this.FBSessionCookies = "";
         http = new HttpClient();
         http.listener.onComplete = onResultHandler;
         http.listener.onError = onFaultEventHandler;
         http.request(new URI("https://m.facebook.com/login.php"),req);
      }
      
      private function initFbConnect() : void
      {
         var onFbFaultEventHandler:Function;
         var onFbResultHandler:Function;
         var postVars:URLVariables = null;
         var access_token:String = null;
         var onTokenResultHandler:Function = null;
         var onTokenFaultEventHandler:Function = null;
         var onSessionResultHandler:Function = null;
         var onSessionFaultEventHandler:Function = null;
         var onEvonyResultHandler:Function = null;
         var onEvonyFaultEventHandler:Function = null;
         var handleHttpData:Function = null;
         var response:String = null;
         var getVars:URLVariables = null;
         var http:HttpClient = null;
         var req:HttpRequest = null;
         this.logMsg(" --> Attempt to get fb connect token...");
         postVars = null;
         access_token = null;
         onFbResultHandler = function(param1:HttpResponseEvent):void
         {
            var evt:HttpResponseEvent = param1;
            http.listener.unregister();
            http = null;
            logMsg(" --> Attempt token validation with server...");
            try
            {
               LoginHelper.getInstance().tokenExpires = new Date().getTime() + parseInt(response.match(/expires_in=(.*?)[&|"]/)[1]) * 1000 - 10000;
               getVars = new URLVariables();
               getVars.access_token = response.match(/access_token=(.*?)[&|"]/)[1];
               postVars = new URLVariables();
               postVars.access_token = response.match(/access_token=(.*?)[&|"]/)[1];
               access_token = postVars.access_token;
               postVars.signed_request = response.match(/signed_request=(.*?)[&|"]/)[1];
               postVars.expires_in = response.match(/expires_in=(.*?)[&|"]/)[1];
            }
            catch(ee:Error)
            {
               logMsg(" *** FB login seems to have been unsuccessful, double check your password ***");
               return;
            }
            getVars.method = "get";
            getVars.pretty = "0";
            getVars.sdk = "joey";
            response = "";
            http = new HttpClient();
            req = new Get();
            req.addHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding","identity");
            req.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            http.listener.onComplete = onTokenResultHandler;
            http.listener.onError = onTokenFaultEventHandler;
            http.listener.onData = handleHttpData;
            http.request(new URI("https://graph.facebook.com/v2.3/me?" + getVars.toString()),req);
         };
         onFbFaultEventHandler = function(param1:ErrorEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(" *** ERROR while getting fb connect token ***");
         };
         onTokenResultHandler = function(param1:HttpResponseEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(" --> Attempt to open session...");
            postVars.user_id = response.match(/"id":"([0-9]*)/)[1];
            response = "";
            http = new HttpClient();
            req = new Post();
            req.addHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding","identity");
            req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
            req.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            var _loc2_:ByteArray = new ByteArray();
            _loc2_.writeUTFBytes(postVars.toString());
            _loc2_.position = 0;
            req.body = _loc2_;
            http.listener.onComplete = onSessionResultHandler;
            http.listener.onError = onSessionFaultEventHandler;
            http.listener.onData = handleHttpData;
            http.request(new URI("http://www.evony.com/facebook/facebook.Ajax.php?Method=UserFacebookReg&Type=2"),req);
         };
         onTokenFaultEventHandler = function(param1:ErrorEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(" *** ERROR while validating token ***");
         };
         onSessionResultHandler = function(param1:HttpResponseEvent):void
         {
            EvonySessionCookies = param1.response.header.cookies;
            http.listener.unregister();
            http = null;
            logMsg(" --> Attempt to validate session...");
            http = new HttpClient();
            response = "";
            postVars = new URLVariables();
            postVars.access_token = access_token;
            req = new Post();
            req.addHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding","identity");
            req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
            req.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            req.addHeader("Cookie",EvonySessionCookies);
            var _loc2_:ByteArray = new ByteArray();
            _loc2_.writeUTFBytes(postVars.toString());
            _loc2_.position = 0;
            req.body = _loc2_;
            http.listener.onComplete = onEvonyResultHandler;
            http.listener.onError = onEvonyFaultEventHandler;
            http.listener.onData = handleHttpData;
            http.request(new URI("http://www.evony.com/facebook/facebook.Ajax.php?Method=UserFacebookPlayGame&ID=" + LoginHelper.getInstance().sid),req);
         };
         onSessionFaultEventHandler = function(param1:ErrorEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(" *** ERROR while validating game session with ***");
         };
         onEvonyResultHandler = function(param1:HttpResponseEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(" --> Attempt to connect to server...");
            var _loc2_:Object = com.adobe.serialization.json.JSON.decode(response);
            LoginHelper.getInstance().setFbPwObj(_loc2_["URL"].match(/loginid=(.*?)[&|"]/)[1]);
            LoginHelper.getInstance().setIsEvonyLoggedIn(true);
            connect();
         };
         onEvonyFaultEventHandler = function(param1:ErrorEvent):void
         {
            http.listener.unregister();
            http = null;
            logMsg(" *** ERROR while getting session id ***");
         };
         handleHttpData = function(param1:HttpDataEvent):void
         {
            response += param1.readUTFBytes();
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
         req.addHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
         req.addHeader("Accept-Encoding","identity");
         req.addHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
         req.addHeader("Referer","http://www.evony.com");
         req.addHeader("Cookie",this.FBSessionCookies);
         http.listener.onComplete = onFbResultHandler;
         http.listener.onError = onFbFaultEventHandler;
         http.listener.onData = handleHttpData;
         http.request(new URI("https://www.facebook.com/v2.3/dialog/oauth?" + getVars.toString()),req);
      }
      
      public function sendMessage(param1:String, param2:Object, param3:Function = null) : void
      {
         var _loc4_:Object = null;
         if(this.authenticated)
         {
            _loc4_ = {
               "cmd":param1,
               "data":param2
            };
            this.sendQueue.push(_loc4_);
            if(!this.sendTimer.running)
            {
               this.sendTimer.start();
            }
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         this.authenticated = false;
         dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
      }
      
      public function connect() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(LoginHelper.getInstance().isFbLoginType() && (!LoginHelper.getInstance().isFBLoggedIn() || !LoginHelper.getInstance().isEvonyLoggedIn()))
         {
            this.initFbLogin();
            return;
         }
         this.logMsg("Attempt to connect...");
         this.busy = false;
         this.packageSize = -1;
         this.lastPackageTime = Utils.getServerTime();
         var _loc1_:LoginHelper = LoginHelper.getInstance();
         if(_loc1_.proxyType != "")
         {
            _loc2_ = _loc1_.proxyType + "://" + (_loc1_.proxyUn != "" ? _loc1_.proxyUn + ":" + _loc1_.proxyPw + "@" : "") + _loc1_.proxyHost + ":" + _loc1_.proxyPort;
            _loc3_ = this.socket.setProxyInfo(_loc2_);
            if(_loc3_)
            {
               this.logMsg("Ignoring invalid proxy info: " + _loc2_ + "  because: " + _loc3_);
               _loc1_.proxyType = "";
            }
            else
            {
               this.logMsg("Using proxy info:  " + _loc2_);
            }
         }
         this.socket.connect(LoginHelper.getInstance().serverIP,443);
         MainScreen.getInstance().enableLogoutButton();
      }
      
      private function onSendTimer(param1:Object = null) : void
      {
         if(!this.authenticated)
         {
            if(this.sendQueue.length > 0)
            {
               this.sendQueue = new Array();
            }
            if(this.sentQueue.length > 0)
            {
               this.sentQueue = new Array();
            }
            return;
         }
         if(this.sendQueue.length == 0)
         {
            return;
         }
         if(this.sendQueue.length > 5)
         {
            this.sendTimer.delay = 100;
         }
         else if(this.sendQueue.length < 5)
         {
            this.sendTimer.delay = 50;
         }
         var _loc2_:Object = this.sendQueue.shift();
         this.directSendMessage(_loc2_.cmd,_loc2_.data);
      }
   }
}

