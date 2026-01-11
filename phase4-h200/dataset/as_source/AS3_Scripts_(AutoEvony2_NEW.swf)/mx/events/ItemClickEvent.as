// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ItemClickEvent

package mx.events
{
    import flash.events.Event;
    import flash.display.InteractiveObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ItemClickEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const ITEM_CLICK:String = "itemClick";

        public var relatedObject:InteractiveObject;
        public var index:int;
        public var label:String;
        public var item:Object;

        public function ItemClickEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:int=-1, _arg_6:InteractiveObject=null, _arg_7:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.label = _arg_4;
            this.index = _arg_5;
            this.relatedObject = _arg_6;
            this.item = _arg_7;
        }

        override public function clone():Event
        {
            return (new ItemClickEvent(type, bubbles, cancelable, label, index, relatedObject, item));
        }


    }
}//package mx.events

