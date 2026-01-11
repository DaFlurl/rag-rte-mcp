// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.IndexChangedEvent

package mx.events
{
    import flash.events.Event;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class IndexChangedEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const CHANGE:String = "change";
        public static const CHILD_INDEX_CHANGE:String = "childIndexChange";
        public static const HEADER_SHIFT:String = "headerShift";

        public var newIndex:Number;
        public var triggerEvent:Event;
        public var relatedObject:DisplayObject;
        public var oldIndex:Number;

        public function IndexChangedEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:DisplayObject=null, _arg_5:Number=-1, _arg_6:Number=-1, _arg_7:Event=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.relatedObject = _arg_4;
            this.oldIndex = _arg_5;
            this.newIndex = _arg_6;
            this.triggerEvent = _arg_7;
        }

        override public function clone():Event
        {
            return (new IndexChangedEvent(type, bubbles, cancelable, relatedObject, oldIndex, newIndex, triggerEvent));
        }


    }
}//package mx.events

