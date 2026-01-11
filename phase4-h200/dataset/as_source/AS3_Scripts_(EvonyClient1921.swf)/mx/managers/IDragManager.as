// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IDragManager

package mx.managers
{
    import mx.core.IUIComponent;
    import mx.core.DragSource;
    import flash.events.MouseEvent;
    import mx.core.IFlexDisplayObject;

    public interface IDragManager 
    {

        function showFeedback(_arg_1:String):void;
        function doDrag(_arg_1:IUIComponent, _arg_2:DragSource, _arg_3:MouseEvent, _arg_4:IFlexDisplayObject=null, _arg_5:Number=0, _arg_6:Number=0, _arg_7:Number=0.5, _arg_8:Boolean=true):void;
        function get isDragging():Boolean;
        function getFeedback():String;
        function acceptDragDrop(_arg_1:IUIComponent):void;
        function endDrag():void;

    }
}//package mx.managers

