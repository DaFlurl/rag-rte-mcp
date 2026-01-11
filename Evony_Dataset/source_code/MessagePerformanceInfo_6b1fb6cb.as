// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.MessagePerformanceInfo

package mx.messaging.messages
{
    public class MessagePerformanceInfo 
    {

        public var recordMessageSizes:Boolean;
        public var pushedFlag:Boolean;
        public var serverPrePushTime:Number;
        public var receiveTime:Number;
        public var overheadTime:Number;
        public var serverPostAdapterExternalTime:Number;
        private var _infoType:String;
        public var messageSize:int;
        public var serverPreAdapterExternalTime:Number;
        public var recordMessageTimes:Boolean;
        public var sendTime:Number = 0;
        public var serverPostAdapterTime:Number;
        public var serverPreAdapterTime:Number;


        public function get infoType():String
        {
            return (this._infoType);
        }

        public function set infoType(_arg_1:String):void
        {
            var _local_2:Date;
            _infoType = _arg_1;
            if (_infoType == "OUT")
            {
                _local_2 = new Date();
                this.receiveTime = _local_2.getTime();
            };
        }


    }
}//package mx.messaging.messages

