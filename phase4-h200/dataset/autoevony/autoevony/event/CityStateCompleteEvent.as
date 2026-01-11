// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.CityStateCompleteEvent

package autoevony.event
{
    import flash.events.Event;

    public class CityStateCompleteEvent extends Event 
    {

        public static const TYPE:String = "CityStateCompleteEvent";

        public var response:Object;

        public function CityStateCompleteEvent(_arg_1:Object)
        {
            super(TYPE);
            this.response = _arg_1;
        }

    }
}//package autoevony.event

