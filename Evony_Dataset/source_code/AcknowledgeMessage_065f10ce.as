// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.AcknowledgeMessage

package mx.messaging.messages
{
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;

    public class AcknowledgeMessage extends AsyncMessage implements ISmallMessage 
    {

        public static const ERROR_HINT_HEADER:String = "DSErrorHint";


        override public function readExternal(_arg_1:IDataInput):void
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            super.readExternal(_arg_1);
            var _local_2:Array = readFlags(_arg_1);
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                _local_4 = (_local_2[_local_3] as uint);
                _local_5 = 0;
                if ((_local_4 >> _local_5) != 0)
                {
                    _local_6 = _local_5;
                    while (_local_6 < 6)
                    {
                        if (((_local_4 >> _local_6) & 0x01) != 0)
                        {
                            _arg_1.readObject();
                        };
                        _local_6++;
                    };
                };
                _local_3++;
            };
        }

        override public function writeExternal(_arg_1:IDataOutput):void
        {
            super.writeExternal(_arg_1);
            var _local_2:uint;
            _arg_1.writeByte(_local_2);
        }

        override public function getSmallMessage():IMessage
        {
            var _local_1:Object = this;
            if (_local_1.constructor == AcknowledgeMessage)
            {
                return (new AcknowledgeMessageExt(this));
            };
            return (null);
        }


    }
}//package mx.messaging.messages

