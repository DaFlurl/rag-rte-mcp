// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.URLUtil

package mx.utils
{
    import mx.messaging.config.LoaderConfig;

    public class URLUtil 
    {

        public static const SERVER_NAME_TOKEN:String = "{server.name}";
        public static const SERVER_PORT_TOKEN:String = "{server.port}";
        private static const SERVER_NAME_REGEX:RegExp = new RegExp("\\{server.name\\}", "g");
        private static const SERVER_PORT_REGEX:RegExp = new RegExp("\\{server.port\\}", "g");


        public static function hasUnresolvableTokens():Boolean
        {
            return (!(LoaderConfig.url == null));
        }

        public static function getServerName(_arg_1:String):String
        {
            var _local_2:String = getServerNameWithPort(_arg_1);
            var _local_3:int = _local_2.indexOf("]");
            _local_3 = ((_local_3 > -1) ? _local_2.indexOf(":", _local_3) : _local_2.indexOf(":"));
            if (_local_3 > 0)
            {
                _local_2 = _local_2.substring(0, _local_3);
            };
            return (_local_2);
        }

        public static function isHttpsURL(_arg_1:String):Boolean
        {
            return ((!(_arg_1 == null)) && (_arg_1.indexOf("https://") == 0));
        }

        private static function internalObjectToString(_arg_1:Object, _arg_2:String, _arg_3:String, _arg_4:Boolean):String
        {
            var _local_7:String;
            var _local_8:Object;
            var _local_9:String;
            var _local_5:* = "";
            var _local_6:Boolean = true;
            for (_local_7 in _arg_1)
            {
                if (_local_6)
                {
                    _local_6 = false;
                }
                else
                {
                    _local_5 = (_local_5 + _arg_2);
                };
                _local_8 = _arg_1[_local_7];
                _local_9 = ((_arg_3) ? ((_arg_3 + ".") + _local_7) : _local_7);
                if (_arg_4)
                {
                    _local_9 = encodeURIComponent(_local_9);
                };
                if ((_local_8 is String))
                {
                    _local_5 = (_local_5 + ((_local_9 + "=") + ((_arg_4) ? encodeURIComponent((_local_8 as String)) : _local_8)));
                }
                else
                {
                    if ((_local_8 is Number))
                    {
                        _local_8 = _local_8.toString();
                        if (_arg_4)
                        {
                            _local_8 = encodeURIComponent((_local_8 as String));
                        };
                        _local_5 = (_local_5 + ((_local_9 + "=") + _local_8));
                    }
                    else
                    {
                        if ((_local_8 is Boolean))
                        {
                            _local_5 = (_local_5 + ((_local_9 + "=") + ((_local_8) ? "true" : "false")));
                        }
                        else
                        {
                            if ((_local_8 is Array))
                            {
                                _local_5 = (_local_5 + internalArrayToString((_local_8 as Array), _arg_2, _local_9, _arg_4));
                            }
                            else
                            {
                                _local_5 = (_local_5 + internalObjectToString(_local_8, _arg_2, _local_9, _arg_4));
                            };
                        };
                    };
                };
            };
            return (_local_5);
        }

        public static function getFullURL(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Number;
            if (((!(_arg_2 == null)) && (!(URLUtil.isHttpURL(_arg_2)))))
            {
                if (_arg_2.indexOf("./") == 0)
                {
                    _arg_2 = _arg_2.substring(2);
                };
                if (URLUtil.isHttpURL(_arg_1))
                {
                    if (_arg_2.charAt(0) == "/")
                    {
                        _local_3 = _arg_1.indexOf("/", 8);
                        if (_local_3 == -1)
                        {
                            _local_3 = _arg_1.length;
                        };
                    }
                    else
                    {
                        _local_3 = (_arg_1.lastIndexOf("/") + 1);
                        if (_local_3 <= 8)
                        {
                            _arg_1 = (_arg_1 + "/");
                            _local_3 = _arg_1.length;
                        };
                    };
                    if (_local_3 > 0)
                    {
                        _arg_2 = (_arg_1.substring(0, _local_3) + _arg_2);
                    };
                };
            };
            return (_arg_2);
        }

        public static function getServerNameWithPort(_arg_1:String):String
        {
            var _local_2:int = (_arg_1.indexOf("/") + 2);
            var _local_3:int = _arg_1.indexOf("/", _local_2);
            return ((_local_3 == -1) ? _arg_1.substring(_local_2) : _arg_1.substring(_local_2, _local_3));
        }

        public static function replaceProtocol(_arg_1:String, _arg_2:String):String
        {
            return (_arg_1.replace(getProtocol(_arg_1), _arg_2));
        }

        public static function urisEqual(_arg_1:String, _arg_2:String):Boolean
        {
            if (((!(_arg_1 == null)) && (!(_arg_2 == null))))
            {
                _arg_1 = StringUtil.trim(_arg_1).toLowerCase();
                _arg_2 = StringUtil.trim(_arg_2).toLowerCase();
                if (_arg_1.charAt((_arg_1.length - 1)) != "/")
                {
                    _arg_1 = (_arg_1 + "/");
                };
                if (_arg_2.charAt((_arg_2.length - 1)) != "/")
                {
                    _arg_2 = (_arg_2 + "/");
                };
            };
            return (_arg_1 == _arg_2);
        }

        public static function getProtocol(_arg_1:String):String
        {
            var _local_2:int = _arg_1.indexOf("/");
            var _local_3:int = _arg_1.indexOf(":/");
            if (((_local_3 > -1) && (_local_3 < _local_2)))
            {
                return (_arg_1.substring(0, _local_3));
            };
            _local_3 = _arg_1.indexOf("::");
            if (((_local_3 > -1) && (_local_3 < _local_2)))
            {
                return (_arg_1.substring(0, _local_3));
            };
            return ("");
        }

        private static function internalArrayToString(_arg_1:Array, _arg_2:String, _arg_3:String, _arg_4:Boolean):String
        {
            var _local_9:Object;
            var _local_10:String;
            var _local_5:* = "";
            var _local_6:Boolean = true;
            var _local_7:int = _arg_1.length;
            var _local_8:int;
            while (_local_8 < _local_7)
            {
                if (_local_6)
                {
                    _local_6 = false;
                }
                else
                {
                    _local_5 = (_local_5 + _arg_2);
                };
                _local_9 = _arg_1[_local_8];
                _local_10 = ((_arg_3 + ".") + _local_8);
                if (_arg_4)
                {
                    _local_10 = encodeURIComponent(_local_10);
                };
                if ((_local_9 is String))
                {
                    _local_5 = (_local_5 + ((_local_10 + "=") + ((_arg_4) ? encodeURIComponent((_local_9 as String)) : _local_9)));
                }
                else
                {
                    if ((_local_9 is Number))
                    {
                        _local_9 = _local_9.toString();
                        if (_arg_4)
                        {
                            _local_9 = encodeURIComponent((_local_9 as String));
                        };
                        _local_5 = (_local_5 + ((_local_10 + "=") + _local_9));
                    }
                    else
                    {
                        if ((_local_9 is Boolean))
                        {
                            _local_5 = (_local_5 + ((_local_10 + "=") + ((_local_9) ? "true" : "false")));
                        }
                        else
                        {
                            if ((_local_9 is Array))
                            {
                                _local_5 = (_local_5 + internalArrayToString((_local_9 as Array), _arg_2, _local_10, _arg_4));
                            }
                            else
                            {
                                _local_5 = (_local_5 + internalObjectToString(_local_9, _arg_2, _local_10, _arg_4));
                            };
                        };
                    };
                };
                _local_8++;
            };
            return (_local_5);
        }

        public static function objectToString(_arg_1:Object, _arg_2:String=";", _arg_3:Boolean=true):String
        {
            var _local_4:String = internalObjectToString(_arg_1, _arg_2, null, _arg_3);
            return (_local_4);
        }

        public static function replaceTokens(_arg_1:String):String
        {
            var _local_4:String;
            var _local_5:String;
            var _local_6:uint;
            var _local_2:String = ((LoaderConfig.url == null) ? "" : LoaderConfig.url);
            if (_arg_1.indexOf(SERVER_NAME_TOKEN) > 0)
            {
                _local_4 = URLUtil.getProtocol(_local_2);
                _local_5 = "localhost";
                if (_local_4.toLowerCase() != "file")
                {
                    _local_5 = URLUtil.getServerName(_local_2);
                };
                _arg_1 = _arg_1.replace(SERVER_NAME_REGEX, _local_5);
            };
            var _local_3:int = _arg_1.indexOf(SERVER_PORT_TOKEN);
            if (_local_3 > 0)
            {
                _local_6 = URLUtil.getPort(_local_2);
                if (_local_6 > 0)
                {
                    _arg_1 = _arg_1.replace(SERVER_PORT_REGEX, _local_6);
                }
                else
                {
                    if (_arg_1.charAt((_local_3 - 1)) == ":")
                    {
                        _arg_1 = (_arg_1.substring(0, (_local_3 - 1)) + _arg_1.substring(_local_3));
                    };
                    _arg_1 = _arg_1.replace(SERVER_PORT_REGEX, "");
                };
            };
            return (_arg_1);
        }

        public static function getPort(_arg_1:String):uint
        {
            var _local_5:Number;
            var _local_2:String = getServerNameWithPort(_arg_1);
            var _local_3:int = _local_2.indexOf("]");
            _local_3 = ((_local_3 > -1) ? _local_2.indexOf(":", _local_3) : _local_2.indexOf(":"));
            var _local_4:uint;
            if (_local_3 > 0)
            {
                _local_5 = Number(_local_2.substring((_local_3 + 1)));
                if (!isNaN(_local_5))
                {
                    _local_4 = int(_local_5);
                };
            };
            return (_local_4);
        }

        public static function stringToObject(_arg_1:String, _arg_2:String=";", _arg_3:Boolean=true):Object
        {
            var _local_8:Array;
            var _local_9:String;
            var _local_10:Object;
            var _local_11:Object;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Object;
            var _local_15:String;
            var _local_16:String;
            var _local_17:Object;
            var _local_4:Object = {};
            var _local_5:Array = _arg_1.split(_arg_2);
            var _local_6:int = _local_5.length;
            var _local_7:int;
            while (_local_7 < _local_6)
            {
                _local_8 = _local_5[_local_7].split("=");
                _local_9 = _local_8[0];
                if (_arg_3)
                {
                    _local_9 = decodeURIComponent(_local_9);
                };
                _local_10 = _local_8[1];
                if (_arg_3)
                {
                    _local_10 = decodeURIComponent((_local_10 as String));
                };
                if (_local_10 == "true")
                {
                    _local_10 = true;
                }
                else
                {
                    if (_local_10 == "false")
                    {
                        _local_10 = false;
                    }
                    else
                    {
                        _local_14 = int(_local_10);
                        if (_local_14.toString() == _local_10)
                        {
                            _local_10 = _local_14;
                        }
                        else
                        {
                            _local_14 = Number(_local_10);
                            if (_local_14.toString() == _local_10)
                            {
                                _local_10 = _local_14;
                            };
                        };
                    };
                };
                _local_11 = _local_4;
                _local_8 = _local_9.split(".");
                _local_12 = _local_8.length;
                _local_13 = 0;
                while (_local_13 < (_local_12 - 1))
                {
                    _local_15 = _local_8[_local_13];
                    if (((_local_11[_local_15] == null) && (_local_13 < (_local_12 - 1))))
                    {
                        _local_16 = _local_8[(_local_13 + 1)];
                        _local_17 = int(_local_16);
                        if (_local_17.toString() == _local_16)
                        {
                            _local_11[_local_15] = [];
                        }
                        else
                        {
                            _local_11[_local_15] = {};
                        };
                    };
                    _local_11 = _local_11[_local_15];
                    _local_13++;
                };
                _local_11[_local_8[_local_13]] = _local_10;
                _local_7++;
            };
            return (_local_4);
        }

        public static function replacePort(_arg_1:String, _arg_2:uint):String
        {
            var _local_6:int;
            var _local_3:* = "";
            var _local_4:int = _arg_1.indexOf("]");
            if (_local_4 == -1)
            {
                _local_4 = _arg_1.indexOf(":");
            };
            var _local_5:int = _arg_1.indexOf(":", (_local_4 + 1));
            if (_local_5 > -1)
            {
                _local_6 = _arg_1.indexOf("/", ++_local_5);
                _local_3 = ((_arg_1.substring(0, _local_5) + _arg_2.toString()) + _arg_1.substring(_local_6, _arg_1.length));
            }
            else
            {
                _local_6 = _arg_1.indexOf("/", _local_4);
                if (_local_6 > -1)
                {
                    if (_arg_1.charAt((_local_6 + 1)) == "/")
                    {
                        _local_6 = _arg_1.indexOf("/", (_local_6 + 2));
                    };
                    if (_local_6 > 0)
                    {
                        _local_3 = (((_arg_1.substring(0, _local_6) + ":") + _arg_2.toString()) + _arg_1.substring(_local_6, _arg_1.length));
                    }
                    else
                    {
                        _local_3 = ((_arg_1 + ":") + _arg_2.toString());
                    };
                }
                else
                {
                    _local_3 = ((_arg_1 + ":") + _arg_2.toString());
                };
            };
            return (_local_3);
        }

        public static function isHttpURL(_arg_1:String):Boolean
        {
            return ((!(_arg_1 == null)) && ((_arg_1.indexOf("http://") == 0) || (_arg_1.indexOf("https://") == 0)));
        }


    }
}//package mx.utils

