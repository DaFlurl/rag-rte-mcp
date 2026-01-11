// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.ILayoutManager

package mx.managers
{
    import flash.events.IEventDispatcher;

    public interface ILayoutManager extends IEventDispatcher 
    {

        function validateNow():void;
        function validateClient(_arg_1:ILayoutManagerClient, _arg_2:Boolean=false):void;
        function isInvalid():Boolean;
        function invalidateDisplayList(_arg_1:ILayoutManagerClient):void;
        function set usePhasedInstantiation(_arg_1:Boolean):void;
        function invalidateSize(_arg_1:ILayoutManagerClient):void;
        function get usePhasedInstantiation():Boolean;
        function invalidateProperties(_arg_1:ILayoutManagerClient):void;

    }
}//package mx.managers

