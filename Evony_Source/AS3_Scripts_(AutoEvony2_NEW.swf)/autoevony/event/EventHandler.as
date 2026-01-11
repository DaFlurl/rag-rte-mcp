// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.event.EventHandler

package autoevony.event
{
    public class EventHandler 
    {

        public var type:String;
        public var callBack:Function;

        public function EventHandler(_arg_1:String, _arg_2:Function)
        {
            this.type = _arg_1;
            this.callBack = _arg_2;
        }

    }
}//package autoevony.event

