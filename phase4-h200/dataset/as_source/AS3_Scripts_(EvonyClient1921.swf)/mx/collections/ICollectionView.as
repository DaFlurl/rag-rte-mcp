// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.ICollectionView

package mx.collections
{
    import flash.events.IEventDispatcher;

    public interface ICollectionView extends IEventDispatcher 
    {

        function set filterFunction(_arg_1:Function):void;
        function enableAutoUpdate():void;
        function get length():int;
        function disableAutoUpdate():void;
        function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void;
        function get filterFunction():Function;
        function createCursor():IViewCursor;
        function refresh():Boolean;
        function set sort(_arg_1:Sort):void;
        function get sort():Sort;
        function contains(_arg_1:Object):Boolean;

    }
}//package mx.collections

