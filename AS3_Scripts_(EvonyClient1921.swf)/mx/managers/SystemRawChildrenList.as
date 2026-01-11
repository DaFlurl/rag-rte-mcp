// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.SystemRawChildrenList

package mx.managers
{
    import mx.core.IChildList;
    import mx.core.mx_internal;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    use namespace mx_internal;

    public class SystemRawChildrenList implements IChildList 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var owner:SystemManager;

        public function SystemRawChildrenList(_arg_1:SystemManager)
        {
            this.owner = _arg_1;
        }

        public function getChildAt(_arg_1:int):DisplayObject
        {
            return (owner.mx_internal::rawChildren_getChildAt(_arg_1));
        }

        public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            return (owner.mx_internal::rawChildren_addChild(_arg_1));
        }

        public function getChildIndex(_arg_1:DisplayObject):int
        {
            return (owner.mx_internal::rawChildren_getChildIndex(_arg_1));
        }

        public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            var _local_3:* = owner;
            (_local_3.mx_internal::rawChildren_setChildIndex(_arg_1, _arg_2));
        }

        public function getChildByName(_arg_1:String):DisplayObject
        {
            return (owner.mx_internal::rawChildren_getChildByName(_arg_1));
        }

        public function removeChildAt(_arg_1:int):DisplayObject
        {
            return (owner.mx_internal::rawChildren_removeChildAt(_arg_1));
        }

        public function get numChildren():int
        {
            return (owner.mx_internal::$numChildren);
        }

        public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            return (owner.mx_internal::rawChildren_addChildAt(_arg_1, _arg_2));
        }

        public function getObjectsUnderPoint(_arg_1:Point):Array
        {
            return (owner.mx_internal::rawChildren_getObjectsUnderPoint(_arg_1));
        }

        public function contains(_arg_1:DisplayObject):Boolean
        {
            return (owner.mx_internal::rawChildren_contains(_arg_1));
        }

        public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            return (owner.mx_internal::rawChildren_removeChild(_arg_1));
        }


    }
}//package mx.managers

