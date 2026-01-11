// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ContainerRawChildrenList

package mx.core
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ContainerRawChildrenList implements IChildList 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var owner:Container;

        public function ContainerRawChildrenList(_arg_1:Container)
        {
            this.owner = _arg_1;
        }

        public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            return (owner.rawChildren_addChild(_arg_1));
        }

        public function getChildIndex(_arg_1:DisplayObject):int
        {
            return (owner.rawChildren_getChildIndex(_arg_1));
        }

        public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            owner.rawChildren_setChildIndex(_arg_1, _arg_2);
        }

        public function getChildByName(_arg_1:String):DisplayObject
        {
            return (owner.rawChildren_getChildByName(_arg_1));
        }

        public function removeChildAt(_arg_1:int):DisplayObject
        {
            return (owner.rawChildren_removeChildAt(_arg_1));
        }

        public function get numChildren():int
        {
            return (owner.$numChildren);
        }

        public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            return (owner.rawChildren_addChildAt(_arg_1, _arg_2));
        }

        public function getObjectsUnderPoint(_arg_1:Point):Array
        {
            return (owner.rawChildren_getObjectsUnderPoint(_arg_1));
        }

        public function contains(_arg_1:DisplayObject):Boolean
        {
            return (owner.rawChildren_contains(_arg_1));
        }

        public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            return (owner.rawChildren_removeChild(_arg_1));
        }

        public function getChildAt(_arg_1:int):DisplayObject
        {
            return (owner.rawChildren_getChildAt(_arg_1));
        }


    }
}//package mx.core

