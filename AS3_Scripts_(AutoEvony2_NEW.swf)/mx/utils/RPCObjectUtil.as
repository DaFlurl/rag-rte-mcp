// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.RPCObjectUtil

package mx.utils
{
    import flash.xml.XMLNode;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RPCObjectUtil 
    {

        mx_internal static const VERSION:String = "3.6.0.12937";
        private static var defaultToStringExcludes:Array = ["password", "credentials"];
        private static var refCount:int = 0;
        private static var CLASS_INFO_CACHE:Object = {};


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
                                    existingArray = [];
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

        public static function toString(_arg_1:Object, _arg_2:Array=null, _arg_3:Array=null):String
        {
            if (_arg_3 == null)
            {
                _arg_3 = defaultToStringExcludes;
            };
            refCount = 0;
            return (internalToString(_arg_1, 0, null, _arg_2, _arg_3));
        }

        private static function internalToString(value:Object, indent:int=0, refs:Dictionary=null, namespaceURIs:Array=null, exclude:Array=null):String
        {
            var str:String;
            var classInfo:Object;
            var properties:Array;
            var id:Object;
            var isArray:Boolean;
            var prop:* = undefined;
            var j:int;
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
                    id = refs[value];
                    if (id != null)
                    {
                        str = (str + ("#" + int(id)));
                        return (str);
                    };
                    if (value != null)
                    {
                        str = (str + ("#" + refCount.toString()));
                        refs[value] = refCount;
                        refCount++;
                    };
                    isArray = (value is Array);
                    indent = (indent + 2);
                    j = 0;
                    while (j < properties.length)
                    {
                        str = newline(str, indent);
                        prop = properties[j];
                        if (isArray)
                        {
                            str = (str + "[");
                        };
                        str = (str + prop.toString());
                        if (isArray)
                        {
                            str = (str + "] ");
                        }
                        else
                        {
                            str = (str + " = ");
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
                    return (value.toString());
                default:
                    return (("(" + type) + ")");
            };
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
            var p:String;
            var pi:Number;
            var uris:Array;
            var uri:String;
            var qName:QName;
            var j:int;
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
                classInfo = describeType(obj);
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
            if (!((className == "Object") || (isArray)))
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
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                CLASS_INFO_CACHE[cacheKey] = result;
            };
            return (result);
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


    }
}//package mx.utils

