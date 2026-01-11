// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.automation.IAutomationObject

package mx.automation
{
    import flash.events.Event;

    public interface IAutomationObject 
    {

        function createAutomationIDPart(_arg_1:IAutomationObject):Object;
        function get automationName():String;
        function get showInAutomationHierarchy():Boolean;
        function set automationName(_arg_1:String):void;
        function getAutomationChildAt(_arg_1:int):IAutomationObject;
        function get automationDelegate():Object;
        function get automationTabularData():Object;
        function resolveAutomationIDPart(_arg_1:Object):Array;
        function replayAutomatableEvent(_arg_1:Event):Boolean;
        function set automationDelegate(_arg_1:Object):void;
        function get automationValue():Array;
        function get numAutomationChildren():int;
        function set showInAutomationHierarchy(_arg_1:Boolean):void;

    }
}//package mx.automation

