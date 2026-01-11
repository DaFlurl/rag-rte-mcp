// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ISWFBridgeGroup

package mx.core
{
    import flash.events.IEventDispatcher;

    public interface ISWFBridgeGroup 
    {

        function getChildBridgeProvider(_arg_1:IEventDispatcher):ISWFBridgeProvider;
        function removeChildBridge(_arg_1:IEventDispatcher):void;
        function get parentBridge():IEventDispatcher;
        function addChildBridge(_arg_1:IEventDispatcher, _arg_2:ISWFBridgeProvider):void;
        function set parentBridge(_arg_1:IEventDispatcher):void;
        function containsBridge(_arg_1:IEventDispatcher):Boolean;
        function getChildBridges():Array;

    }
}//package mx.core

