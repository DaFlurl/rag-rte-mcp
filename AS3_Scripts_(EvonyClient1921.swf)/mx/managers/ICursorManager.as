// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.ICursorManager

package mx.managers
{
    public interface ICursorManager 
    {

        function removeAllCursors():void;
        function set currentCursorYOffset(_arg_1:Number):void;
        function removeBusyCursor():void;
        function unRegisterToUseBusyCursor(_arg_1:Object):void;
        function hideCursor():void;
        function get currentCursorID():int;
        function registerToUseBusyCursor(_arg_1:Object):void;
        function setBusyCursor():void;
        function showCursor():void;
        function set currentCursorID(_arg_1:int):void;
        function setCursor(_arg_1:Class, _arg_2:int=2, _arg_3:Number=0, _arg_4:Number=0):int;
        function removeCursor(_arg_1:int):void;
        function get currentCursorXOffset():Number;
        function get currentCursorYOffset():Number;
        function set currentCursorXOffset(_arg_1:Number):void;

    }
}//package mx.managers

