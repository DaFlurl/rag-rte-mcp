// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.collections.DegrafaCursor

package com.degrafa.core.collections
{
    import mx.collections.CursorBookmark;

    public class DegrafaCursor 
    {

        protected static const BEFORE_FIRST_INDEX:int = -1;
        protected static const AFTER_LAST_INDEX:int = -2;

        public var currentIndex:int;
        public var source:Array;

        public function DegrafaCursor(_arg_1:Array)
        {
            this.source = _arg_1;
            currentIndex = BEFORE_FIRST_INDEX;
        }

        public function insert(_arg_1:*):void
        {
            var _local_2:int;
            if (((afterLast) || (beforeFirst)))
            {
                source.push(_arg_1);
            }
            else
            {
                source.splice(currentIndex, 0, _arg_1);
            };
        }

        public function get afterLast():Boolean
        {
            return ((currentIndex == AFTER_LAST_INDEX) || (source.length == 0));
        }

        public function moveNext():Boolean
        {
            if (afterLast)
            {
                return (false);
            };
            var _local_1:int = ((beforeFirst) ? 0 : (currentIndex + 1));
            if (_local_1 >= source.length)
            {
                _local_1 = AFTER_LAST_INDEX;
            };
            currentIndex = _local_1;
            return (!(afterLast));
        }

        public function moveLast():void
        {
            currentIndex = source.length;
        }

        public function movePrevious():Boolean
        {
            if (beforeFirst)
            {
                return (false);
            };
            var _local_1:int = ((afterLast) ? (source.length - 1) : (currentIndex - 1));
            currentIndex = _local_1;
            return (!(beforeFirst));
        }

        public function get beforeFirst():Boolean
        {
            return ((currentIndex == BEFORE_FIRST_INDEX) || (source.length == 0));
        }

        public function get nextObject():*
        {
            if (afterLast)
            {
                return (null);
            };
            var _local_1:int = ((beforeFirst) ? 0 : (currentIndex + 1));
            if (_local_1 >= source.length)
            {
                return (null);
            };
            return (source[_local_1]);
        }

        public function remove():*
        {
            var _local_1:Object = source[currentIndex];
            source = source.splice(currentIndex, 1);
            return (_local_1);
        }

        public function get current():*
        {
            if (currentIndex > BEFORE_FIRST_INDEX)
            {
                return (source[currentIndex]);
            };
            return (null);
        }

        public function seek(_arg_1:CursorBookmark, _arg_2:int=0):void
        {
            if (source.length == 0)
            {
                currentIndex = AFTER_LAST_INDEX;
                return;
            };
            var _local_3:int = currentIndex;
            if (_arg_1 == CursorBookmark.FIRST)
            {
                _local_3 = 0;
            }
            else
            {
                if (_arg_1 == CursorBookmark.LAST)
                {
                    _local_3 = (source.length - 1);
                };
            };
            _local_3 = (_local_3 + _arg_2);
            if (_local_3 >= source.length)
            {
                currentIndex = AFTER_LAST_INDEX;
            }
            else
            {
                if (_local_3 < 0)
                {
                    currentIndex = BEFORE_FIRST_INDEX;
                }
                else
                {
                    currentIndex = _local_3;
                };
            };
        }

        public function get previousObject():*
        {
            if (beforeFirst)
            {
                return (null);
            };
            var _local_1:int = ((afterLast) ? (source.length - 1) : (currentIndex - 1));
            if (_local_1 == BEFORE_FIRST_INDEX)
            {
                return (null);
            };
            return (source[_local_1]);
        }

        public function moveFirst():void
        {
            currentIndex = BEFORE_FIRST_INDEX;
        }


    }
}//package com.degrafa.core.collections

