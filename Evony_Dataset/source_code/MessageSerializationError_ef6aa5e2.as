// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.errors.MessageSerializationError

package mx.messaging.errors
{
    import mx.messaging.messages.ErrorMessage;

    public class MessageSerializationError extends MessagingError 
    {

        public var fault:ErrorMessage;

        public function MessageSerializationError(_arg_1:String, _arg_2:ErrorMessage)
        {
            super(_arg_1);
            this.fault = _arg_2;
        }

    }
}//package mx.messaging.errors

