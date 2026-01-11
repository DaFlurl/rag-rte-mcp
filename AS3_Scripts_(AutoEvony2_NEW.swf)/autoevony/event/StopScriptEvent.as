// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.StopScriptEvent

package autoevony.event
{
    import flash.events.Event;

    public class StopScriptEvent extends Event 
    {

        public static const STOP_SCRIPT:String = "LogWarEventType";

        public var castleId:int;

        public function StopScriptEvent(_arg_1:int)
        {
            super(STOP_SCRIPT);
            this.castleId = _arg_1;
        }

    }
}//package autoevony.event

