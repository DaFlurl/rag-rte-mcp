// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.xml.SimpleXMLDecoder

package mx.rpc.xml
{
    import flash.xml.XMLNode;
    import flash.xml.XMLNodeType;
    import mx.utils.ObjectProxy;
    import mx.collections.ArrayCollection;

    public class SimpleXMLDecoder 
    {

        private var makeObjectsBindable:Boolean;

        public function SimpleXMLDecoder(_arg_1:Boolean=false)
        {
            this.makeObjectsBindable = _arg_1;
        }

        public static function getLocalName(_arg_1:XMLNode):String
        {
            var _local_2:String = _arg_1.nodeName;
            var _local_3:int = _local_2.indexOf(":");
            if (_local_3 != -1)
            {
                _local_2 = _local_2.substring((_local_3 + 1));
            };
            return (_local_2);
        }

        public static function simpleType(_arg_1:Object):Object
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:Object = _arg_1;
            if (_arg_1 != null)
            {
                if (((_arg_1 is String) && (String(_arg_1) == "")))
                {
                    _local_2 = _arg_1.toString();
                }
                else
                {
                    if (((((isNaN(Number(_arg_1))) || (_arg_1.charAt(0) == "0")) || ((_arg_1.charAt(0) == "-") && (_arg_1.charAt(1) == "0"))) || (_arg_1.charAt((_arg_1.length - 1)) == "E")))
                    {
                        _local_3 = _arg_1.toString();
                        _local_4 = _local_3.toLowerCase();
                        if (_local_4 == "true")
                        {
                            _local_2 = true;
                        }
                        else
                        {
                            if (_local_4 == "false")
                            {
                                _local_2 = false;
                            }
                            else
                            {
                                _local_2 = _local_3;
                            };
                        };
                    }
                    else
                    {
                        _local_2 = Number(_arg_1);
                    };
                };
            };
            return (_local_2);
        }


        public function decodeXML(_arg_1:XMLNode):Object
        {
            var _local_2:Object;
            var _local_6:String;
            var _local_7:uint;
            var _local_8:XMLNode;
            var _local_9:String;
            var _local_10:Object;
            var _local_11:Object;
            var _local_3:Boolean;
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_4:Array = _arg_1.childNodes;
            if (((_local_4.length == 1) && (_local_4[0].nodeType == XMLNodeType.TEXT_NODE)))
            {
                _local_3 = true;
                _local_2 = SimpleXMLDecoder.simpleType(_local_4[0].nodeValue);
            }
            else
            {
                if (_local_4.length > 0)
                {
                    _local_2 = {};
                    if (makeObjectsBindable)
                    {
                        _local_2 = new ObjectProxy(_local_2);
                    };
                    _local_7 = 0;
                    while (_local_7 < _local_4.length)
                    {
                        _local_8 = _local_4[_local_7];
                        if (_local_8.nodeType == XMLNodeType.ELEMENT_NODE)
                        {
                            _local_9 = getLocalName(_local_8);
                            _local_10 = decodeXML(_local_8);
                            _local_11 = _local_2[_local_9];
                            if (_local_11 != null)
                            {
                                if ((_local_11 is Array))
                                {
                                    _local_11.push(_local_10);
                                }
                                else
                                {
                                    if ((_local_11 is ArrayCollection))
                                    {
                                        _local_11.source.push(_local_10);
                                    }
                                    else
                                    {
                                        _local_11 = [_local_11];
                                        _local_11.push(_local_10);
                                        if (makeObjectsBindable)
                                        {
                                            _local_11 = new ArrayCollection((_local_11 as Array));
                                        };
                                        _local_2[_local_9] = _local_11;
                                    };
                                };
                            }
                            else
                            {
                                _local_2[_local_9] = _local_10;
                            };
                        };
                        _local_7++;
                    };
                };
            };
            var _local_5:Object = _arg_1.attributes;
            for (_local_6 in _local_5)
            {
                if (!((_local_6 == "xmlns") || (!(_local_6.indexOf("xmlns:") == -1))))
                {
                    if (_local_2 == null)
                    {
                        _local_2 = {};
                        if (makeObjectsBindable)
                        {
                            _local_2 = new ObjectProxy(_local_2);
                        };
                    };
                    if (((_local_3) && (!(_local_2 is ComplexString))))
                    {
                        _local_2 = new ComplexString(_local_2.toString());
                        _local_3 = false;
                    };
                    _local_2[_local_6] = SimpleXMLDecoder.simpleType(_local_5[_local_6]);
                };
            };
            return (_local_2);
        }


    }
}//package mx.rpc.xml

