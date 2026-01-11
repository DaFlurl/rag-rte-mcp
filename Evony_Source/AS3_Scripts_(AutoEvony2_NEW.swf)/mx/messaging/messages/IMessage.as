// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.IMessage

package mx.messaging.messages
{
    public interface IMessage 
    {

        function get body():Object;
        function set messageId(_arg_1:String):void;
        function get clientId():String;
        function set timeToLive(_arg_1:Number):void;
        function get messageId():String;
        function set body(_arg_1:Object):void;
        function set timestamp(_arg_1:Number):void;
        function get headers():Object;
        function get destination():String;
        function set clientId(_arg_1:String):void;
        function get timeToLive():Number;
        function get timestamp():Number;
        function toString():String;
        function set headers(_arg_1:Object):void;
        function set destination(_arg_1:String):void;

    }
}//package mx.messaging.messages

