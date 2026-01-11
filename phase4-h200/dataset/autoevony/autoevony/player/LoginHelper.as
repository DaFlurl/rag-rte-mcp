// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.player.LoginHelper

package autoevony.player
{
    import flash.net.URLVariables;
    import flash.utils.ByteArray;
    import com.adobe.crypto.SHA1;
    import com.evony.common.constants.CommonConstants;

    public class LoginHelper 
    {

        private static var instance:LoginHelper = new (LoginHelper)();
        private static var fbPwObj:URLVariables = new URLVariables();

        public var proxyPort:String = "";
        public var proxyPw:String = "";
        public var skypeUn:String = "";
        public var password:String = "";
        public var proxyUn:String = "";
        public var serverIP:String = "";
        private var _isFBLoggedIn:Boolean = false;
        public var proxyHost:String = "";
        public var loginType:String = "";
        private var _isEvonyLoggedIn:Boolean = false;
        public var proxyType:String = "";
        public var theme:String = "";
        public var server:String = "";
        public var sid:String;
        public var username:String = "";
        public var autoScript:Boolean = false;
        public var autoRun:Boolean = false;
        public var secCode:String = "";
        public var autoLoginMinTime:String = "";
        public var autoLoginMaxTime:String = "";
        public var autoLogin:Boolean = false;
        public var tokenExpires:Number;
        public var strserverAlias:String = "";
        public var skypePw:String = "";

        public function LoginHelper(_arg_1:Object=null)
        {
            var _local_2:String;
            super();
            if (_arg_1 == null)
            {
                return;
            };
            for each (_local_2 in ["username", "password", "secCode", "server", "serverIP", "proxyType", "proxyPort", "proxyHost", "proxyUn", "proxyPw", "autoRun", "autoScript", "autoLogin", "autoLoginMinTime", "autoLoginMaxTime", "loginType", "skypeUn", "skypePw", "theme"])
            {
                if (_arg_1.hasOwnProperty(_local_2))
                {
                    this[_local_2] = _arg_1[_local_2];
                };
            };
        }

        public static function getUrlParam(_arg_1:String, _arg_2:String):String
        {
            return (_arg_1.match(new RegExp((_arg_2 + '=(.*?)[&|"]')))[1]);
        }

        public static function decryptUrl(_arg_1:String):String
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:ByteArray = new ByteArray();
            var _local_5:int;
            while (_local_5 < (_arg_1.length / 2))
            {
                if (((_arg_1.charAt((2 * _local_5)) == "#") || (_arg_1.charAt((2 * _local_5)) == "&"))) break;
                if (((_arg_1.charAt((2 * _local_5)) >= "0") && (_arg_1.charAt((2 * _local_5)) <= "9")))
                {
                    _local_2 = Number(_arg_1.substr((2 * _local_5), 1));
                }
                else
                {
                    if (((_arg_1.charAt((2 * _local_5)) == "a") || (_arg_1.charAt((2 * _local_5)) == "A")))
                    {
                        _local_2 = 10;
                    }
                    else
                    {
                        if (((_arg_1.charAt((2 * _local_5)) == "b") || (_arg_1.charAt((2 * _local_5)) == "B")))
                        {
                            _local_2 = 11;
                        }
                        else
                        {
                            if (((_arg_1.charAt((2 * _local_5)) == "c") || (_arg_1.charAt((2 * _local_5)) == "C")))
                            {
                                _local_2 = 12;
                            }
                            else
                            {
                                if (((_arg_1.charAt((2 * _local_5)) == "d") || (_arg_1.charAt((2 * _local_5)) == "D")))
                                {
                                    _local_2 = 13;
                                }
                                else
                                {
                                    if (((_arg_1.charAt((2 * _local_5)) == "e") || (_arg_1.charAt((2 * _local_5)) == "E")))
                                    {
                                        _local_2 = 14;
                                    }
                                    else
                                    {
                                        if (((_arg_1.charAt((2 * _local_5)) == "f") || (_arg_1.charAt((2 * _local_5)) == "F")))
                                        {
                                            _local_2 = 15;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                if (((_arg_1.charAt(((2 * _local_5) + 1)) >= "0") && (_arg_1.charAt(((2 * _local_5) + 1)) <= "9")))
                {
                    _local_3 = Number(_arg_1.substr(((2 * _local_5) + 1), 1));
                }
                else
                {
                    if (((_arg_1.charAt(((2 * _local_5) + 1)) == "a") || (_arg_1.charAt(((2 * _local_5) + 1)) == "A")))
                    {
                        _local_3 = 10;
                    }
                    else
                    {
                        if (((_arg_1.charAt(((2 * _local_5) + 1)) == "b") || (_arg_1.charAt(((2 * _local_5) + 1)) == "B")))
                        {
                            _local_3 = 11;
                        }
                        else
                        {
                            if (((_arg_1.charAt(((2 * _local_5) + 1)) == "c") || (_arg_1.charAt(((2 * _local_5) + 1)) == "C")))
                            {
                                _local_3 = 12;
                            }
                            else
                            {
                                if (((_arg_1.charAt(((2 * _local_5) + 1)) == "d") || (_arg_1.charAt(((2 * _local_5) + 1)) == "D")))
                                {
                                    _local_3 = 13;
                                }
                                else
                                {
                                    if (((_arg_1.charAt(((2 * _local_5) + 1)) == "e") || (_arg_1.charAt(((2 * _local_5) + 1)) == "E")))
                                    {
                                        _local_3 = 14;
                                    }
                                    else
                                    {
                                        if (((_arg_1.charAt(((2 * _local_5) + 1)) == "f") || (_arg_1.charAt(((2 * _local_5) + 1)) == "F")))
                                        {
                                            _local_3 = 15;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                _local_4[_local_5] = ((_local_2 * 16) + _local_3);
                _local_5++;
            };
            var _local_6:String = _local_4.toString();
            trace(_local_6);
            return (_local_6);
        }

        public static function getInstance():LoginHelper
        {
            return (instance);
        }

        public static function _ag364(_arg_1:String):String
        {
            _arg_1 = _arg_1.toLowerCase();
            return (_arg_1.substr(0, 4) + SHA1.hash(("052xa" + _arg_1)).substr(0, 8));
        }


        public function getFbLoginObj():Object
        {
            if (!this.isEvonyLoggedIn())
            {
                return (null);
            };
            var _local_1:Object = new Object();
            _local_1[CommonConstants.LOGIN_PARAM_USER] = fbPwObj["fbuid"];
            _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = ("expires=" + fbPwObj["expires"]);
            if (((fbPwObj["secret"]) && (fbPwObj["secret"].length > 0)))
            {
                _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = ((_local_1[CommonConstants.LOGIN_PARAM_PASSWORD] + "secret=") + fbPwObj["secret"]);
            };
            _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = (_local_1[CommonConstants.LOGIN_PARAM_PASSWORD] + ("session_key=" + fbPwObj["session_key"]));
            if (((fbPwObj["ss"]) && (fbPwObj["ss"].length > 0)))
            {
                _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = ((_local_1[CommonConstants.LOGIN_PARAM_PASSWORD] + "ss=") + fbPwObj["ss"]);
            };
            if (((fbPwObj["user"]) && (fbPwObj["user"].length > 0)))
            {
                _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = ((_local_1[CommonConstants.LOGIN_PARAM_PASSWORD] + "user=") + fbPwObj["user"]);
            };
            if (((fbPwObj["uid"]) && (fbPwObj["uid"].length > 0)))
            {
                _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = ((_local_1[CommonConstants.LOGIN_PARAM_PASSWORD] + "uid=") + fbPwObj["uid"]);
            };
            if (((fbPwObj["base_domain"]) && (fbPwObj["base_domain"].length > 0)))
            {
                _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = (("base_domain=" + fbPwObj["base_domain"]) + _local_1[CommonConstants.LOGIN_PARAM_PASSWORD]);
            };
            if (((fbPwObj["access_token"]) && (fbPwObj["access_token"].length > 0)))
            {
                _local_1[CommonConstants.LOGIN_PARAM_PASSWORD] = (("access_token=" + fbPwObj["access_token"]) + _local_1[CommonConstants.LOGIN_PARAM_PASSWORD]);
            };
            _local_1[CommonConstants.LOGIN_SSO_PARAM] = fbPwObj["fb_sig"];
            return (_local_1);
        }

        public function isEvonyLoggedIn():Boolean
        {
            if (new Date().getTime() > this.tokenExpires)
            {
                this._isEvonyLoggedIn = false;
            };
            return (this._isEvonyLoggedIn);
        }

        public function setIsEvonyLoggedIn(_arg_1:Boolean):void
        {
            this._isEvonyLoggedIn = _arg_1;
        }

        public function isFBLoggedIn():Boolean
        {
            return (this._isFBLoggedIn);
        }

        public function setIsFBLoggedIn(_arg_1:Boolean):void
        {
            this._isFBLoggedIn = _arg_1;
        }

        public function setFbPwObj(_arg_1:String):void
        {
            var _local_4:String;
            var _local_2:Array = decryptUrl(_arg_1).split("&");
            var _local_3:Array = new Array();
            for each (_local_4 in _local_2)
            {
                if (_local_4.indexOf("=") != -1)
                {
                    _local_3.push(_local_4);
                };
            };
            fbPwObj = new URLVariables(_local_3.join("&"));
        }

        public function isFbLoginType():Boolean
        {
            return (this.loginType == "fb");
        }

        public function getHashedEvonyPw():String
        {
            return ((this.isFbLoginType()) ? "DELETE" : SHA1.hash(this.password));
        }


    }
}//package autoevony.player

