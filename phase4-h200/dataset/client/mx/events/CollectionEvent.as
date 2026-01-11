// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.CollectionEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CollectionEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const COLLECTION_CHANGE:String = "collectionChange";

        public var kind:String;
        public var location:int;
        public var items:Array;
        public var oldLocation:int;

        public function CollectionEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:int=-1, _arg_6:int=-1, _arg_7:Array=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.kind = _arg_4;
            this.location = _arg_5;
            this.oldLocation = _arg_6;
            this.items = ((_arg_7) ? _arg_7 : []);
        }

        override public function toString():String
        {
            return (formatToString("CollectionEvent", "kind", "location", "oldLocation", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new CollectionEvent(type, bubbles, cancelable, kind, location, oldLocation, items));
        }


    }
}//package mx.events

