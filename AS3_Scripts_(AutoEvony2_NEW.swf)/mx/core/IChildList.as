// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IChildList

package mx.core
{
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public interface IChildList 
    {

        function get numChildren():int;
        function removeChild(_arg_1:DisplayObject):DisplayObject;
        function getChildByName(_arg_1:String):DisplayObject;
        function removeChildAt(_arg_1:int):DisplayObject;
        function getChildIndex(_arg_1:DisplayObject):int;
        function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject;
        function getObjectsUnderPoint(_arg_1:Point):Array;
        function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void;
        function getChildAt(_arg_1:int):DisplayObject;
        function addChild(_arg_1:DisplayObject):DisplayObject;
        function contains(_arg_1:DisplayObject):Boolean;

    }
}//package mx.core

