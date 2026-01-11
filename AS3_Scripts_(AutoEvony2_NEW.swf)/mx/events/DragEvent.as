// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.DragEvent

package mx.events
{
    import flash.events.MouseEvent;
    import mx.core.IUIComponent;
    import mx.core.DragSource;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DragEvent extends MouseEvent 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const DRAG_COMPLETE:String = "dragComplete";
        public static const DRAG_DROP:String = "dragDrop";
        public static const DRAG_ENTER:String = "dragEnter";
        public static const DRAG_EXIT:String = "dragExit";
        public static const DRAG_OVER:String = "dragOver";
        public static const DRAG_START:String = "dragStart";

        public var draggedItem:Object;
        public var action:String;
        public var dragInitiator:IUIComponent;
        public var dragSource:DragSource;

        public function DragEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=true, _arg_4:IUIComponent=null, _arg_5:DragSource=null, _arg_6:String=null, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.dragInitiator = _arg_4;
            this.dragSource = _arg_5;
            this.action = _arg_6;
            this.ctrlKey = _arg_7;
            this.altKey = _arg_8;
            this.shiftKey = _arg_9;
        }

        override public function clone():Event
        {
            var _local_1:DragEvent = new DragEvent(type, bubbles, cancelable, dragInitiator, dragSource, action, ctrlKey, altKey, shiftKey);
            _local_1.relatedObject = this.relatedObject;
            _local_1.localX = this.localX;
            _local_1.localY = this.localY;
            return (_local_1);
        }


    }
}//package mx.events

