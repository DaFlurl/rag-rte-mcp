// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.events.AbstractEvent

package mx.rpc.events
{
    import mx.messaging.events.MessageEvent;
    import mx.rpc.AsyncToken;
    import mx.messaging.messages.IMessage;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractEvent extends MessageEvent 
    {

        private var _token:AsyncToken;

        public function AbstractEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=true, _arg_4:AsyncToken=null, _arg_5:IMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5);
            _token = _arg_4;
        }

        public function get token():AsyncToken
        {
            return (_token);
        }

        mx_internal function callTokenResponders():void
        {
        }

        mx_internal function setToken(_arg_1:AsyncToken):void
        {
            _token = _arg_1;
        }


    }
}//package mx.rpc.events

