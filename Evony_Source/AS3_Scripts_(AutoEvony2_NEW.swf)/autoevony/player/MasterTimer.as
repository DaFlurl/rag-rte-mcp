// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.player.MasterTimer

package autoevony.player
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class MasterTimer 
    {

        private static var MAXEMERGENCYCOUNT:int = 5;
        private static var masterTimer:MasterTimer = new (MasterTimer)();
        private static var emergencyCount:int = 0;

        private var timer:Timer;
        private var nextActiveTime:Number = 0;
        private var normalQueueIndex:int = 0;
        private var sendSlotSize:int = 20;
        private var maxId:int = 0;
        private var slotSize:int = 25;
        private var currentId:int = 0;
        private var counter:int = 0;

        private var normalQueue:Array = new Array();
        private var emergencyQueue:Array = new Array();

        public function MasterTimer()
        {
            this.timer = new Timer(1000);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this.timer.start();
        }

        public static function getInstance():MasterTimer
        {
            return (masterTimer);
        }


        public function deleteSlot(_arg_1:int):void
        {
            var _local_2:int = this.normalQueue.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                this.normalQueue.splice(_local_2, 1);
            };
        }

        public function setNextActiveTime(_arg_1:int=10):void
        {
            if (this.normalQueue.length <= 1)
            {
                return;
            };
            this.counter = this.sendSlotSize;
            var _local_2:Number = new Date().getTime();
            var _local_3:Number = (Math.max(_local_2, this.nextActiveTime) + (_arg_1 * 1000));
            this.nextActiveTime = Math.min(_local_3, (_local_2 + (600 * 1000)));
        }

        public function reserveEmergencySlot(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:int;
            if (_arg_2)
            {
                _local_3 = this.emergencyQueue.indexOf(_arg_1);
                if (((!(_local_3 == -1)) && (!(_local_3 == 0))))
                {
                    this.emergencyQueue.splice(_local_3, 1);
                };
                if (_local_3 != 0)
                {
                    this.emergencyQueue.splice(0, 0, _arg_1);
                };
            }
            else
            {
                if (((!(this.canSend(_arg_1))) && (this.emergencyQueue.indexOf(_arg_1) == -1)))
                {
                    this.emergencyQueue.push(_arg_1);
                };
            };
        }

        public function reserveSlot():int
        {
            this.normalQueue.push(this.maxId);
            return (this.maxId++);
        }

        private function onTimer(_arg_1:TimerEvent):void
        {
            if (new Date().getTime() < this.nextActiveTime)
            {
                return;
            };
            if (++this.counter < this.slotSize)
            {
                return;
            };
            this.counter = 0;
            if (emergencyCount < MAXEMERGENCYCOUNT)
            {
                if (this.emergencyQueue.length > 0)
                {
                    this.currentId = this.emergencyQueue[0];
                    this.emergencyQueue.splice(0, 1);
                    emergencyCount++;
                    return;
                };
            };
            emergencyCount = 0;
            if (this.normalQueue.length == 0)
            {
                return;
            };
            this.normalQueueIndex = ((this.normalQueueIndex + 1) % this.normalQueue.length);
            this.currentId = this.normalQueue[this.normalQueueIndex];
        }

        public function canReceive(_arg_1:int):Boolean
        {
            if (this.normalQueue.length <= 1)
            {
                return (true);
            };
            return (_arg_1 == this.currentId);
        }

        public function canSend(_arg_1:int):Boolean
        {
            if (new Date().getTime() < this.nextActiveTime)
            {
                return (false);
            };
            if (this.normalQueue.length <= 1)
            {
                return (true);
            };
            return ((_arg_1 == this.currentId) && (this.counter < this.sendSlotSize));
        }


    }
}//package autoevony.player

