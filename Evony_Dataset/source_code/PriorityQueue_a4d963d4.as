// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.layoutClasses.PriorityQueue

package mx.managers.layoutClasses
{
    import flash.display.DisplayObject;
    import mx.managers.ILayoutManagerClient;
    import mx.core.IChildList;
    import mx.core.IRawChildrenContainer;
    import flash.display.DisplayObjectContainer;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PriorityQueue 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var maxPriority:int = -1;
        private var arrayOfArrays:Array = [];
        private var minPriority:int = 0;


        public function addObject(_arg_1:Object, _arg_2:int):void
        {
            if (!arrayOfArrays[_arg_2])
            {
                arrayOfArrays[_arg_2] = [];
            };
            arrayOfArrays[_arg_2].push(_arg_1);
            if (maxPriority < minPriority)
            {
                minPriority = (maxPriority = _arg_2);
            }
            else
            {
                if (_arg_2 < minPriority)
                {
                    minPriority = _arg_2;
                };
                if (_arg_2 > maxPriority)
                {
                    maxPriority = _arg_2;
                };
            };
        }

        public function removeSmallest():Object
        {
            var _local_1:Object;
            if (minPriority <= maxPriority)
            {
                while (((!(arrayOfArrays[minPriority])) || (arrayOfArrays[minPriority].length == 0)))
                {
                    minPriority++;
                    if (minPriority > maxPriority)
                    {
                        return (null);
                    };
                };
                _local_1 = arrayOfArrays[minPriority].shift();
                while (((!(arrayOfArrays[minPriority])) || (arrayOfArrays[minPriority].length == 0)))
                {
                    minPriority++;
                    if (minPriority > maxPriority) break;
                };
            };
            return (_local_1);
        }

        public function removeLargestChild(_arg_1:ILayoutManagerClient):Object
        {
            var _local_5:int;
            var _local_2:Object;
            var _local_3:int = maxPriority;
            var _local_4:int = _arg_1.nestLevel;
            while (_local_4 <= _local_3)
            {
                if (((arrayOfArrays[_local_3]) && (arrayOfArrays[_local_3].length > 0)))
                {
                    _local_5 = 0;
                    while (_local_5 < arrayOfArrays[_local_3].length)
                    {
                        if (contains(DisplayObject(_arg_1), arrayOfArrays[_local_3][_local_5]))
                        {
                            _local_2 = arrayOfArrays[_local_3][_local_5];
                            arrayOfArrays[_local_3].splice(_local_5, 1);
                            return (_local_2);
                        };
                        _local_5++;
                    };
                    _local_3--;
                }
                else
                {
                    if (_local_3 == maxPriority)
                    {
                        maxPriority--;
                    };
                    _local_3--;
                    if (_local_3 < _local_4) break;
                };
            };
            return (_local_2);
        }

        public function isEmpty():Boolean
        {
            return (minPriority > maxPriority);
        }

        public function removeLargest():Object
        {
            var _local_1:Object;
            if (minPriority <= maxPriority)
            {
                while (((!(arrayOfArrays[maxPriority])) || (arrayOfArrays[maxPriority].length == 0)))
                {
                    maxPriority--;
                    if (maxPriority < minPriority)
                    {
                        return (null);
                    };
                };
                _local_1 = arrayOfArrays[maxPriority].shift();
                while (((!(arrayOfArrays[maxPriority])) || (arrayOfArrays[maxPriority].length == 0)))
                {
                    maxPriority--;
                    if (maxPriority < minPriority) break;
                };
            };
            return (_local_1);
        }

        public function removeSmallestChild(_arg_1:ILayoutManagerClient):Object
        {
            var _local_4:int;
            var _local_2:Object;
            var _local_3:int = _arg_1.nestLevel;
            while (_local_3 <= maxPriority)
            {
                if (((arrayOfArrays[_local_3]) && (arrayOfArrays[_local_3].length > 0)))
                {
                    _local_4 = 0;
                    while (_local_4 < arrayOfArrays[_local_3].length)
                    {
                        if (contains(DisplayObject(_arg_1), arrayOfArrays[_local_3][_local_4]))
                        {
                            _local_2 = arrayOfArrays[_local_3][_local_4];
                            arrayOfArrays[_local_3].splice(_local_4, 1);
                            return (_local_2);
                        };
                        _local_4++;
                    };
                    _local_3++;
                }
                else
                {
                    if (_local_3 == minPriority)
                    {
                        minPriority++;
                    };
                    if (++_local_3 > maxPriority) break;
                };
            };
            return (_local_2);
        }

        public function removeAll():void
        {
            arrayOfArrays.splice(0);
            minPriority = 0;
            maxPriority = -1;
        }

        private function contains(_arg_1:DisplayObject, _arg_2:DisplayObject):Boolean
        {
            var _local_3:IChildList;
            if ((_arg_1 is IRawChildrenContainer))
            {
                _local_3 = IRawChildrenContainer(_arg_1).rawChildren;
                return (_local_3.contains(_arg_2));
            };
            if ((_arg_1 is DisplayObjectContainer))
            {
                return (DisplayObjectContainer(_arg_1).contains(_arg_2));
            };
            return (_arg_1 == _arg_2);
        }


    }
}//package mx.managers.layoutClasses

