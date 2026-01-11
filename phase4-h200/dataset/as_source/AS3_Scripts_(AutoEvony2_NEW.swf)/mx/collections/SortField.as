// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.SortField

package mx.collections
{
    import flash.events.EventDispatcher;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.Event;
    import mx.utils.ObjectUtil;
    import mx.collections.errors.SortError;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class SortField extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _caseInsensitive:Boolean;
        private var _numeric:Object;
        private var _descending:Boolean;
        private var _compareFunction:Function;
        private var _usingCustomCompareFunction:Boolean;
        private var _name:String;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function SortField(_arg_1:String=null, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Object=null)
        {
            _name = _arg_1;
            _caseInsensitive = _arg_2;
            _descending = _arg_3;
            _numeric = _arg_4;
            _compareFunction = stringCompare;
        }

        [Bindable("caseInsensitiveChanged")]
        public function get caseInsensitive():Boolean
        {
            return (_caseInsensitive);
        }

        mx_internal function get usingCustomCompareFunction():Boolean
        {
            return (_usingCustomCompareFunction);
        }

        public function set caseInsensitive(_arg_1:Boolean):void
        {
            if (_arg_1 != _caseInsensitive)
            {
                _caseInsensitive = _arg_1;
                dispatchEvent(new Event("caseInsensitiveChanged"));
            };
        }

        [Bindable("nameChanged")]
        public function get name():String
        {
            return (_name);
        }

        [Bindable("numericChanged")]
        public function get numeric():Object
        {
            return (_numeric);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
            dispatchEvent(new Event("nameChanged"));
        }

        private function numericCompare(a:Object, b:Object):int
        {
            var fa:Number;
            var fb:Number;
            try
            {
                fa = ((_name == null) ? Number(a) : Number(a[_name]));
            }
            catch(error:Error)
            {
            };
            try
            {
                fb = ((_name == null) ? Number(b) : Number(b[_name]));
            }
            catch(error:Error)
            {
            };
            return (ObjectUtil.numericCompare(fa, fb));
        }

        public function set numeric(_arg_1:Object):void
        {
            if (_numeric != _arg_1)
            {
                _numeric = _arg_1;
                dispatchEvent(new Event("numericChanged"));
            };
        }

        private function stringCompare(a:Object, b:Object):int
        {
            var fa:String;
            var fb:String;
            try
            {
                fa = ((_name == null) ? String(a) : String(a[_name]));
            }
            catch(error:Error)
            {
            };
            try
            {
                fb = ((_name == null) ? String(b) : String(b[_name]));
            }
            catch(error:Error)
            {
            };
            return (ObjectUtil.stringCompare(fa, fb, _caseInsensitive));
        }

        public function get compareFunction():Function
        {
            return (_compareFunction);
        }

        public function reverse():void
        {
            descending = (!(descending));
        }

        mx_internal function getArraySortOnOptions():int
        {
            if (((((usingCustomCompareFunction) || (name == null)) || (_compareFunction == xmlCompare)) || (_compareFunction == dateCompare)))
            {
                return (-1);
            };
            var _local_1:int;
            if (caseInsensitive)
            {
                _local_1 = (_local_1 | Array.CASEINSENSITIVE);
            };
            if (descending)
            {
                _local_1 = (_local_1 | Array.DESCENDING);
            };
            if (((numeric == true) || (_compareFunction == numericCompare)))
            {
                _local_1 = (_local_1 | Array.NUMERIC);
            };
            return (_local_1);
        }

        private function dateCompare(a:Object, b:Object):int
        {
            var fa:Date;
            var fb:Date;
            try
            {
                fa = ((_name == null) ? (a as Date) : (a[_name] as Date));
            }
            catch(error:Error)
            {
            };
            try
            {
                fb = ((_name == null) ? (b as Date) : (b[_name] as Date));
            }
            catch(error:Error)
            {
            };
            return (ObjectUtil.dateCompare(fa, fb));
        }

        mx_internal function internalCompare(_arg_1:Object, _arg_2:Object):int
        {
            var _local_3:int = compareFunction(_arg_1, _arg_2);
            if (descending)
            {
                _local_3 = (_local_3 * -1);
            };
            return (_local_3);
        }

        override public function toString():String
        {
            return (ObjectUtil.toString(this));
        }

        private function nullCompare(a:Object, b:Object):int
        {
            var value:Object;
            var left:Object;
            var right:Object;
            var message:String;
            var found:Boolean;
            if (((a == null) && (b == null)))
            {
                return (0);
            };
            if (_name)
            {
                try
                {
                    left = a[_name];
                }
                catch(error:Error)
                {
                };
                try
                {
                    right = b[_name];
                }
                catch(error:Error)
                {
                };
            };
            if (((left == null) && (right == null)))
            {
                return (0);
            };
            if (((left == null) && (!(_name))))
            {
                left = a;
            };
            if (((right == null) && (!(_name))))
            {
                right = b;
            };
            var typeLeft:String = typeof(left);
            var typeRight:String = typeof(right);
            if (((typeLeft == "string") || (typeRight == "string")))
            {
                found = true;
                _compareFunction = stringCompare;
            }
            else
            {
                if (((typeLeft == "object") || (typeRight == "object")))
                {
                    if (((left is Date) || (right is Date)))
                    {
                        found = true;
                        _compareFunction = dateCompare;
                    };
                }
                else
                {
                    if (((typeLeft == "xml") || (typeRight == "xml")))
                    {
                        found = true;
                        _compareFunction = xmlCompare;
                    }
                    else
                    {
                        if (((((typeLeft == "number") || (typeRight == "number")) || (typeLeft == "boolean")) || (typeRight == "boolean")))
                        {
                            found = true;
                            _compareFunction = numericCompare;
                        };
                    };
                };
            };
            if (found)
            {
                return (_compareFunction(left, right));
            };
            message = resourceManager.getString("collections", "noComparatorSortField", [name]);
            throw (new SortError(message));
        }

        public function set descending(_arg_1:Boolean):void
        {
            if (_descending != _arg_1)
            {
                _descending = _arg_1;
                dispatchEvent(new Event("descendingChanged"));
            };
        }

        mx_internal function initCompare(obj:Object):void
        {
            var value:Object;
            var typ:String;
            var test:String;
            if (!usingCustomCompareFunction)
            {
                if (numeric == true)
                {
                    _compareFunction = numericCompare;
                }
                else
                {
                    if (((caseInsensitive) || (numeric == false)))
                    {
                        _compareFunction = stringCompare;
                    }
                    else
                    {
                        if (_name)
                        {
                            try
                            {
                                value = obj[_name];
                            }
                            catch(error:Error)
                            {
                            };
                        };
                        if (value == null)
                        {
                            value = obj;
                        };
                        typ = typeof(value);
                        switch (typ)
                        {
                            case "string":
                                _compareFunction = stringCompare;
                                return;
                            case "object":
                                if ((value is Date))
                                {
                                    _compareFunction = dateCompare;
                                }
                                else
                                {
                                    _compareFunction = stringCompare;
                                    try
                                    {
                                        test = value.toString();
                                    }
                                    catch(error2:Error)
                                    {
                                    };
                                    if (((!(test)) || (test == "[object Object]")))
                                    {
                                        _compareFunction = nullCompare;
                                    };
                                };
                                return;
                            case "xml":
                                _compareFunction = xmlCompare;
                                return;
                            case "boolean":
                            case "number":
                                _compareFunction = numericCompare;
                                return;
                        };
                    };
                };
            };
        }

        [Bindable("descendingChanged")]
        public function get descending():Boolean
        {
            return (_descending);
        }

        public function set compareFunction(_arg_1:Function):void
        {
            _compareFunction = _arg_1;
            _usingCustomCompareFunction = (!(_arg_1 == null));
        }

        private function xmlCompare(a:Object, b:Object):int
        {
            var sa:String;
            var sb:String;
            try
            {
                sa = ((_name == null) ? a.toString() : a[_name].toString());
            }
            catch(error:Error)
            {
            };
            try
            {
                sb = ((_name == null) ? b.toString() : b[_name].toString());
            }
            catch(error:Error)
            {
            };
            if (numeric == true)
            {
                return (ObjectUtil.numericCompare(parseFloat(sa), parseFloat(sb)));
            };
            return (ObjectUtil.stringCompare(sa, sb, _caseInsensitive));
        }


    }
}//package mx.collections

