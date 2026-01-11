// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.skype.Skype

package com.skype
{
    import flash.utils.Timer;
    import org.httpclient.HttpClient;
    import org.httpclient.HttpRequest;
    import org.httpclient.http.Get;
    import autoevony.common.Utils;
    import com.adobe.net.URI;
    import org.httpclient.http.Post;
    import flash.net.URLVariables;
    import flash.utils.ByteArray;
    import org.httpclient.events.HttpResponseEvent;
    import flash.events.ErrorEvent;
    import com.adobe.serialization.json.JSON;
    import flash.events.SecurityErrorEvent;
    import org.httpclient.events.HttpDataEvent;
    import flash.events.TimerEvent;

    public class Skype 
    {

        private static var _instance:Skype = null;
        private static var username:String = null;
        private static var password:String = null;
        private static var _isLoggingIn:Boolean = false;
        private static var _isLoggedIn:Boolean = false;
        private static var loginFailCount:int = 0;
        private static var SkypeCookies:String = "";
        private static var skypeToken:String = null;
        private static var tokenExpiry:Number = 0;
        private static var skypeId:String = null;
        private static var regToken:String = null;
        private static var msgsHost:String = "https://client-s.gateway.messenger.live.com/v1";
        private static var registrationURL:String = "https://client-s.gateway.messenger.live.com/v1/users/ME/endpoints";
        private static var skypeEndPoints:Array = null;
        private static var conversationIds:Object = new Object();
        private static var isRetrievingConversationIds:Boolean = false;
        private static var lastUpdatedConversationIds:Number = -1;
        private static var msgQueue:Array = new Array();
        private static var sendTimer:Timer = null;


        public static function queueMsg(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Function=null):SkypeResponse
        {
            if (((_arg_1 == null) || (_arg_1 == "")))
            {
                if (_arg_3)
                {
                    return (new SkypeResponse(SkypeConstants.ERROR_INVALID_OR_MISSING_GROUP_NAME, "", "Missing/invalid group name"));
                };
                return (new SkypeResponse(SkypeConstants.ERROR_INVALID_OR_MISSING_ID, "", "Missing recipient skype ID"));
            };
            if (((_arg_2 == null) || (_arg_2 == "")))
            {
                return (new SkypeResponse(SkypeConstants.ERROR_INVALID_OR_MISSING_MSG, "", "Missing/invalid message String"));
            };
            var _local_5:SkypeMsgBean = new SkypeMsgBean(_arg_1, _arg_2, _arg_3, _arg_4);
            msgQueue.push(_local_5);
            if (((!(isLoggedIn())) || (_isLoggingIn)))
            {
                return (new SkypeResponse(SkypeConstants.OK_MSG_QUEUED));
            };
            return (new SkypeResponse(SkypeConstants.OK_DEFAULT));
        }

        public static function getMsgsHost():String
        {
            return (msgsHost);
        }

        public static function login(un:String, pw:String, callback:Function=null):SkypeResponse
        {
            var processParams:Function;
            var handleLoginError:Function;
            var handleLogin:Function;
            var processSkypeToken:Function;
            var onTokenError:Function;
            var processSkypeId:Function;
            var processSkypeIdError:Function;
            var errorRegToken:Function;
            var receiveRegToken:Function;
            var confirmConfig:Function;
            var finishLogin:Function;
            var loginError:Function;
            var processParamError:Function;
            var handleHttpData:Function;
            var http:HttpClient;
            var req:HttpRequest;
            var response:String;
            var CkTst:String;
            if (isUserLoggedIn(un))
            {
                return (new SkypeResponse(SkypeConstants.ERROR_USER_ALREADY_LOGGED_IN, "", "User is already logged in"));
            };
            if (_isLoggingIn)
            {
                return (new SkypeResponse(SkypeConstants.ERROR_ALREADY_LOGGING_IN, "", "Trying to login to skype already. Try again later"));
            };
            if (((un == null) || (pw == null)))
            {
                _isLoggingIn = false;
                return (new SkypeResponse(SkypeConstants.ERROR_NO_UN_OR_PW, "", " *** Username or password is missing ***"));
            };
            _isLoggingIn = true;
            _isLoggedIn = false;
            SkypeCookies = "";
            if (((!(sendTimer == null)) && (sendTimer.running)))
            {
                sendTimer.reset();
            };
            processParams = function (evt:HttpResponseEvent):void
            {
                var u:String;
                var ppft:String;
                http.listener.unregister();
                http = null;
                SkypeUtils.logMsg(" --> Received response");
                if (evt.response.code == "302")
                {
                    http = new HttpClient();
                    req = new Get();
                    req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                    req.addHeader("Accept-Encoding", "identity");
                    req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                    http.listener.onComplete = processParams;
                    http.listener.onData = handleHttpData;
                    http.listener.onError = processParamError;
                    response = "";
                    u = Utils.trim(evt.response.header.getValue("Location"));
                    if (u == null)
                    {
                        SkypeUtils.logErrMsg(" *** Error initiating skype login ***");
                        if (callback != null)
                        {
                            callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INITIALIZING_LOGIN, "", " *** Failed to initialize pre login ***")]);
                        };
                        return;
                    };
                    SkypeUtils.logMsg((" --> Redirecting to... " + u));
                    http.request(new URI(u), req);
                    return;
                };
                SkypeCookies = evt.response.header.cookies;
                try
                {
                    ppft = response.match(new RegExp('<input.*?name="PPFT".*?value="(.*?)"'))[1];
                }
                catch(e:Error)
                {
                    SkypeUtils.logErrMsg(" *** Error initiating skype login *** ");
                    _isLoggingIn = false;
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INITIALIZING_LOGIN, "", " *** Failed to initiate login attempt ***")]);
                    };
                    return;
                };
                SkypeUtils.logMsg(" --> Successfully initiated skype login");
                response = "";
                http = new HttpClient();
                req = new Post();
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.addHeader("Cookie", ((SkypeCookies + "; CkTst=") + String(new Date().getTime())));
                req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
                var postVars:URLVariables = new URLVariables();
                postVars.login = un;
                postVars.passwd = pw;
                postVars.PPFT = ppft;
                var payload:ByteArray = new ByteArray();
                payload.writeUTFBytes(postVars.toString());
                payload.position = 0;
                req.body = payload;
                http.listener.onComplete = handleLogin;
                http.listener.onError = handleLoginError;
                http.listener.onData = handleHttpData;
                http.request(new URI("https://login.live.com/ppsecure/post.srf?wreply=https%3A%2F%2Flw.skype.com%2Flogin%2Foauth%2Fproxy%3Fclient_id%3D578134%26site_name%3Dlw.skype.com%26redirect_uri%3Dhttps%253A%252F%252Fweb.skype.com%252F&wa=wsignin1.0&wp=MBI_SSL"), req);
            };
            handleLoginError = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                _isLoggingIn = false;
                SkypeUtils.logErrMsg(" *** Error in skype login ***");
                if (callback != null)
                {
                    callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_ON_LOGIN, "", " *** Error during login ***")]);
                };
            };
            handleLogin = function (evt:HttpResponseEvent):void
            {
                var t:String;
                http.listener.unregister();
                http = null;
                try
                {
                    t = response.match(new RegExp('<input.*?id="t".*?value="(.*?)"'))[1];
                }
                catch(e:Error)
                {
                    SkypeUtils.logErrMsg(" *** Error invalid skype login ***");
                    _isLoggingIn = false;
                    loginFailCount++;
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INVALID_LOGIN, "", " *** Invalid login info ***")]);
                    };
                    return;
                };
                response = "";
                SkypeUtils.logMsg(" --> Successfully logged in to Skype");
                loginFailCount = 0;
                var postVars:URLVariables = new URLVariables();
                postVars.t = t;
                postVars.client_id = "578134";
                postVars.oauthPartner = "999";
                postVars.site_name = "lw.skype.com";
                postVars.redirect_uri = "https://web.skype.com";
                var v:ByteArray = new ByteArray();
                v.writeUTFBytes(postVars.toString());
                v.position = 0;
                req = new Post();
                http = new HttpClient();
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.body = v;
                req.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
                http.listener.onComplete = processSkypeToken;
                http.listener.onError = onTokenError;
                http.listener.onData = handleHttpData;
                http.request(new URI("https://login.skype.com/login/microsoft?client_id=578134&redirect_uri=https%3A%2F%2Fweb.skype.com"), req);
            };
            processSkypeToken = function (evt:HttpResponseEvent):void
            {
                var ex:Number;
                http.listener.unregister();
                http = null;
                try
                {
                    skypeToken = response.match(new RegExp('<input.*?name="skypetoken".*?value="(.*?)"'))[1];
                    ex = parseInt(response.match(new RegExp('<input.*?name="expires_in".*?value="(.*?)"'))[1]);
                    tokenExpiry = ((new Date().getTime() + (ex * 1000)) - 10000);
                }
                catch(e:Error)
                {
                    SkypeUtils.logErrMsg(" *** Error receiving skype token ***");
                    _isLoggingIn = false;
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INVALID_TOKEN_RESPONSE, "", " *** Received invalid token response ***")]);
                    };
                    return;
                };
                response = "";
                SkypeUtils.logMsg(" --> Successfully received skype token");
                if (skypeId == null)
                {
                    http = new HttpClient();
                    req = new Get();
                    req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                    req.addHeader("Accept-Encoding", "identity");
                    req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                    req.addHeader("X-SkypeToken", skypeToken);
                    http.listener.onComplete = processSkypeId;
                    http.listener.onError = processSkypeIdError;
                    http.listener.onData = handleHttpData;
                    http.request(new URI("https://api.skype.com/users/self/profile"), req);
                    return;
                };
                getSkypeRegToken();
            };
            onTokenError = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                SkypeUtils.logErrMsg(" *** Error getting skype token ***");
                _isLoggingIn = false;
                if (callback != null)
                {
                    callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_GETTING_TOKEN, "", " *** Cannot retrieve token ***")]);
                };
            };
            processSkypeId = function (evt:HttpResponseEvent):void
            {
                http.listener.unregister();
                http = null;
                try
                {
                    skypeId = response.match(new RegExp('"username":"(.*?)"'))[1];
                }
                catch(e:Error)
                {
                    SkypeUtils.logErrMsg(" *** Error getting skype Id ***");
                    _isLoggingIn = false;
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_GETTING_ID, "", " *** Failed to get ID ***")]);
                    };
                    return;
                };
                SkypeUtils.logMsg(" --> Received skype Id");
                getSkypeRegToken();
            };
            processSkypeIdError = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                SkypeUtils.logErrMsg(" *** Error getting skype Id ***");
                _isLoggingIn = false;
                if (callback != null)
                {
                    callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INVALID_ID_RESPONSE, "", " *** Failed while retrieving ID ***")]);
                };
            };
            var getSkypeRegToken:Function = function ():void
            {
                var _local_1:Number = new Date().getTime();
                var _local_2:String = ((("appId=msmsgs@msnmsgr.com; time=" + String(_local_1)) + "; lockAndKeyResponse=") + SkypeUtils.getMac256Hash(_local_1.toString()));
                http = new HttpClient();
                req = new Post();
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.contentType = "application/json";
                req.addHeader("LockAndKey", _local_2);
                req.addHeader("Authentication", ("skypetoken=" + skypeToken));
                response = "";
                var _local_3:ByteArray = new ByteArray();
                _local_3.writeUTFBytes('{"endpointFeatures": "Agent"}');
                _local_3.position = 0;
                req.body = _local_3;
                http.listener.onComplete = receiveRegToken;
                http.listener.onError = errorRegToken;
                http.listener.onData = handleHttpData;
                SkypeUtils.logMsg(" --> Getting Skype registration token");
                http.request(new URI(registrationURL), req);
            };
            errorRegToken = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                SkypeUtils.logErrMsg(" *** Error getting registration token ***");
                _isLoggingIn = false;
                if (callback != null)
                {
                    callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INVALID_REGISTRATION_RESPONSE, "", " *** Invalid response while registering login ***")]);
                };
            };
            receiveRegToken = function (evt:HttpResponseEvent):void
            {
                var locuri:URI;
                var regtokenstring:String;
                var loc:String;
                var endP:Array;
                var m:Array;
                var n:Array;
                http.listener.unregister();
                http = null;
                var endPointId:String;
                if (response.indexOf('"errorCode":752') != -1)
                {
                    locuri = new URI(evt.response.header.getValue("Location"));
                    locuri.makeAbsoluteURI(new URI(registrationURL));
                    registrationURL = locuri.toString();
                    getSkypeRegToken();
                    return;
                };
                try
                {
                    regtokenstring = evt.response.header.getValue("Set-RegistrationToken");
                    if (regtokenstring != null)
                    {
                        regToken = regtokenstring.match("registrationToken=(.*?);")[1];
                        endP = regtokenstring.match("endpointId=({[a-z0-9-]+})");
                        if (endP.length > 1)
                        {
                            endPointId = endP[1];
                        };
                    };
                    loc = Utils.trim(evt.response.header.getValue("Location"));
                    if (loc != null)
                    {
                        m = loc.match("(https://[^/]+/v1)/users/ME/endpoints(/(%7B[a-z0-9-]+%7D))?");
                        if (m[1] != "https://client-s.gateway.messenger.live.com/v1")
                        {
                            n = loc.split("/");
                            n.splice((n.length - ((m.length >= 3) ? 3 : 2)), ((m.length >= 2) ? 3 : 2));
                            msgsHost = n.join("/");
                        };
                        if (m.length >= 3)
                        {
                            if (m[2])
                            {
                                endPointId = m[2].replace("%7B", "{").replace("%7D", "}");
                            };
                        };
                    };
                    if (((endPointId == null) && (evt.response.code == "200")))
                    {
                        endPointId = com.adobe.serialization.json.JSON.decode(response)[0]["id"];
                    };
                }
                catch(e:Error)
                {
                    SkypeUtils.logErrMsg(" *** Error getting registration token ***");
                    _isLoggingIn = false;
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_GETTING_REGISTRATION, "", " *** Failed while retrieving registration response ***")]);
                    };
                    return;
                };
                if (msgsHost.indexOf("/users") == -1)
                {
                    msgsHost = (msgsHost + "/users");
                };
                SkypeUtils.logMsg(" --> Successfully received registration token");
                http = new HttpClient();
                req = new Post();
                response = "";
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.contentType = "application/json";
                req.addHeader("RegistrationToken", ("registrationToken=" + regToken));
                var v:ByteArray = new ByteArray();
                v.writeUTFBytes('{"publicInfo": {"nodeInfo": "xx", "version": "908/1.30.0.128", "type": 1, "skypeNameVersion": "skype.com", "capabilities": ""}, "privateInfo": {"epname": "skype"}, "type": "EndpointPresenceDoc", "id": "messagingService", "selfLink": "uri"}');
                v.position = 0;
                req.body = v;
                http.listener.onComplete = confirmConfig;
                http.listener.onError = loginError;
                SkypeUtils.logMsg(" --> Confirming registration token");
                http.request(new URI((((msgsHost + "/ME/endpoints/") + escape(endPointId)) + "/presenceDocs/messagingService")), req);
            };
            confirmConfig = function (_arg_1:HttpResponseEvent):void
            {
                http.listener.unregister();
                http = null;
                SkypeUtils.logMsg(" --> Confirmed registration token");
                http = new HttpClient();
                req = new Get();
                response = "";
                req.addHeader("Accept", "application/json");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.addHeader("RegistrationToken", ("registrationToken=" + regToken));
                http.listener.onComplete = finishLogin;
                http.listener.onError = loginError;
                http.listener.onData = handleHttpData;
                SkypeUtils.logMsg(" --> Getting all endpoints");
                http.request(new URI((msgsHost + "/ME/presenceDocs/messagingService?view=expanded")), req);
            };
            finishLogin = function (_arg_1:HttpResponseEvent):void
            {
                var _local_3:int;
                http.listener.unregister();
                http = null;
                var _local_2:Object = com.adobe.serialization.json.JSON.decode(response);
                if (_local_2.endpointPresenceDocs != undefined)
                {
                    skypeEndPoints = _local_2.endpointPresenceDocs;
                    _local_3 = 0;
                    while (_local_3 < skypeEndPoints.length)
                    {
                        skypeEndPoints[_local_3] = skypeEndPoints[_local_3].link.split("/")[7];
                        _local_3++;
                    };
                };
                SkypeUtils.logMsg(" --> Received all endpoints");
                SkypeUtils.logMsg(" --> Successfully finished skype login");
                _isLoggedIn = true;
                _isLoggingIn = false;
                username = un;
                password = pw;
                Utils.callLater(500, retrieveSkypeConversationIds);
                Utils.callLater(1500, initSendTimer);
                if (callback != null)
                {
                    callback.apply(null, [new SkypeResponse(SkypeConstants.OK_DEFAULT, ("Successfully logged into Skype as user " + un))]);
                };
            };
            loginError = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                _isLoggingIn = false;
                SkypeUtils.logErrMsg(" *** Error logging in to skype ***");
                if (callback != null)
                {
                    callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INVALID_LOGIN_RESPONSE, "", " *** Invalid response while waiting for login confirmation ***")]);
                };
            };
            processParamError = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                _isLoggingIn = false;
                SkypeUtils.logErrMsg(" *** Error initiating Skype login ***");
                if (_arg_1.type == SecurityErrorEvent.SECURITY_ERROR)
                {
                    SkypeUtils.logErrMsg(" *** You need to keep the bot in a trusted location for this to work ***");
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_GETTING_LOGIN_COMPLETE, "", " *** Login confirmation failed, bot needs to be in a trusted folder or use the standalone executable ***")]);
                    };
                }
                else
                {
                    if (callback != null)
                    {
                        callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_GETTING_LOGIN_COMPLETE, "", " *** Login confirmation failed for an unknown reason ***")]);
                    };
                };
            };
            handleHttpData = function (_arg_1:HttpDataEvent):void
            {
                response = (response + _arg_1.readUTFBytes());
            };
            http = new HttpClient();
            req = new Get();
            response = "";
            req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding", "identity");
            req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            http.listener.onComplete = processParams;
            http.listener.onError = processParamError;
            http.listener.onData = handleHttpData;
            SkypeUtils.logMsg(" --> Getting PPFT for skype login");
            http.request(new URI("https://login.skype.com/login/oauth/microsoft?client_id=578134&redirect_uri=https%3A%2F%2Fweb.skype.com"), req);
            return (new SkypeResponse(SkypeConstants.OK_DEFAULT, "Attempting login --> Getting PPFT for skype login"));
        }

        public static function getSkypeConversationId(_arg_1:String):String
        {
            var _local_2:String;
            for (_local_2 in conversationIds)
            {
                if (_local_2.indexOf(_arg_1) != -1)
                {
                    if ((new Date().getTime() - lastUpdatedConversationIds) > ((10 * 60) * 1000))
                    {
                        Utils.callLater(50, retrieveSkypeConversationIds);
                    };
                    return (conversationIds[_local_2]);
                };
            };
            retrieveSkypeConversationIds();
            return (null);
        }

        private static function retrieveSkypeConversationIds():void
        {
            var http:HttpClient;
            var req:HttpRequest;
            var response:String;
            var handleHttpData:Function;
            var handleIdError:Function;
            var handleIds:Function;
            if (isRetrievingConversationIds)
            {
                return;
            };
            isRetrievingConversationIds = true;
            var count:int;
            var getSkypeConversationIds:Function = function ():void
            {
                http = new HttpClient();
                req = new Get();
                response = "";
                req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                req.addHeader("Accept-Encoding", "identity");
                req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
                req.addHeader("RegistrationToken", ("registrationToken=" + regToken));
                http.listener.onComplete = handleIds;
                http.listener.onError = handleIdError;
                http.listener.onData = handleHttpData;
                http.request(new URI((msgsHost + "/ME/conversations?startTime=0&view=msnp24Equivalent&targetType=Passport|Skype|Lync|Thread|PSTN|Agent")), req);
            };
            handleHttpData = function (_arg_1:HttpDataEvent):void
            {
                response = (response + _arg_1.readUTFBytes());
            };
            handleIdError = function (_arg_1:ErrorEvent):void
            {
                http.listener.unregister();
                http = null;
                SkypeUtils.logErrMsg(" *** Error retrieving conversation ids ***");
                isRetrievingConversationIds = false;
            };
            handleIds = function (evt:HttpResponseEvent):void
            {
                var t:Object;
                var v:Object;
                http.listener.unregister();
                http = null;
                try
                {
                    t = com.adobe.serialization.json.JSON.decode(response);
                    for each (v in t["conversations"])
                    {
                        if (v.threadProperties != undefined)
                        {
                            if (conversationIds[v.threadProperties.topic] == undefined)
                            {
                                conversationIds[v.threadProperties.topic] = v.id;
                            };
                        };
                    };
                }
                catch(e:Error)
                {
                    SkypeUtils.logErrMsg(" *** Error retrieving conversation ids ***");
                    isRetrievingConversationIds = false;
                    return;
                };
                if (++count >= 20)
                {
                    isRetrievingConversationIds = false;
                    lastUpdatedConversationIds = new Date().getTime();
                    return;
                };
                getSkypeConversationIds();
            };
            (getSkypeConversationIds());
        }

        private static function sendMsg(msgObj:SkypeMsgBean):void
        {
            var response:String;
            var http:HttpClient;
            var timeoutHandler:Function;
            var timeout:Timer;
            trace((((("sending message with id " + msgObj.addedAt) + " to ") + ((msgObj.isGroup) ? "group " : "user ")) + msgObj.receiver));
            response = "";
            http = new HttpClient();
            var req:HttpRequest = new Post();
            req.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            req.addHeader("Accept-Encoding", "identity");
            req.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36");
            req.addHeader("RegistrationToken", ("registrationToken=" + regToken));
            req.addHeader("Content-Type", "application/json");
            var msg:String = com.adobe.serialization.json.JSON.encode({
                "content":SkypeUtils.processText(msgObj.message),
                "contenttype":"text",
                "messagetype":"RichText",
                "Has-Mentions":false,
                "skypeemoteoffset":null,
                "clientmessageid":msgObj.addedAt
            });
            var v:ByteArray = new ByteArray();
            v.writeUTFBytes(msg);
            v.position = 0;
            req.body = v;
            var handleSuccess:Function = function (_arg_1:HttpResponseEvent):void
            {
                timeout.stop();
                timeout.removeEventListener(TimerEvent.TIMER, timeoutHandler);
                timeout = null;
                http.listener.unregister();
                http = null;
                trace(response);
                trace(int(response.substring((response.indexOf("<ErrorCode>") + 11), response.indexOf("</ErrorCode>"))));
                trace(response.substring((response.indexOf("<Message>") + 9), response.indexOf("</Message>")));
                if (response.indexOf("<ErrorCode>-1</ErrorCode>") == -1)
                {
                    if (msgObj.callback != null)
                    {
                        msgObj.callback.apply(null, [new SkypeResponse(int(response.substring((response.indexOf("<ErrorCode>") + 11), response.indexOf("</ErrorCode>"))), response.substring((response.indexOf("<Message>") + 9), response.indexOf("</Message>")))]);
                    };
                }
                else
                {
                    if (msgObj.callback != null)
                    {
                        msgObj.callback.apply(null, [new SkypeResponse(SkypeConstants.OK_DEFAULT, "Successfully sent message")]);
                    };
                };
            };
            var handleError:Function = function (_arg_1:ErrorEvent):void
            {
                timeout.stop();
                timeout.removeEventListener(TimerEvent.TIMER, timeoutHandler);
                timeout = null;
                http.listener.unregister();
                http = null;
                SkypeUtils.logErrMsg((" *** Error sending skype message *** : " + String(_arg_1)));
                if (msgObj.callback != null)
                {
                    msgObj.callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_INVALID_SND_MSG_RESPONSE, "", " *** Failed while sending message ***")]);
                };
            };
            var handleHttpData:Function = function (_arg_1:HttpDataEvent):void
            {
                response = (response + _arg_1.readUTFBytes());
            };
            timeoutHandler = function (_arg_1:TimerEvent):void
            {
                timeout.stop();
                timeout.removeEventListener(TimerEvent.TIMER, timeoutHandler);
                timeout = null;
                SkypeUtils.logErrMsg(" *** Timeout occurred while waiting for response after sending skype message ***");
                if (msgObj.callback != null)
                {
                    msgObj.callback.apply(null, [new SkypeResponse(SkypeConstants.ERROR_SND_MSG_RESP_TIMEOUT, "", "Timeout occurred while waiting for response after sending skype message")]);
                };
            };
            http.listener.onComplete = handleSuccess;
            http.listener.onError = handleError;
            http.listener.onData = handleHttpData;
            if (msgObj.isGroup)
            {
                http.request(new URI((((msgsHost + "/ME/conversations/") + msgObj.receiver) + "/messages")), req);
            }
            else
            {
                http.request(new URI((((msgsHost + "/ME/conversations/8:") + msgObj.receiver) + "/messages")), req);
            };
            timeout = new Timer(30000, 1);
            timeout.addEventListener(TimerEvent.TIMER, timeoutHandler);
            timeout.start();
        }

        public static function isLoggingIn():Boolean
        {
            return (_isLoggingIn);
        }

        private static function onSendTimer(_arg_1:TimerEvent=null):void
        {
            var _local_4:String;
            if (msgQueue == null)
            {
                return;
            };
            var _local_2:int;
            while (_local_2 < msgQueue.length)
            {
                if ((new Date().getTime() - (msgQueue[_local_2] as SkypeMsgBean).addedAt) > ((10 * 60) * 1000))
                {
                    msgQueue.splice(_local_2--, 1);
                };
                _local_2++;
            };
            if (msgQueue.length == 0)
            {
                return;
            };
            if (((!(isLoggedIn())) || (_isLoggingIn)))
            {
                return;
            };
            var _local_3:SkypeMsgBean;
            _local_2 = 0;
            while (_local_2 < msgQueue.length)
            {
                if (!(((msgQueue[_local_2] as SkypeMsgBean).isGroup) && (isRetrievingConversationIds)))
                {
                    _local_3 = msgQueue.splice(_local_2, 1)[0];
                    break;
                };
                _local_2++;
            };
            if (_local_3 != null)
            {
                if (_local_3.isGroup)
                {
                    _local_4 = null;
                    if ((_local_4 = getSkypeConversationId(_local_3.receiver)) != null)
                    {
                        _local_3.receiver = _local_4;
                    }
                    else
                    {
                        SkypeUtils.logErrMsg(((" Error #" + SkypeConstants.ERROR_INVALID_OR_MISSING_GROUP_NAME) + "Invalid Skype group name. No matching group conversation could be found."));
                        return;
                    };
                };
                sendMsg(_local_3);
            };
        }

        private static function initSendTimer():void
        {
            if (sendTimer == null)
            {
                sendTimer = new Timer(100);
                sendTimer.addEventListener(TimerEvent.TIMER, onSendTimer);
            };
            if (!sendTimer.running)
            {
                sendTimer.start();
            };
        }

        private static function isUserLoggedIn(_arg_1:String):Boolean
        {
            return ((_arg_1 == username) && (isLoggedIn()));
        }

        public static function isLoggedIn():Boolean
        {
            var _local_1:Number = new Date().getTime();
            if (((tokenExpiry > 0) && (tokenExpiry <= _local_1)))
            {
                if (((!(_isLoggingIn)) && (loginFailCount < 5)))
                {
                    Utils.callLater(50, login, [username, password]);
                };
            };
            return (_isLoggedIn = ((_isLoggedIn) && (tokenExpiry > _local_1)));
        }


    }
}//package com.skype

