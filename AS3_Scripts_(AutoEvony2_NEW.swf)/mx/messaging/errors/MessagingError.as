// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.errors.MessagingError

package mx.messaging.errors
{
    public class MessagingError extends Error 
    {

        public function MessagingError(_arg_1:String)
        {
            super(_arg_1);
        }

        public function toString():String
        {
            var _local_1:* = "[MessagingError";
            if (message != null)
            {
                _local_1 = (_local_1 + ((" message='" + message) + "']"));
            }
            else
            {
                _local_1 = (_local_1 + "]");
            };
            return (_local_1);
        }


    }
}//package mx.messaging.errors

