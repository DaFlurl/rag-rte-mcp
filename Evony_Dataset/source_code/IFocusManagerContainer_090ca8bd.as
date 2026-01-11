// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IFocusManagerContainer

package mx.managers
{
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;

    public interface IFocusManagerContainer extends IEventDispatcher 
    {

        function set focusManager(_arg_1:IFocusManager):void;
        function get focusManager():IFocusManager;
        function get systemManager():ISystemManager;
        function contains(_arg_1:DisplayObject):Boolean;

    }
}//package mx.managers

