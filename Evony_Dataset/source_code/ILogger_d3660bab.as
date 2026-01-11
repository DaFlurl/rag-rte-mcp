// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.logging.ILogger

package mx.logging
{
    import flash.events.IEventDispatcher;

    public interface ILogger extends IEventDispatcher 
    {

        function debug(_arg_1:String, ... _args):void;
        function fatal(_arg_1:String, ... _args):void;
        function get category():String;
        function warn(_arg_1:String, ... _args):void;
        function error(_arg_1:String, ... _args):void;
        function log(_arg_1:int, _arg_2:String, ... _args):void;
        function info(_arg_1:String, ... _args):void;

    }
}//package mx.logging

