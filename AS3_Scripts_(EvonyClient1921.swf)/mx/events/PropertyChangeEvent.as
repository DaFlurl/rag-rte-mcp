// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.PropertyChangeEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PropertyChangeEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const PROPERTY_CHANGE:String = "propertyChange";

        public var newValue:Object;
        public var kind:String;
        public var property:Object;
        public var oldValue:Object;
        public var source:Object;

        public function PropertyChangeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:Object=null, _arg_6:Object=null, _arg_7:Object=null, _arg_8:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.kind = _arg_4;
            this.property = _arg_5;
            this.oldValue = _arg_6;
            this.newValue = _arg_7;
            this.source = _arg_8;
        }

        public static function createUpdateEvent(_arg_1:Object, _arg_2:Object, _arg_3:Object, _arg_4:Object):PropertyChangeEvent
        {
            var _local_5:PropertyChangeEvent = new PropertyChangeEvent(PROPERTY_CHANGE);
            _local_5.kind = PropertyChangeEventKind.UPDATE;
            _local_5.oldValue = _arg_3;
            _local_5.newValue = _arg_4;
            _local_5.source = _arg_1;
            _local_5.property = _arg_2;
            return (_local_5);
        }


        override public function clone():Event
        {
            return (new PropertyChangeEvent(type, bubbles, cancelable, kind, property, oldValue, newValue, source));
        }


    }
}//package mx.events

