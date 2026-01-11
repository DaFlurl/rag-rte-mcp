// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.ILayoutManagerClient

package mx.managers
{
    import flash.events.IEventDispatcher;

    public interface ILayoutManagerClient extends IEventDispatcher 
    {

        function get updateCompletePendingFlag():Boolean;
        function set updateCompletePendingFlag(_arg_1:Boolean):void;
        function set initialized(_arg_1:Boolean):void;
        function validateProperties():void;
        function validateDisplayList():void;
        function get nestLevel():int;
        function get initialized():Boolean;
        function get processedDescriptors():Boolean;
        function validateSize(_arg_1:Boolean=false):void;
        function set nestLevel(_arg_1:int):void;
        function set processedDescriptors(_arg_1:Boolean):void;

    }
}//package mx.managers

