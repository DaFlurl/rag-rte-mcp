// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ChildExistenceChangedEvent

package mx.events
{
    import flash.events.Event;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ChildExistenceChangedEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CHILD_ADD:String = "childAdd";
        public static const CHILD_REMOVE:String = "childRemove";
        public static const OVERLAY_CREATED:String = "overlayCreated";

        public var relatedObject:DisplayObject;

        public function ChildExistenceChangedEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:DisplayObject=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.relatedObject = _arg_4;
        }

        override public function clone():Event
        {
            return (new ChildExistenceChangedEvent(type, bubbles, cancelable, relatedObject));
        }


    }
}//package mx.events

