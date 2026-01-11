// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.xml.SimpleXMLEncoder

package mx.rpc.xml
{
    import flash.xml.XMLDocument;
    import flash.xml.XMLNode;
    import mx.utils.ObjectUtil;

    public class SimpleXMLEncoder 
    {

        private static const NUMBER_TYPE:uint = 0;
        private static const STRING_TYPE:uint = 1;
        private static const OBJECT_TYPE:uint = 2;
        private static const DATE_TYPE:uint = 3;
        private static const BOOLEAN_TYPE:uint = 4;
        private static const XML_TYPE:uint = 5;
        private static const ARRAY_TYPE:uint = 6;
        private static const MAP_TYPE:uint = 7;
        private static const ANY_TYPE:uint = 8;
        private static const ROWSET_TYPE:uint = 11;
        private static const QBEAN_TYPE:uint = 12;
        private static const DOC_TYPE:uint = 13;
        private static const SCHEMA_TYPE:uint = 14;
        private static const FUNCTION_TYPE:uint = 15;
        private static const ELEMENT_TYPE:uint = 16;
        private static const BASE64_BINARY_TYPE:uint = 17;
        private static const HEX_BINARY_TYPE:uint = 18;
        private static const CLASS_INFO_OPTIONS:Object = {
            "includeReadOnly":false,
            "includeTransient":false
        };

        private var myXMLDoc:XMLDocument;

        public function SimpleXMLEncoder(_arg_1:XMLDocument)
        {
            this.myXMLDoc = ((_arg_1) ? _arg_1 : new XMLDocument());
        }

        internal static function encodeDate(_arg_1:Date, _arg_2:String):String
        {
            var _local_4:Number;
            var _local_3:String = new String();
            if (((_arg_2 == "dateTime") || (_arg_2 == "date")))
            {
                _local_3 = _local_3.concat(_arg_1.getUTCFullYear(), "-");
                _local_4 = (_arg_1.getUTCMonth() + 1);
                if (_local_4 < 10)
                {
                    _local_3 = _local_3.concat("0");
                };
                _local_3 = _local_3.concat(_local_4, "-");
                _local_4 = _arg_1.getUTCDate();
                if (_local_4 < 10)
                {
                    _local_3 = _local_3.concat("0");
                };
                _local_3 = _local_3.concat(_local_4);
            };
            if (_arg_2 == "dateTime")
            {
                _local_3 = _local_3.concat("T");
            };
            if (((_arg_2 == "dateTime") || (_arg_2 == "time")))
            {
                _local_4 = _arg_1.getUTCHours();
                if (_local_4 < 10)
                {
                    _local_3 = _local_3.concat("0");
                };
                _local_3 = _local_3.concat(_local_4, ":");
                _local_4 = _arg_1.getUTCMinutes();
                if (_local_4 < 10)
                {
                    _local_3 = _local_3.concat("0");
                };
                _local_3 = _local_3.concat(_local_4, ":");
                _local_4 = _arg_1.getUTCSeconds();
                if (_local_4 < 10)
                {
                    _local_3 = _local_3.concat("0");
                };
                _local_3 = _local_3.concat(_local_4, ".");
                _local_4 = _arg_1.getUTCMilliseconds();
                if (_local_4 < 10)
                {
                    _local_3 = _local_3.concat("00");
                }
                else
                {
                    if (_local_4 < 100)
                    {
                        _local_3 = _local_3.concat("0");
                    };
                };
                _local_3 = _local_3.concat(_local_4);
            };
            return (_local_3.concat("Z"));
        }


        public function encodeValue(_arg_1:Object, _arg_2:QName, _arg_3:XMLNode):XMLNode
        {
            var _local_4:XMLNode;
            var _local_6:Object;
            var _local_7:Array;
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:String;
            var _local_11:QName;
            var _local_12:uint;
            var _local_13:QName;
            var _local_14:uint;
            var _local_15:String;
            var _local_16:XMLNode;
            var _local_17:String;
            var _local_18:String;
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_5:uint = getDataTypeFromObject(_arg_1);
            if (_local_5 == SimpleXMLEncoder.FUNCTION_TYPE)
            {
                return (null);
            };
            if (_local_5 == SimpleXMLEncoder.XML_TYPE)
            {
                _local_4 = _arg_1.cloneNode(true);
                _arg_3.appendChild(_local_4);
                return (_local_4);
            };
            _local_4 = myXMLDoc.createElement("foo");
            _local_4.nodeName = _arg_2.localName;
            _arg_3.appendChild(_local_4);
            if (_local_5 == SimpleXMLEncoder.OBJECT_TYPE)
            {
                _local_6 = ObjectUtil.getClassInfo(_arg_1, null, CLASS_INFO_OPTIONS);
                _local_7 = _local_6.properties;
                _local_8 = _local_7.length;
                _local_9 = 0;
                while (_local_9 < _local_8)
                {
                    _local_10 = _local_7[_local_9];
                    _local_11 = new QName("", _local_10);
                    encodeValue(_arg_1[_local_10], _local_11, _local_4);
                    _local_9++;
                };
            }
            else
            {
                if (_local_5 == SimpleXMLEncoder.ARRAY_TYPE)
                {
                    _local_12 = _arg_1.length;
                    _local_13 = new QName("", "item");
                    _local_14 = 0;
                    while (_local_14 < _local_12)
                    {
                        encodeValue(_arg_1[_local_14], _local_13, _local_4);
                        _local_14++;
                    };
                }
                else
                {
                    if (_local_5 == SimpleXMLEncoder.DATE_TYPE)
                    {
                        _local_15 = encodeDate((_arg_1 as Date), "dateTime");
                    }
                    else
                    {
                        if (_local_5 == SimpleXMLEncoder.NUMBER_TYPE)
                        {
                            if (_arg_1 == Number.POSITIVE_INFINITY)
                            {
                                _local_15 = "INF";
                            }
                            else
                            {
                                if (_arg_1 == Number.NEGATIVE_INFINITY)
                                {
                                    _local_15 = "-INF";
                                }
                                else
                                {
                                    _local_17 = _arg_1.toString();
                                    _local_18 = _local_17.substr(0, 2);
                                    if (((_local_18 == "0X") || (_local_18 == "0x")))
                                    {
                                        _local_15 = parseInt(_local_17).toString();
                                    }
                                    else
                                    {
                                        _local_15 = _local_17;
                                    };
                                };
                            };
                        }
                        else
                        {
                            _local_15 = _arg_1.toString();
                        };
                    };
                    _local_16 = myXMLDoc.createTextNode(_local_15);
                    _local_4.appendChild(_local_16);
                };
            };
            return (_local_4);
        }

        private function getDataTypeFromObject(_arg_1:Object):uint
        {
            if ((_arg_1 is Number))
            {
                return (SimpleXMLEncoder.NUMBER_TYPE);
            };
            if ((_arg_1 is Boolean))
            {
                return (SimpleXMLEncoder.BOOLEAN_TYPE);
            };
            if ((_arg_1 is String))
            {
                return (SimpleXMLEncoder.STRING_TYPE);
            };
            if ((_arg_1 is XMLDocument))
            {
                return (SimpleXMLEncoder.XML_TYPE);
            };
            if ((_arg_1 is Date))
            {
                return (SimpleXMLEncoder.DATE_TYPE);
            };
            if ((_arg_1 is Array))
            {
                return (SimpleXMLEncoder.ARRAY_TYPE);
            };
            if ((_arg_1 is Function))
            {
                return (SimpleXMLEncoder.FUNCTION_TYPE);
            };
            if ((_arg_1 is Object))
            {
                return (SimpleXMLEncoder.OBJECT_TYPE);
            };
            return (SimpleXMLEncoder.STRING_TYPE);
        }


    }
}//package mx.rpc.xml

