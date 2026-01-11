// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.WarLogEvent

package autoevony.event
{
    import flash.events.Event;

    public class WarLogEvent extends Event 
    {

        public static const MESSAGE:int = 0;
        public static const ERROR:int = 1;
        public static const TYPE:String = "LogWarEventType";

        public var logText:String;
        public var logType:int;

        public function WarLogEvent(_arg_1:String, _arg_2:int=0)
        {
            super(TYPE);
            this.logType = _arg_2;
            this.logText = _arg_1;
        }

    }
}//package autoevony.event

