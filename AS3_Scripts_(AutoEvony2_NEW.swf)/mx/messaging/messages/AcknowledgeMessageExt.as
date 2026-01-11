// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.AcknowledgeMessageExt

package mx.messaging.messages
{
    import flash.utils.IExternalizable;
    import flash.utils.IDataOutput;

    public class AcknowledgeMessageExt extends AcknowledgeMessage implements IExternalizable 
    {

        private var _message:AcknowledgeMessage;

        public function AcknowledgeMessageExt(_arg_1:AcknowledgeMessage=null)
        {
            _message = _arg_1;
        }

        override public function get messageId():String
        {
            if (_message != null)
            {
                return (_message.messageId);
            };
            return (super.messageId);
        }

        override public function writeExternal(_arg_1:IDataOutput):void
        {
            if (_message != null)
            {
                _message.writeExternal(_arg_1);
            }
            else
            {
                super.writeExternal(_arg_1);
            };
        }


    }
}//package mx.messaging.messages

