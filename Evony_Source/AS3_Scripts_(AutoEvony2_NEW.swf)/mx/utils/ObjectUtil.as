// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.ObjectUtil

package mx.utils
{
    import flash.xml.XMLNode;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import mx.collections.IList;
    import flash.utils.ByteArray;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ObjectUtil 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var defaultToStringExcludes:Array = ["password", "credentials"];
        private static var refCount:int = 0;
        private static var CLASS_INFO_CACHE:Object = {};


        public static function isSimple(_arg_1:Object):Boolean
        {
            var _local_2:* = typeof(_arg_1);
            switch (_local_2)
            {
                case "number":
                case "string":
                case "boolean":
                    return (true);
                case "object":
                    return ((_arg_1 is Date) || (_arg_1 is Array));
            };
            return (false);
        }

        private static function internalToString(value:Object, indent:int=0, refs:Dictionary=null, namespaceURIs:Array=null, exclude:Array=null):String
        {
            var str:String;
            var classInfo:Object;
            var properties:Array;
            var isArray:Boolean;
            var isDict:Boolean;
            var prop:* = undefined;
            var j:int;
            var id:Object;
            var type:String = ((value == null) ? "null" : typeof(value));
            switch (type)
            {
                case "boolean":
                case "number":
                    return (value.toString());
                case "string":
                    return (('"' + value.toString()) + '"');
                case "object":
                    if ((value is Date))
                    {
                        return (value.toString());
                    };
                    if ((value is XMLNode))
                    {
                        return (value.toString());
                    };
                    if ((value is Class))
                    {
                        return (("(" + getQualifiedClassName(value)) + ")");
                    };
                    classInfo = getClassInfo(value, exclude, {
                        "includeReadOnly":true,
                        "uris":namespaceURIs
                    });
                    properties = classInfo.properties;
                    str = (("(" + classInfo.name) + ")");
                    if (refs == null)
                    {
                        refs = new Dictionary(true);
                    };
                    try
                    {
                        id = refs[value];
                        if (id != null)
                        {
                            str = (str + ("#" + int(id)));
                            return (str);
                        };
                    }
                    catch(e:Error)
                    {
                        return (String(value));
                    };
                    if (value != null)
                    {
                        str = (str + ("#" + refCount.toString()));
                        refs[value] = refCount;
                        refCount++;
                    };
                    isArray = (value is Array);
                    isDict = (value is Dictionary);
                    indent = (indent + 2);
                    j = 0;
                    while (j < properties.length)
                    {
                        str = newline(str, indent);
                        prop = properties[j];
                        if (isArray)
                        {
                            str = (str + "[");
                        }
                        else
                        {
                            if (isDict)
                            {
                                str = (str + "{");
                            };
                        };
                        if (isDict)
                        {
                            str = (str + internalToString(prop, indent, refs, namespaceURIs, exclude));
                        }
                        else
                        {
                            str = (str + prop.toString());
                        };
                        if (isArray)
                        {
                            str = (str + "] ");
                        }
                        else
                        {
                            if (isDict)
                            {
                                str = (str + "} = ");
                            }
                            else
                            {
                                str = (str + " = ");
                            };
                        };
                        try
                        {
                            str = (str + internalToString(value[prop], indent, refs, namespaceURIs, exclude));
                        }
                        catch(e:Error)
                        {
                            str = (str + "?");
                        };
                        j = (j + 1);
                    };
                    indent = (indent - 2);
                    return (str);
                case "xml":
                    return (value.toXMLString());
                default:
                    return (("(" + type) + ")");
            };
        }

        public static function getClassInfo(obj:Object, excludes:Array=null, options:Object=null):Object
        {
            var n:int;
            var i:int;
            var result:Object;
            var cacheKey:String;
            var className:String;
            var classAlias:String;
            var properties:XMLList;
            var prop:XML;
            var metadataInfo:Object;
            var classInfo:XML;
            var numericIndex:Boolean;
            var key:* = undefined;
            var p:String;
            var pi:Number;
            var uris:Array;
            var uri:String;
            var qName:QName;
            var j:int;
            if ((obj is ObjectProxy))
            {
                obj = ObjectProxy(obj).object_proxy::object;
            };
            if (options == null)
            {
                options = {
                    "includeReadOnly":true,
                    "uris":null,
                    "includeTransient":true
                };
            };
            var propertyNames:Array = [];
            var dynamic:Boolean;
            if (typeof(obj) == "xml")
            {
                className = "XML";
                properties = obj.text();
                if (properties.length())
                {
                    propertyNames.push("*");
                };
                properties = obj.attributes();
            }
            else
            {
                classInfo = DescribeTypeCache.describeType(obj).typeDescription;
                className = classInfo.@name.toString();
                classAlias = classInfo.@alias.toString();
                dynamic = (classInfo.@isDynamic.toString() == "true");
                if (options.includeReadOnly)
                {
                    properties = (classInfo..accessor.(@access != "writeonly") + classInfo..variable);
                }
                else
                {
                    properties = (classInfo..accessor.(@access == "readwrite") + classInfo..variable);
                };
                numericIndex = false;
            };
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                result = CLASS_INFO_CACHE[cacheKey];
                if (result != null)
                {
                    return (result);
                };
            };
            result = {};
            result["name"] = className;
            result["alias"] = classAlias;
            result["properties"] = propertyNames;
            result["dynamic"] = dynamic;
            result["metadata"] = (metadataInfo = recordMetadata(properties));
            var excludeObject:Object = {};
            if (excludes)
            {
                n = excludes.length;
                i = 0;
                while (i < n)
                {
                    excludeObject[excludes[i]] = 1;
                    i = (i + 1);
                };
            };
            var isArray:Boolean = (className == "Array");
            var isDict:Boolean = (className == "flash.utils::Dictionary");
            if (isDict)
            {
                for (key in obj)
                {
                    propertyNames.push(key);
                };
            }
            else
            {
                if (dynamic)
                {
                    for (p in obj)
                    {
                        if (excludeObject[p] != 1)
                        {
                            if (isArray)
                            {
                                pi = parseInt(p);
                                if (isNaN(pi))
                                {
                                    propertyNames.push(new QName("", p));
                                }
                                else
                                {
                                    propertyNames.push(pi);
                                };
                            }
                            else
                            {
                                propertyNames.push(new QName("", p));
                            };
                        };
                    };
                    numericIndex = ((isArray) && (!(isNaN(Number(p)))));
                };
            };
            if (!(((isArray) || (isDict)) || (className == "Object")))
            {
                if (className == "XML")
                {
                    n = properties.length();
                    i = 0;
                    while (i < n)
                    {
                        p = properties[i].name();
                        if (excludeObject[p] != 1)
                        {
                            propertyNames.push(new QName("", ("@" + p)));
                        };
                        i = (i + 1);
                    };
                }
                else
                {
                    n = properties.length();
                    uris = options.uris;
                    i = 0;
                    while (i < n)
                    {
                        prop = properties[i];
                        p = prop.@name.toString();
                        uri = prop.@uri.toString();
                        if (excludeObject[p] != 1)
                        {
                            if (!((!(options.includeTransient)) && (internalHasMetadata(metadataInfo, p, "Transient"))))
                            {
                                if (uris != null)
                                {
                                    if (((uris.length == 1) && (uris[0] == "*")))
                                    {
                                        qName = new QName(uri, p);
                                        try
                                        {
                                            obj[qName];
                                            propertyNames.push();
                                        }
                                        catch(e:Error)
                                        {
                                        };
                                    }
                                    else
                                    {
                                        j = 0;
                                        while (j < uris.length)
                                        {
                                            uri = uris[j];
                                            if (prop.@uri.toString() == uri)
                                            {
                                                qName = new QName(uri, p);
                                                try
                                                {
                                                    obj[qName];
                                                    propertyNames.push(qName);
                                                }
                                                catch(e:Error)
                                                {
                                                };
                                            };
                                            j = (j + 1);
                                        };
                                    };
                                }
                                else
                                {
                                    if (uri.length == 0)
                                    {
                                        qName = new QName(uri, p);
                                        try
                                        {
                                            obj[qName];
                                            propertyNames.push(qName);
                                        }
                                        catch(e:Error)
                                        {
                                        };
                                    };
                                };
                            };
                        };
                        i = (i + 1);
                    };
                };
            };
            propertyNames.sort((Array.CASEINSENSITIVE | ((numericIndex) ? Array.NUMERIC : 0)));
            if (!isDict)
            {
                i = 0;
                while (i < (propertyNames.length - 1))
                {
                    if (propertyNames[i].toString() == propertyNames[(i + 1)].toString())
                    {
                        propertyNames.splice(i, 1);
                        i = (i - 1);
                    };
                    i = (i + 1);
                };
            };
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                CLASS_INFO_CACHE[cacheKey] = result;
            };
            return (result);
        }

        private static function arrayCompare(_arg_1:Array, _arg_2:Array, _arg_3:int, _arg_4:int, _arg_5:Dictionary):int
        {
            var _local_7:Object;
            var _local_6:int;
            if (_arg_1.length != _arg_2.length)
            {
                if (_arg_1.length < _arg_2.length)
                {
                    _local_6 = -1;
                }
                else
                {
                    _local_6 = 1;
                };
            }
            else
            {
                for (_local_7 in _arg_1)
                {
                    if (_arg_2.hasOwnProperty(_local_7))
                    {
                        _local_6 = internalCompare(_arg_1[_local_7], _arg_2[_local_7], _arg_3, _arg_4, _arg_5);
                        if (_local_6 != 0)
                        {
                            return (_local_6);
                        };
                    }
                    else
                    {
                        return (-1);
                    };
                };
                for (_local_7 in _arg_2)
                {
                    if (!_arg_1.hasOwnProperty(_local_7))
                    {
                        return (1);
                    };
                };
            };
            return (_local_6);
        }

        public static function stringCompare(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):int
        {
            if (((_arg_1 == null) && (_arg_2 == null)))
            {
                return (0);
            };
            if (_arg_1 == null)
            {
                return (1);
            };
            if (_arg_2 == null)
            {
                return (-1);
            };
            if (_arg_3)
            {
                _arg_1 = _arg_1.toLocaleLowerCase();
                _arg_2 = _arg_2.toLocaleLowerCase();
            };
            var _local_4:int = _arg_1.localeCompare(_arg_2);
            if (_local_4 < -1)
            {
                _local_4 = -1;
            }
            else
            {
                if (_local_4 > 1)
                {
                    _local_4 = 1;
                };
            };
            return (_local_4);
        }

        public static function dateCompare(_arg_1:Date, _arg_2:Date):int
        {
            if (((_arg_1 == null) && (_arg_2 == null)))
            {
                return (0);
            };
            if (_arg_1 == null)
            {
                return (1);
            };
            if (_arg_2 == null)
            {
                return (-1);
            };
            var _local_3:Number = _arg_1.getTime();
            var _local_4:Number = _arg_2.getTime();
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            return (0);
        }

        public static function numericCompare(_arg_1:Number, _arg_2:Number):int
        {
            if (((isNaN(_arg_1)) && (isNaN(_arg_2))))
            {
                return (0);
            };
            if (isNaN(_arg_1))
            {
                return (1);
            };
            if (isNaN(_arg_2))
            {
                return (-1);
            };
            if (_arg_1 < _arg_2)
            {
                return (-1);
            };
            if (_arg_1 > _arg_2)
            {
                return (1);
            };
            return (0);
        }

        private static function newline(_arg_1:String, _arg_2:int=0):String
        {
            var _local_3:String = _arg_1;
            _local_3 = (_local_3 + "\n");
            var _local_4:int;
            while (_local_4 < _arg_2)
            {
                _local_3 = (_local_3 + " ");
                _local_4++;
            };
            return (_local_3);
        }

        private static function getRef(_arg_1:Object, _arg_2:Dictionary):Object
        {
            var _local_3:Object = _arg_2[_arg_1];
            while (((_local_3) && (!(_local_3 == _arg_2[_local_3]))))
            {
                _local_3 = _arg_2[_local_3];
            };
            if (!_local_3)
            {
                _local_3 = _arg_1;
            };
            if (_local_3 != _arg_2[_arg_1])
            {
                _arg_2[_arg_1] = _local_3;
            };
            return (_local_3);
        }

        private static function recordMetadata(properties:XMLList):Object
        {
            var prop:XML;
            var propName:String;
            var metadataList:XMLList;
            var metadata:Object;
            var md:XML;
            var mdName:String;
            var argsList:XMLList;
            var value:Object;
            var arg:XML;
            var existing:Object;
            var argKey:String;
            var argValue:String;
            var existingArray:Array;
            var result:Object;
            try
            {
                for each (prop in properties)
                {
                    propName = prop.attribute("name").toString();
                    metadataList = prop.metadata;
                    if (metadataList.length() > 0)
                    {
                        if (result == null)
                        {
                            result = {};
                        };
                        metadata = {};
                        result[propName] = metadata;
                        for each (md in metadataList)
                        {
                            mdName = md.attribute("name").toString();
                            argsList = md.arg;
                            value = {};
                            for each (arg in argsList)
                            {
                                argKey = arg.attribute("key").toString();
                                if (argKey != null)
                                {
                                    argValue = arg.attribute("value").toString();
                                    value[argKey] = argValue;
                                };
                            };
                            existing = metadata[mdName];
                            if (existing != null)
                            {
                                if ((existing is Array))
                                {
                                    existingArray = (existing as Array);
                                }
                                else
                                {
                                    existingArray = [existing];
                                    delete metadata[mdName];
                                };
                                existingArray.push(value);
                                existing = existingArray;
                            }
                            else
                            {
                                existing = value;
                            };
                            metadata[mdName] = existing;
                        };
                    };
                };
            }
            catch(e:Error)
            {
            };
            return (result);
        }

        public static function compare(_arg_1:Object, _arg_2:Object, _arg_3:int=-1):int
        {
            return (internalCompare(_arg_1, _arg_2, 0, _arg_3, new Dictionary(true)));
        }

        private static function listCompare(_arg_1:IList, _arg_2:IList, _arg_3:int, _arg_4:int, _arg_5:Dictionary):int
        {
            var _local_7:int;
            var _local_6:int;
            if (_arg_1.length != _arg_2.length)
            {
                if (_arg_1.length < _arg_2.length)
                {
                    _local_6 = -1;
                }
                else
                {
                    _local_6 = 1;
                };
            }
            else
            {
                _local_7 = 0;
                while (_local_7 < _arg_1.length)
                {
                    _local_6 = internalCompare(_arg_1.getItemAt(_local_7), _arg_2.getItemAt(_local_7), (_arg_3 + 1), _arg_4, _arg_5);
                    if (_local_6 != 0)
                    {
                        _local_7 = _arg_1.length;
                    };
                    _local_7++;
                };
            };
            return (_local_6);
        }

        private static function internalCompare(a:Object, b:Object, currentDepth:int, desiredDepth:int, refs:Dictionary):int
        {
            var newDepth:int;
            var aRef:Object;
            var bRef:Object;
            var aProps:Array;
            var bProps:Array;
            var isDynamicObject:Boolean;
            var propName:QName;
            var aProp:Object;
            var bProp:Object;
            var i:int;
            if (((a == null) && (b == null)))
            {
                return (0);
            };
            if (a == null)
            {
                return (1);
            };
            if (b == null)
            {
                return (-1);
            };
            if ((a is ObjectProxy))
            {
                a = ObjectProxy(a).object_proxy::object;
            };
            if ((b is ObjectProxy))
            {
                b = ObjectProxy(b).object_proxy::object;
            };
            var typeOfA:String = typeof(a);
            var typeOfB:String = typeof(b);
            var result:int;
            if (typeOfA == typeOfB)
            {
                switch (typeOfA)
                {
                    case "boolean":
                        result = numericCompare(Number(a), Number(b));
                        break;
                    case "number":
                        result = numericCompare((a as Number), (b as Number));
                        break;
                    case "string":
                        result = stringCompare((a as String), (b as String));
                        break;
                    case "object":
                        newDepth = ((desiredDepth > 0) ? (desiredDepth - 1) : desiredDepth);
                        aRef = getRef(a, refs);
                        bRef = getRef(b, refs);
                        if (aRef == bRef)
                        {
                            return (0);
                        };
                        refs[bRef] = aRef;
                        if (((!(desiredDepth == -1)) && (currentDepth > desiredDepth)))
                        {
                            result = stringCompare(a.toString(), b.toString());
                        }
                        else
                        {
                            if (((a is Array) && (b is Array)))
                            {
                                result = arrayCompare((a as Array), (b as Array), currentDepth, desiredDepth, refs);
                            }
                            else
                            {
                                if (((a is Date) && (b is Date)))
                                {
                                    result = dateCompare((a as Date), (b as Date));
                                }
                                else
                                {
                                    if (((a is IList) && (b is IList)))
                                    {
                                        result = listCompare((a as IList), (b as IList), currentDepth, desiredDepth, refs);
                                    }
                                    else
                                    {
                                        if (((a is ByteArray) && (b is ByteArray)))
                                        {
                                            result = byteArrayCompare((a as ByteArray), (b as ByteArray));
                                        }
                                        else
                                        {
                                            if (getQualifiedClassName(a) == getQualifiedClassName(b))
                                            {
                                                aProps = getClassInfo(a).properties;
                                                isDynamicObject = true;
                                                try
                                                {
                                                    a["wootHackwoot"];
                                                }
                                                catch(e:Error)
                                                {
                                                    isDynamicObject = false;
                                                };
                                                if (isDynamicObject)
                                                {
                                                    bProps = getClassInfo(b).properties;
                                                    result = arrayCompare(aProps, bProps, currentDepth, newDepth, refs);
                                                    if (result != 0)
                                                    {
                                                        return (result);
                                                    };
                                                };
                                                i = 0;
                                                while (i < aProps.length)
                                                {
                                                    propName = aProps[i];
                                                    aProp = a[propName];
                                                    bProp = b[propName];
                                                    result = internalCompare(aProp, bProp, (currentDepth + 1), newDepth, refs);
                                                    if (result != 0)
                                                    {
                                                        return (result);
                                                    };
                                                    i = (i + 1);
                                                };
                                            }
                                            else
                                            {
                                                return (1);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        break;
                };
            }
            else
            {
                return (stringCompare(typeOfA, typeOfB));
            };
            return (result);
        }

        public static function hasMetadata(_arg_1:Object, _arg_2:String, _arg_3:String, _arg_4:Array=null, _arg_5:Object=null):Boolean
        {
            var _local_6:Object = getClassInfo(_arg_1, _arg_4, _arg_5);
            var _local_7:Object = _local_6["metadata"];
            return (internalHasMetadata(_local_7, _arg_2, _arg_3));
        }

        private static function internalHasMetadata(_arg_1:Object, _arg_2:String, _arg_3:String):Boolean
        {
            var _local_4:Object;
            if (_arg_1 != null)
            {
                _local_4 = _arg_1[_arg_2];
                if (_local_4 != null)
                {
                    if (_local_4[_arg_3] != null)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public static function toString(_arg_1:Object, _arg_2:Array=null, _arg_3:Array=null):String
        {
            if (_arg_3 == null)
            {
                _arg_3 = defaultToStringExcludes;
            };
            refCount = 0;
            return (internalToString(_arg_1, 0, null, _arg_2, _arg_3));
        }

        private static function byteArrayCompare(_arg_1:ByteArray, _arg_2:ByteArray):int
        {
            var _local_4:int;
            var _local_3:int;
            if (_arg_1 == _arg_2)
            {
                return (_local_3);
            };
            if (_arg_1.length != _arg_2.length)
            {
                if (_arg_1.length < _arg_2.length)
                {
                    _local_3 = -1;
                }
                else
                {
                    _local_3 = 1;
                };
            }
            else
            {
                _local_4 = 0;
                while (_local_4 < _arg_1.length)
                {
                    _local_3 = numericCompare(_arg_1[_local_4], _arg_2[_local_4]);
                    if (_local_3 != 0)
                    {
                        _local_4 = _arg_1.length;
                    };
                    _local_4++;
                };
            };
            return (_local_3);
        }

        public static function copy(_arg_1:Object):Object
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeObject(_arg_1);
            _local_2.position = 0;
            return (_local_2.readObject());
        }

        private static function getCacheKey(_arg_1:Object, _arg_2:Array=null, _arg_3:Object=null):String
        {
            var _local_5:uint;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_4:String = getQualifiedClassName(_arg_1);
            if (_arg_2 != null)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.length)
                {
                    _local_6 = (_arg_2[_local_5] as String);
                    if (_local_6 != null)
                    {
                        _local_4 = (_local_4 + _local_6);
                    };
                    _local_5++;
                };
            };
            if (_arg_3 != null)
            {
                for (_local_7 in _arg_3)
                {
                    _local_4 = (_local_4 + _local_7);
                    _local_8 = (_arg_3[_local_7] as String);
                    if (_local_8 != null)
                    {
                        _local_4 = (_local_4 + _local_8);
                    };
                };
            };
            return (_local_4);
        }


    }
}//package mx.utils

