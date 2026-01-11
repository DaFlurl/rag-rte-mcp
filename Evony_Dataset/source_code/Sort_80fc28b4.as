// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.Sort

package mx.collections
{
    import flash.events.EventDispatcher;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.collections.errors.SortError;
    import flash.events.Event;
    import mx.utils.ObjectUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Sort extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const ANY_INDEX_MODE:String = "any";
        public static const FIRST_INDEX_MODE:String = "first";
        public static const LAST_INDEX_MODE:String = "last";

        private var noFieldsDescending:Boolean = false;
        private var usingCustomCompareFunction:Boolean;
        private var defaultEmptyField:SortField;
        private var _fields:Array;
        private var _compareFunction:Function;
        private var _unique:Boolean;

        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var fieldList:Array = [];


        public function get unique():Boolean
        {
            return (_unique);
        }

        public function get compareFunction():Function
        {
            return ((usingCustomCompareFunction) ? _compareFunction : internalCompare);
        }

        public function set unique(_arg_1:Boolean):void
        {
            _unique = _arg_1;
        }

        public function sort(items:Array):void
        {
            var fixedCompareFunction:Function;
            var message:String;
            var uniqueRet1:Object;
            var fields:Array;
            var i:int;
            var sortArgs:Object;
            var uniqueRet2:Object;
            if (((!(items)) || (items.length <= 1)))
            {
                return;
            };
            if (usingCustomCompareFunction)
            {
                fixedCompareFunction = function (_arg_1:Object, _arg_2:Object):int
                {
                    return (compareFunction(_arg_1, _arg_2, _fields));
                };
                if (unique)
                {
                    uniqueRet1 = items.sort(fixedCompareFunction, Array.UNIQUESORT);
                    if (uniqueRet1 == 0)
                    {
                        message = resourceManager.getString("collections", "nonUnique");
                        throw (new SortError(message));
                    };
                }
                else
                {
                    items.sort(fixedCompareFunction);
                };
            }
            else
            {
                fields = this.fields;
                if (((fields) && (fields.length > 0)))
                {
                    sortArgs = initSortFields(items[0], true);
                    if (unique)
                    {
                        if (((sortArgs) && (fields.length == 1)))
                        {
                            uniqueRet2 = items.sortOn(sortArgs.fields[0], (sortArgs.options[0] | Array.UNIQUESORT));
                        }
                        else
                        {
                            uniqueRet2 = items.sort(internalCompare, Array.UNIQUESORT);
                        };
                        if (uniqueRet2 == 0)
                        {
                            message = resourceManager.getString("collections", "nonUnique");
                            throw (new SortError(message));
                        };
                    }
                    else
                    {
                        if (sortArgs)
                        {
                            items.sortOn(sortArgs.fields, sortArgs.options);
                        }
                        else
                        {
                            items.sort(internalCompare);
                        };
                    };
                }
                else
                {
                    items.sort(internalCompare);
                };
            };
        }

        public function propertyAffectsSort(_arg_1:String):Boolean
        {
            var _local_3:SortField;
            if (((usingCustomCompareFunction) || (!(fields))))
            {
                return (true);
            };
            var _local_2:int;
            while (_local_2 < fields.length)
            {
                _local_3 = fields[_local_2];
                if (((_local_3.name == _arg_1) || (_local_3.usingCustomCompareFunction)))
                {
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }

        private function internalCompare(_arg_1:Object, _arg_2:Object, _arg_3:Array=null):int
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:SortField;
            var _local_4:int;
            if (!_fields)
            {
                _local_4 = noFieldsCompare(_arg_1, _arg_2);
            }
            else
            {
                _local_5 = 0;
                _local_6 = ((_arg_3) ? _arg_3.length : _fields.length);
                while (((_local_4 == 0) && (_local_5 < _local_6)))
                {
                    _local_7 = SortField(_fields[_local_5]);
                    _local_4 = _local_7.internalCompare(_arg_1, _arg_2);
                    _local_5++;
                };
            };
            return (_local_4);
        }

        public function reverse():void
        {
            var _local_1:int;
            if (fields)
            {
                _local_1 = 0;
                while (_local_1 < fields.length)
                {
                    SortField(fields[_local_1]).reverse();
                    _local_1++;
                };
            };
            noFieldsDescending = (!(noFieldsDescending));
        }

        private function noFieldsCompare(a:Object, b:Object, fields:Array=null):int
        {
            var message:String;
            if (!defaultEmptyField)
            {
                defaultEmptyField = new SortField();
                try
                {
                    defaultEmptyField.initCompare(a);
                }
                catch(e:SortError)
                {
                    message = resourceManager.getString("collections", "noComparator", [a]);
                    throw (new SortError(message));
                };
            };
            var result:int = defaultEmptyField.compareFunction(a, b);
            if (noFieldsDescending)
            {
                result = (result * -1);
            };
            return (result);
        }

        public function findItem(items:Array, values:Object, mode:String, returnInsertionIndex:Boolean=false, compareFunction:Function=null):int
        {
            var compareForFind:Function;
            var fieldsForCompare:Array;
            var message:String;
            var index:int;
            var fieldName:String;
            var hadPreviousFieldName:Boolean;
            var i:int;
            var hasFieldName:Boolean;
            var objIndex:int;
            var match:Boolean;
            var prevCompare:int;
            var nextCompare:int;
            if (!items)
            {
                message = resourceManager.getString("collections", "noItems");
                throw (new SortError(message));
            };
            if (items.length == 0)
            {
                return ((returnInsertionIndex) ? 1 : -1);
            };
            if (compareFunction == null)
            {
                compareForFind = this.compareFunction;
                if (((values) && (fieldList.length > 0)))
                {
                    fieldsForCompare = [];
                    hadPreviousFieldName = true;
                    i = 0;
                    while (i < fieldList.length)
                    {
                        fieldName = fieldList[i];
                        if (fieldName)
                        {
                            try
                            {
                                hasFieldName = (!(values[fieldName] === undefined));
                            }
                            catch(e:Error)
                            {
                                hasFieldName = false;
                            };
                            if (hasFieldName)
                            {
                                if (!hadPreviousFieldName)
                                {
                                    message = resourceManager.getString("collections", "findCondition", [fieldName]);
                                    throw (new SortError(message));
                                };
                                fieldsForCompare.push(fieldName);
                            }
                            else
                            {
                                hadPreviousFieldName = false;
                            };
                        }
                        else
                        {
                            fieldsForCompare.push(null);
                        };
                        i = (i + 1);
                    };
                    if (fieldsForCompare.length == 0)
                    {
                        message = resourceManager.getString("collections", "findRestriction");
                        throw (new SortError(message));
                    };
                    try
                    {
                        initSortFields(items[0]);
                    }
                    catch(initSortError:SortError)
                    {
                    };
                };
            }
            else
            {
                compareForFind = compareFunction;
            };
            var found:Boolean;
            var objFound:Boolean;
            index = 0;
            var lowerBound:int;
            var upperBound:int = (items.length - 1);
            var obj:Object;
            var direction:int = 1;
            while (((!(objFound)) && (lowerBound <= upperBound)))
            {
                index = int(Math.round(((lowerBound + upperBound) / 2)));
                obj = items[index];
                direction = ((fieldsForCompare) ? compareForFind(values, obj, fieldsForCompare) : compareForFind(values, obj));
                switch (direction)
                {
                    case -1:
                        upperBound = (index - 1);
                        break;
                    case 0:
                        objFound = true;
                        switch (mode)
                        {
                            case ANY_INDEX_MODE:
                                found = true;
                                break;
                            case FIRST_INDEX_MODE:
                                found = (index == lowerBound);
                                objIndex = (index - 1);
                                match = true;
                                while ((((match) && (!(found))) && (objIndex >= lowerBound)))
                                {
                                    obj = items[objIndex];
                                    prevCompare = ((fieldsForCompare) ? compareForFind(values, obj, fieldsForCompare) : compareForFind(values, obj));
                                    match = (prevCompare == 0);
                                    if (((!(match)) || ((match) && (objIndex == lowerBound))))
                                    {
                                        found = true;
                                        index = (objIndex + ((match) ? 0 : 1));
                                    };
                                    objIndex = (objIndex - 1);
                                };
                                break;
                            case LAST_INDEX_MODE:
                                found = (index == upperBound);
                                objIndex = (index + 1);
                                match = true;
                                while ((((match) && (!(found))) && (objIndex <= upperBound)))
                                {
                                    obj = items[objIndex];
                                    nextCompare = ((fieldsForCompare) ? compareForFind(values, obj, fieldsForCompare) : compareForFind(values, obj));
                                    match = (nextCompare == 0);
                                    if (((!(match)) || ((match) && (objIndex == upperBound))))
                                    {
                                        found = true;
                                        index = (objIndex - ((match) ? 0 : 1));
                                    };
                                    objIndex = (objIndex + 1);
                                };
                                break;
                            default:
                                message = resourceManager.getString("collections", "unknownMode");
                                throw (new SortError(message));
                        };
                        break;
                    case 1:
                        lowerBound = (index + 1);
                        break;
                };
            };
            if (((!(found)) && (!(returnInsertionIndex))))
            {
                return (-1);
            };
            return ((direction > 0) ? (index + 1) : index);
        }

        private function initSortFields(_arg_1:Object, _arg_2:Boolean=false):Object
        {
            var _local_4:int;
            var _local_5:SortField;
            var _local_6:int;
            var _local_3:Object;
            _local_4 = 0;
            while (_local_4 < fields.length)
            {
                SortField(fields[_local_4]).initCompare(_arg_1);
                _local_4++;
            };
            if (_arg_2)
            {
                _local_3 = {
                    "fields":[],
                    "options":[]
                };
                _local_4 = 0;
                while (_local_4 < fields.length)
                {
                    _local_5 = fields[_local_4];
                    _local_6 = _local_5.getArraySortOnOptions();
                    if (_local_6 == -1)
                    {
                        return (null);
                    };
                    _local_3.fields.push(_local_5.name);
                    _local_3.options.push(_local_6);
                    _local_4++;
                };
            };
            return (_local_3);
        }

        public function set fields(_arg_1:Array):void
        {
            var _local_2:SortField;
            var _local_3:int;
            _fields = _arg_1;
            fieldList = [];
            if (_fields)
            {
                _local_3 = 0;
                while (_local_3 < _fields.length)
                {
                    _local_2 = SortField(_fields[_local_3]);
                    fieldList.push(_local_2.name);
                    _local_3++;
                };
            };
            dispatchEvent(new Event("fieldsChanged"));
        }

        [Bindable("fieldsChanged")]
        public function get fields():Array
        {
            return (_fields);
        }

        public function set compareFunction(_arg_1:Function):void
        {
            _compareFunction = _arg_1;
            usingCustomCompareFunction = (!(_compareFunction == null));
        }

        override public function toString():String
        {
            return (ObjectUtil.toString(this));
        }


    }
}//package mx.collections

