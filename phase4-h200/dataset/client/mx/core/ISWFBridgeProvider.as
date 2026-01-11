// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ISWFBridgeProvider

package mx.core
{
    import flash.events.IEventDispatcher;

    public interface ISWFBridgeProvider 
    {

        function get childAllowsParent():Boolean;
        function get swfBridge():IEventDispatcher;
        function get parentAllowsChild():Boolean;

    }
}//package mx.core

