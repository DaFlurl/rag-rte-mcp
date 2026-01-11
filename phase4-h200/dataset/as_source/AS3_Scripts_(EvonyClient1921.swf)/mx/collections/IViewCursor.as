// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.IViewCursor

package mx.collections
{
    import flash.events.IEventDispatcher;

    public interface IViewCursor extends IEventDispatcher 
    {

        [Bindable("cursorUpdate")]
        function get current():Object;
        function moveNext():Boolean;
        function get view():ICollectionView;
        function movePrevious():Boolean;
        function remove():Object;
        function findLast(_arg_1:Object):Boolean;
        [Bindable("cursorUpdate")]
        function get beforeFirst():Boolean;
        [Bindable("cursorUpdate")]
        function get afterLast():Boolean;
        function findAny(_arg_1:Object):Boolean;
        [Bindable("cursorUpdate")]
        function get bookmark():CursorBookmark;
        function findFirst(_arg_1:Object):Boolean;
        function seek(_arg_1:CursorBookmark, _arg_2:int=0, _arg_3:int=0):void;
        function insert(_arg_1:Object):void;

    }
}//package mx.collections

