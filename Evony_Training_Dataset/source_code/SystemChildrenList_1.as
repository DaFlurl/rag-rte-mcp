// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.SystemChildrenList

package mx.managers
{
    import mx.core.IChildList;
    import mx.core.mx_internal;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import mx.managers.*;

    use namespace mx_internal;

    public class SystemChildrenList implements IChildList 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var lowerBoundReference:QName;
        private var upperBoundReference:QName;
        private var owner:SystemManager;

        public function SystemChildrenList(_arg_1:SystemManager, _arg_2:QName, _arg_3:QName)
        {
            this.owner = _arg_1;
            this.lowerBoundReference = _arg_2;
            this.upperBoundReference = _arg_3;
        }

        public function getChildAt(_arg_1:int):DisplayObject
        {
            return (owner.mx_internal::rawChildren_getChildAt((owner[lowerBoundReference] + _arg_1)));
        }

        public function getChildByName(_arg_1:String):DisplayObject
        {
            return (owner.mx_internal::rawChildren_getChildByName(_arg_1));
        }

        public function removeChildAt(_arg_1:int):DisplayObject
        {
            var _local_2:DisplayObject = owner.mx_internal::rawChildren_removeChildAt((_arg_1 + owner[lowerBoundReference]));
            owner[upperBoundReference]--;
            return (_local_2);
        }

        public function getChildIndex(_arg_1:DisplayObject):int
        {
            var _local_2:int = owner.mx_internal::rawChildren_getChildIndex(_arg_1);
            return (_local_2 - owner[lowerBoundReference]);
        }

        public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            var _local_3:* = owner;
            (_local_3.mx_internal::rawChildren_addChildAt(_arg_1, (owner[lowerBoundReference] + _arg_2)));
            owner[upperBoundReference]++;
            return (_arg_1);
        }

        public function getObjectsUnderPoint(_arg_1:Point):Array
        {
            return (owner.mx_internal::rawChildren_getObjectsUnderPoint(_arg_1));
        }

        public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            var _local_3:* = owner;
            (_local_3.mx_internal::rawChildren_setChildIndex(_arg_1, (owner[lowerBoundReference] + _arg_2)));
        }

        public function get numChildren():int
        {
            return (owner[upperBoundReference] - owner[lowerBoundReference]);
        }

        public function contains(_arg_1:DisplayObject):Boolean
        {
            var _local_2:int;
            if (((!(_arg_1 == owner)) && (owner.mx_internal::rawChildren_contains(_arg_1))))
            {
                while (_arg_1.parent != owner)
                {
                    _arg_1 = _arg_1.parent;
                };
                _local_2 = owner.mx_internal::rawChildren_getChildIndex(_arg_1);
                if (((_local_2 >= owner[lowerBoundReference]) && (_local_2 < owner[upperBoundReference])))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:int = owner.mx_internal::rawChildren_getChildIndex(_arg_1);
            if (((owner[lowerBoundReference] <= _local_2) && (_local_2 < owner[upperBoundReference])))
            {
                var _local_3:* = owner;
                (_local_3.mx_internal::rawChildren_removeChild(_arg_1));
                owner[upperBoundReference]--;
            };
            return (_arg_1);
        }

        public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:* = owner;
            (_local_2.mx_internal::rawChildren_addChildAt(_arg_1, owner[upperBoundReference]));
            owner[upperBoundReference]++;
            return (_arg_1);
        }


    }
}//package mx.managers

