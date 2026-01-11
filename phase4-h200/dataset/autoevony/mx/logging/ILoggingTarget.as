// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.logging.ILoggingTarget

package mx.logging
{
    public interface ILoggingTarget 
    {

        function addLogger(_arg_1:ILogger):void;
        function removeLogger(_arg_1:ILogger):void;
        function get level():int;
        function set filters(_arg_1:Array):void;
        function set level(_arg_1:int):void;
        function get filters():Array;

    }
}//package mx.logging

