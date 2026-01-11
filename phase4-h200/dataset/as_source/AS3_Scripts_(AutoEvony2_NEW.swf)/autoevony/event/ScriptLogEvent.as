// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.ScriptLogEvent

package autoevony.event
{
    import flash.events.Event;
    import autoevony.scripts.CityState;

    public class ScriptLogEvent extends Event 
    {

        public static const MESSAGE:int = 0;
        public static const ERROR:int = 1;
        public static const TYPE:String = "LogEventType";

        public var logText:String;
        public var logType:int;
        public var logCity:CityState;

        public function ScriptLogEvent(_arg_1:String, _arg_2:int=0, _arg_3:CityState=null)
        {
            super(TYPE);
            this.logText = _arg_1;
            this.logType = _arg_2;
            this.logCity = _arg_3;
        }

    }
}//package autoevony.event

