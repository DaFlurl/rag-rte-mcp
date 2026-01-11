// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.UIDUtil

package mx.utils
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import mx.core.IUID;
    import mx.core.IUIComponent;
    import mx.core.IPropertyChangeNotifier;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class UIDUtil 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static const ALPHA_CHAR_CODES:Array = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];
        private static var uidDictionary:Dictionary = new Dictionary(true);


        public static function fromByteArray(_arg_1:ByteArray):String
        {
            var _local_2:Array;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:int;
            if ((((!(_arg_1 == null)) && (_arg_1.length >= 16)) && (_arg_1.bytesAvailable >= 16)))
            {
                _local_2 = new Array(36);
                _local_3 = 0;
                _local_4 = 0;
                while (_local_4 < 16)
                {
                    if (((((_local_4 == 4) || (_local_4 == 6)) || (_local_4 == 8)) || (_local_4 == 10)))
                    {
                        var _local_6:* = _local_3++;
                        _local_2[_local_6] = 45;
                    };
                    _local_5 = _arg_1.readByte();
                    _local_6 = _local_3++;
                    _local_2[_local_6] = ALPHA_CHAR_CODES[((_local_5 & 0xF0) >>> 4)];
                    var _local_7:* = _local_3++;
                    _local_2[_local_7] = ALPHA_CHAR_CODES[(_local_5 & 0x0F)];
                    _local_4++;
                };
                return (String.fromCharCode.apply(null, _local_2));
            };
            return (null);
        }

        public static function isUID(_arg_1:String):Boolean
        {
            var _local_2:uint;
            var _local_3:Number;
            if (((!(_arg_1 == null)) && (_arg_1.length == 36)))
            {
                _local_2 = 0;
                while (_local_2 < 36)
                {
                    _local_3 = _arg_1.charCodeAt(_local_2);
                    if (((((_local_2 == 8) || (_local_2 == 13)) || (_local_2 == 18)) || (_local_2 == 23)))
                    {
                        if (_local_3 != 45)
                        {
                            return (false);
                        };
                    }
                    else
                    {
                        if ((((_local_3 < 48) || (_local_3 > 70)) || ((_local_3 > 57) && (_local_3 < 65))))
                        {
                            return (false);
                        };
                    };
                    _local_2++;
                };
                return (true);
            };
            return (false);
        }

        public static function createUID():String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_1:Array = new Array(36);
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < 8)
            {
                var _local_7:* = _local_2++;
                _local_1[_local_7] = ALPHA_CHAR_CODES[Math.floor((Math.random() * 16))];
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < 3)
            {
                _local_7 = _local_2++;
                _local_1[_local_7] = 45;
                _local_4 = 0;
                while (_local_4 < 4)
                {
                    var _local_8:* = _local_2++;
                    _local_1[_local_8] = ALPHA_CHAR_CODES[Math.floor((Math.random() * 16))];
                    _local_4++;
                };
                _local_3++;
            };
            _local_7 = _local_2++;
            _local_1[_local_7] = 45;
            var _local_5:Number = new Date().getTime();
            var _local_6:String = ("0000000" + _local_5.toString(16).toUpperCase()).substr(-8);
            _local_3 = 0;
            while (_local_3 < 8)
            {
                _local_8 = _local_2++;
                _local_1[_local_8] = _local_6.charCodeAt(_local_3);
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < 4)
            {
                _local_8 = _local_2++;
                _local_1[_local_8] = ALPHA_CHAR_CODES[Math.floor((Math.random() * 16))];
                _local_3++;
            };
            return (String.fromCharCode.apply(null, _local_1));
        }

        public static function toByteArray(_arg_1:String):ByteArray
        {
            var _local_2:ByteArray;
            var _local_3:uint;
            var _local_4:String;
            var _local_5:uint;
            var _local_6:uint;
            if (isUID(_arg_1))
            {
                _local_2 = new ByteArray();
                _local_3 = 0;
                while (_local_3 < _arg_1.length)
                {
                    _local_4 = _arg_1.charAt(_local_3);
                    if (_local_4 != "-")
                    {
                        _local_5 = getDigit(_local_4);
                        _local_3++;
                        _local_6 = getDigit(_arg_1.charAt(_local_3));
                        _local_2.writeByte((((_local_5 << 4) | _local_6) & 0xFF));
                    };
                    _local_3++;
                };
                _local_2.position = 0;
                return (_local_2);
            };
            return (null);
        }

        private static function getDigit(_arg_1:String):uint
        {
            switch (_arg_1)
            {
                case "A":
                case "a":
                    return (10);
                case "B":
                case "b":
                    return (11);
                case "C":
                case "c":
                    return (12);
                case "D":
                case "d":
                    return (13);
                case "E":
                case "e":
                    return (14);
                case "F":
                case "f":
                    return (15);
                default:
                    return (new uint(_arg_1));
            };
        }

        public static function getUID(item:Object):String
        {
            var result:String;
            var xitem:XML;
            var nodeKind:String;
            var notificationFunction:Function;
            result = null;
            if (item == null)
            {
                return (result);
            };
            if ((item is IUID))
            {
                result = IUID(item).uid;
                if (((result == null) || (result.length == 0)))
                {
                    result = createUID();
                    IUID(item).uid = result;
                };
            }
            else
            {
                if (((item is IPropertyChangeNotifier) && (!(item is IUIComponent))))
                {
                    result = IPropertyChangeNotifier(item).uid;
                    if (((result == null) || (result.length == 0)))
                    {
                        result = createUID();
                        IPropertyChangeNotifier(item).uid = result;
                    };
                }
                else
                {
                    if ((item is String))
                    {
                        return (item as String);
                    };
                    try
                    {
                        if (((item is XMLList) && (item.length == 1)))
                        {
                            item = item[0];
                        };
                        if ((item is XML))
                        {
                            xitem = XML(item);
                            nodeKind = xitem.nodeKind();
                            if (((nodeKind == "text") || (nodeKind == "attribute")))
                            {
                                return (xitem.toString());
                            };
                            notificationFunction = xitem.notification();
                            if (!(notificationFunction is Function))
                            {
                                notificationFunction = XMLNotifier.initializeXMLForNotification();
                                xitem.setNotification(notificationFunction);
                            };
                            if (notificationFunction["uid"] == undefined)
                            {
                                result = (notificationFunction["uid"] = createUID());
                            };
                            result = notificationFunction["uid"];
                        }
                        else
                        {
                            if (("mx_internal_uid" in item))
                            {
                                return (item.mx_internal_uid);
                            };
                            if (("uid" in item))
                            {
                                return (item.uid);
                            };
                            result = uidDictionary[item];
                            if (!result)
                            {
                                result = createUID();
                                try
                                {
                                    item.mx_internal_uid = result;
                                }
                                catch(e:Error)
                                {
                                    uidDictionary[item] = result;
                                };
                            };
                        };
                    }
                    catch(e:Error)
                    {
                        result = item.toString();
                    };
                };
            };
            return (result);
        }


    }
}//package mx.utils

