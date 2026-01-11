// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IBrowserManager

package mx.managers
{
    import flash.events.IEventDispatcher;

    public interface IBrowserManager extends IEventDispatcher 
    {

        function get fragment():String;
        function get base():String;
        function setFragment(_arg_1:String):void;
        function setTitle(_arg_1:String):void;
        function init(_arg_1:String=null, _arg_2:String=null):void;
        function get title():String;
        function initForHistoryManager():void;
        function get url():String;

    }
}//package mx.managers

