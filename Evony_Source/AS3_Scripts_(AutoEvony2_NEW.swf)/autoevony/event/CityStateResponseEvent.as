// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.CityStateResponseEvent

package autoevony.event
{
    import flash.events.Event;

    public class CityStateResponseEvent extends Event 
    {

        public static const TYPE:String = "CityStateResponseEvent";

        public var response:Object;
        public var textcolor:String;
        public var message:String;

        public function CityStateResponseEvent(_arg_1:Object, _arg_2:String="", _arg_3:String="#000000")
        {
            super(TYPE);
            this.message = _arg_2;
            this.response = _arg_1;
            this.textcolor = _arg_3;
        }

    }
}//package autoevony.event

