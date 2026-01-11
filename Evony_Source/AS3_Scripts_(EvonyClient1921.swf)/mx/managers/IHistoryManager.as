// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IHistoryManager

package mx.managers
{
    public interface IHistoryManager 
    {

        function registered():void;
        function register(_arg_1:IHistoryManagerClient):void;
        function registerHandshake():void;
        function load(_arg_1:Object):void;
        function loadInitialState():void;
        function unregister(_arg_1:IHistoryManagerClient):void;
        function save():void;

    }
}//package mx.managers

