// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IFocusManager

package mx.managers
{
    import flash.display.Sprite;
    import mx.core.IButton;
    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;
    import flash.display.InteractiveObject;

    public interface IFocusManager 
    {

        function get focusPane():Sprite;
        function getFocus():IFocusManagerComponent;
        function deactivate():void;
        function set defaultButton(_arg_1:IButton):void;
        function set focusPane(_arg_1:Sprite):void;
        function set showFocusIndicator(_arg_1:Boolean):void;
        function moveFocus(_arg_1:String, _arg_2:DisplayObject=null):void;
        function addSWFBridge(_arg_1:IEventDispatcher, _arg_2:DisplayObject):void;
        function removeSWFBridge(_arg_1:IEventDispatcher):void;
        function get defaultButtonEnabled():Boolean;
        function findFocusManagerComponent(_arg_1:InteractiveObject):IFocusManagerComponent;
        function get nextTabIndex():int;
        function get defaultButton():IButton;
        function get showFocusIndicator():Boolean;
        function setFocus(_arg_1:IFocusManagerComponent):void;
        function activate():void;
        function showFocus():void;
        function set defaultButtonEnabled(_arg_1:Boolean):void;
        function hideFocus():void;
        function getNextFocusManagerComponent(_arg_1:Boolean=false):IFocusManagerComponent;

    }
}//package mx.managers

