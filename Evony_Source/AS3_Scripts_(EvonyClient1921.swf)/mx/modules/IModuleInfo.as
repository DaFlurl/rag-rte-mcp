// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.modules.IModuleInfo

package mx.modules
{
    import flash.events.IEventDispatcher;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.utils.ByteArray;
    import mx.core.IFlexModuleFactory;

    public interface IModuleInfo extends IEventDispatcher 
    {

        function get ready():Boolean;
        function get loaded():Boolean;
        function load(_arg_1:ApplicationDomain=null, _arg_2:SecurityDomain=null, _arg_3:ByteArray=null):void;
        function release():void;
        function get error():Boolean;
        function get data():Object;
        function publish(_arg_1:IFlexModuleFactory):void;
        function get factory():IFlexModuleFactory;
        function set data(_arg_1:Object):void;
        function get url():String;
        function get setup():Boolean;
        function unload():void;

    }
}//package mx.modules

