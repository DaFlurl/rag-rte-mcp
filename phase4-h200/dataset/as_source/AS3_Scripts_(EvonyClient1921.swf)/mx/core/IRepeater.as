// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IRepeater

package mx.core
{
    public interface IRepeater 
    {

        function get container():IContainer;
        function set startingIndex(_arg_1:int):void;
        function get startingIndex():int;
        function set recycleChildren(_arg_1:Boolean):void;
        function get currentItem():Object;
        function get count():int;
        function get recycleChildren():Boolean;
        function executeChildBindings():void;
        function set dataProvider(_arg_1:Object):void;
        function initializeRepeater(_arg_1:IContainer, _arg_2:Boolean):void;
        function get currentIndex():int;
        function get dataProvider():Object;
        function set count(_arg_1:int):void;

    }
}//package mx.core

