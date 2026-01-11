// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IFocusManagerComponent

package mx.managers
{
    public interface IFocusManagerComponent 
    {

        function set focusEnabled(_arg_1:Boolean):void;
        function drawFocus(_arg_1:Boolean):void;
        function setFocus():void;
        function get focusEnabled():Boolean;
        function get tabEnabled():Boolean;
        function get tabIndex():int;
        function get mouseFocusEnabled():Boolean;

    }
}//package mx.managers

