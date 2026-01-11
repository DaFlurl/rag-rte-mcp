// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IPopUpManager

package mx.managers
{
    import flash.display.DisplayObject;
    import mx.core.IFlexDisplayObject;

    public interface IPopUpManager 
    {

        function createPopUp(_arg_1:DisplayObject, _arg_2:Class, _arg_3:Boolean=false, _arg_4:String=null):IFlexDisplayObject;
        function centerPopUp(_arg_1:IFlexDisplayObject):void;
        function removePopUp(_arg_1:IFlexDisplayObject):void;
        function addPopUp(_arg_1:IFlexDisplayObject, _arg_2:DisplayObject, _arg_3:Boolean=false, _arg_4:String=null):void;
        function bringToFront(_arg_1:IFlexDisplayObject):void;

    }
}//package mx.managers

