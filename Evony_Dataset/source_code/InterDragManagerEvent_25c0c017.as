// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.InterDragManagerEvent

package mx.events
{
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import mx.core.IUIComponent;
    import mx.core.DragSource;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class InterDragManagerEvent extends DragEvent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const DISPATCH_DRAG_EVENT:String = "dispatchDragEvent";

        public var dropTarget:DisplayObject;
        public var dragEventType:String;

        public function InterDragManagerEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Number=NaN, _arg_5:Number=NaN, _arg_6:InteractiveObject=null, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false, _arg_10:Boolean=false, _arg_11:int=0, _arg_12:DisplayObject=null, _arg_13:String=null, _arg_14:IUIComponent=null, _arg_15:DragSource=null, _arg_16:String=null, _arg_17:Object=null)
        {
            super(_arg_1, false, false, _arg_14, _arg_15, _arg_16, _arg_7, _arg_8, _arg_9);
            this.dropTarget = _arg_12;
            this.dragEventType = _arg_13;
            this.draggedItem = _arg_17;
            this.localX = _arg_4;
            this.localY = _arg_5;
            this.buttonDown = _arg_10;
            this.delta = _arg_11;
            this.relatedObject = _arg_6;
        }

        override public function clone():Event
        {
            return (new InterDragManagerEvent(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, dropTarget, dragEventType, dragInitiator, dragSource, action, draggedItem));
        }


    }
}//package mx.events

