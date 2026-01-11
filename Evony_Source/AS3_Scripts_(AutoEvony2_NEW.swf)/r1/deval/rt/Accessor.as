// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.Accessor

package r1.deval.rt
{
    public class Accessor extends ObjectExprBase implements ISettable 
    {

        private static var topLevelTypes:Object = {
            "Array":function (... _args):Array
            {
                var _local_3:*;
                var _local_2:* = [];
                for each (_local_3 in _args)
                {
                    _local_2.push(_local_3);
                };
                return (_local_2);
            },
            "Boolean":function (_arg_1:*):Boolean
            {
                return (Boolean(_arg_1));
            },
            "int":function (_arg_1:*):int
            {
                return (int(_arg_1));
            },
            "Number":function (_arg_1:*):Number
            {
                return (Number(_arg_1));
            },
            "Object":function (_arg_1:*):Object
            {
                return (_arg_1);
            },
            "String":function (_arg_1:*):String
            {
                return (String(_arg_1));
            },
            "uint":function (_arg_1:*):uint
            {
                return (uint(_arg_1));
            },
            "XML":function (_arg_1:*):XML
            {
                return (XML(_arg_1));
            },
            "XMLList":function (_arg_1:*):XMLList
            {
                return (XMLList(_arg_1));
            }
        };
        private static var xmlMethods:Object;

        internal var host:IExpr;
        internal var index:*;

        public function Accessor(_arg_1:IExpr, _arg_2:*)
        {
            this.host = _arg_1;
            this.index = _arg_2;
        }

        private static function _initXmlMethods():void
        {
            xmlMethods = {
                "hasOwnProperty":function (_arg_1:Object, _arg_2:String):Boolean
                {
                    return (_arg_1.hasOwnProperty(_arg_2));
                },
                "isPrototypeOf":function (_arg_1:Object, _arg_2:Object):Boolean
                {
                    return (_arg_1.isPrototypeOf(_arg_2));
                },
                "toString":function (_arg_1:Object):String
                {
                    return (_arg_1.toString());
                },
                "valueOf":function (_arg_1:Object):XML
                {
                    return (_arg_1.valueOf());
                },
                "propertyIsEnumerable":function (_arg_1:Object, _arg_2:String):Boolean
                {
                    return (_arg_1.propertyIsEnumerable(_arg_2));
                },
                "setPropertyIsEnumerable":function (_arg_1:Object, _arg_2:String, _arg_3:Boolean=true):void
                {
                    _arg_1.setPropertyIsEnumerable(_arg_2, _arg_3);
                },
                "addNamespace":function (_arg_1:XML, _arg_2:Object):XML
                {
                    return (_arg_1.addNamespace(_arg_2));
                },
                "appendChild":function (_arg_1:XML, _arg_2:Object):XML
                {
                    return (_arg_1.appendChild(_arg_2));
                },
                "childIndex":function (_arg_1:XML):int
                {
                    return (_arg_1.childIndex());
                },
                "inScopeNamespaces":function (_arg_1:XML):Array
                {
                    return (_arg_1.inScopeNamespaces());
                },
                "insertChildAfter":function (_arg_1:XML, _arg_2:Object, _arg_3:Object):*
                {
                    return (_arg_1.insertChildAfter(_arg_2, _arg_3));
                },
                "insertChildBefore":function (_arg_1:XML, _arg_2:Object, _arg_3:Object):*
                {
                    return (_arg_1.insertChildBefore(_arg_2, _arg_3));
                },
                "localName":function (_arg_1:XML):Object
                {
                    return (_arg_1.localName());
                },
                "name":function (_arg_1:XML):Object
                {
                    return (_arg_1.name());
                },
                "namespace":function (_arg_1:XML, _arg_2:String=null):*
                {
                    return (_arg_1.namespace(_arg_2));
                },
                "namespaceDeclarations":function (_arg_1:XML):Array
                {
                    return (_arg_1.namespaceDeclarations());
                },
                "nodeKind":function (_arg_1:XML):String
                {
                    return (_arg_1.nodeKind());
                },
                "prependChild":function (_arg_1:XML, _arg_2:Object):XML
                {
                    return (_arg_1.prependChild(_arg_2));
                },
                "removeNamespace":function (_arg_1:XML, _arg_2:Namespace):XML
                {
                    return (_arg_1.removeNamespace(_arg_2));
                },
                "replace":function (_arg_1:XML, _arg_2:Object, _arg_3:XML):XML
                {
                    return (_arg_1.replace(_arg_2, _arg_3));
                },
                "setChildren":function (_arg_1:XML, _arg_2:Object):XML
                {
                    return (_arg_1.setChildren(_arg_2));
                },
                "setLocalName":function (_arg_1:XML, _arg_2:String):void
                {
                    _arg_1.setLocalName(_arg_2);
                },
                "setName":function (_arg_1:XML, _arg_2:String):void
                {
                    _arg_1.setName(_arg_2);
                },
                "setNamespace":function (_arg_1:XML, _arg_2:Namespace):void
                {
                    _arg_1.setNamespace(_arg_2);
                },
                "attribute":function (_arg_1:*, _arg_2:*):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).attribute(_arg_2));
                    };
                    return ((_arg_1 as XMLList).attribute(_arg_2));
                },
                "attributes":function (_arg_1:*):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).attributes());
                    };
                    return ((_arg_1 as XMLList).attributes());
                },
                "child":function (_arg_1:*, _arg_2:Object):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).child(_arg_2));
                    };
                    return ((_arg_1 as XMLList).child(_arg_2));
                },
                "children":function (_arg_1:*):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).children());
                    };
                    return ((_arg_1 as XMLList).children());
                },
                "comments":function (_arg_1:*):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).comments());
                    };
                    return ((_arg_1 as XMLList).comments());
                },
                "contains":function (_arg_1:*, _arg_2:XML):Boolean
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).contains(_arg_2));
                    };
                    return ((_arg_1 as XMLList).contains(_arg_2));
                },
                "copy":function (_arg_1:*):*
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).copy());
                    };
                    return ((_arg_1 as XMLList).copy());
                },
                "descendants":function (_arg_1:*, _arg_2:Object="*"):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).descendants());
                    };
                    return ((_arg_1 as XMLList).descendants());
                },
                "elements":function (_arg_1:*, _arg_2:Object="*"):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).elements());
                    };
                    return ((_arg_1 as XMLList).elements());
                },
                "hasComplexContent":function (_arg_1:*):Boolean
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).hasComplexContent());
                    };
                    return ((_arg_1 as XMLList).hasComplexContent());
                },
                "hasSimpleContent":function (_arg_1:*):Boolean
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).hasSimpleContent());
                    };
                    return ((_arg_1 as XMLList).hasSimpleContent());
                },
                "length":function (_arg_1:*):int
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).length());
                    };
                    return ((_arg_1 as XMLList).length());
                },
                "normalize":function (_arg_1:*):*
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).normalize());
                    };
                    return ((_arg_1 as XMLList).normalize());
                },
                "parent":function (_arg_1:*):*
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).parent());
                    };
                    return ((_arg_1 as XMLList).parent());
                },
                "processingInstructions":function (_arg_1:*, _arg_2:String="*"):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).processingInstructions(_arg_2));
                    };
                    return ((_arg_1 as XMLList).processingInstructions(_arg_2));
                },
                "text":function (_arg_1:*):XMLList
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).text());
                    };
                    return ((_arg_1 as XMLList).text());
                },
                "toXMLString":function (_arg_1:*):String
                {
                    if ((_arg_1 is XML))
                    {
                        return ((_arg_1 as XML).toXMLString());
                    };
                    return ((_arg_1 as XMLList).toXMLString());
                }
            };
        }


        internal function resolveMethod(_arg_1:Array):void
        {
            var _local_3:*;
            var _local_4:*;
            _arg_1[0] = null;
            var _local_2:Object = getIndex();
            if (host != null)
            {
                _local_4 = host.getAny();
                if (_local_4 == null)
                {
                    throw (new RTError("msg.call.on.null"));
                };
                _arg_1[0] = _local_4;
                if (((_local_4 is XML) || (_local_4 is XMLList)))
                {
                    _arg_1[2] = true;
                    if (xmlMethods == null)
                    {
                        _initXmlMethods();
                    };
                    _local_3 = xmlMethods[_local_2];
                }
                else
                {
                    _local_3 = _local_4[_local_2];
                };
            }
            else
            {
                if (Env.isInDocQuery())
                {
                    if (xmlMethods == null)
                    {
                        _initXmlMethods();
                    };
                    _local_3 = (xmlMethods[_local_2] as Function);
                    if (_local_3 != null)
                    {
                        _arg_1[0] = Env.peekObject();
                        _arg_1[2] = true;
                    };
                };
                if (_local_3 == null)
                {
                    _local_3 = topLevelTypes[_local_2];
                };
                if (_local_3 == null)
                {
                    _local_3 = Env.getProperty(_local_2);
                };
            };
            if (_local_3 == null)
            {
                throw (new RTError("msg.rt.no.method"));
            };
            _arg_1[1] = _local_3;
        }

        public function delProp():Boolean
        {
            return (delete host.getAny()[getIndex()]);
        }

        override public function getAny():Object
        {
            var _local_2:Object;
            var _local_1:Object = getIndex();
            if (host == null)
            {
                return (Env.getProperty(_local_1));
            };
            _local_2 = host.getAny();
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2[_local_1]);
        }

        internal function getIndexAsBoolean():Boolean
        {
            return ((index is IExpr) ? index.getBoolean() : Boolean(index));
        }

        internal function getIndex():Object
        {
            return ((index is IExpr) ? index.getAny() : index);
        }

        public function setValue(_arg_1:Object):void
        {
            var _local_3:Object;
            var _local_2:Object = getIndex();
            if (host == null)
            {
                Env.setProperty(_local_2, _arg_1);
            }
            else
            {
                _local_3 = host.getAny();
                if (_local_3 != null)
                {
                    _local_3[_local_2] = _arg_1;
                }
                else
                {
                    throw (new RTError("msg.rt.set.to.null"));
                };
            };
        }


    }
}//package r1.deval.rt

