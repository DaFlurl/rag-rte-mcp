// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.IList

package mx.collections
{
    import flash.events.IEventDispatcher;

    public interface IList extends IEventDispatcher 
    {

        function addItem(_arg_1:Object):void;
        function get length():int;
        function addItemAt(_arg_1:Object, _arg_2:int):void;
        function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void;
        function getItemIndex(_arg_1:Object):int;
        function removeItemAt(_arg_1:int):Object;
        function getItemAt(_arg_1:int, _arg_2:int=0):Object;
        function removeAll():void;
        function toArray():Array;
        function setItemAt(_arg_1:Object, _arg_2:int):Object;

    }
}//package mx.collections

