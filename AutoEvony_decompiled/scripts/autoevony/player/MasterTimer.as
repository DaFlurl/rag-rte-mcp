package autoevony.player
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MasterTimer
   {
      
      private static var MAXEMERGENCYCOUNT:int = 5;
      
      private static var masterTimer:MasterTimer = new MasterTimer();
      
      private static var emergencyCount:int = 0;
      
      private var emergencyQueue:Array = new Array();
      
      private var timer:Timer;
      
      private var nextActiveTime:Number = 0;
      
      private var normalQueueIndex:int = 0;
      
      private var sendSlotSize:int = 20;
      
      private var maxId:int = 0;
      
      private var slotSize:int = 25;
      
      private var normalQueue:Array = new Array();
      
      private var currentId:int = 0;
      
      private var counter:int = 0;
      
      public function MasterTimer()
      {
         super();
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.timer.start();
      }
      
      public static function getInstance() : MasterTimer
      {
         return masterTimer;
      }
      
      public function deleteSlot(param1:int) : void
      {
         var _loc2_:int = int(this.normalQueue.indexOf(param1));
         if(_loc2_ != -1)
         {
            this.normalQueue.splice(_loc2_,1);
         }
      }
      
      public function setNextActiveTime(param1:int = 10) : void
      {
         if(this.normalQueue.length <= 1)
         {
            return;
         }
         this.counter = this.sendSlotSize;
         var _loc2_:Number = Number(new Date().getTime());
         var _loc3_:Number = Math.max(_loc2_,this.nextActiveTime) + param1 * 1000;
         this.nextActiveTime = Math.min(_loc3_,_loc2_ + 600 * 1000);
      }
      
      public function reserveEmergencySlot(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(param2)
         {
            _loc3_ = int(this.emergencyQueue.indexOf(param1));
            if(_loc3_ != -1 && _loc3_ != 0)
            {
               this.emergencyQueue.splice(_loc3_,1);
            }
            if(_loc3_ != 0)
            {
               this.emergencyQueue.splice(0,0,param1);
            }
         }
         else if(!this.canSend(param1) && this.emergencyQueue.indexOf(param1) == -1)
         {
            this.emergencyQueue.push(param1);
         }
      }
      
      public function reserveSlot() : int
      {
         this.normalQueue.push(this.maxId);
         return this.maxId++;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(new Date().getTime() < this.nextActiveTime)
         {
            return;
         }
         if(++this.counter < this.slotSize)
         {
            return;
         }
         this.counter = 0;
         if(emergencyCount < MAXEMERGENCYCOUNT)
         {
            if(this.emergencyQueue.length > 0)
            {
               this.currentId = this.emergencyQueue[0];
               this.emergencyQueue.splice(0,1);
               ++emergencyCount;
               return;
            }
         }
         emergencyCount = 0;
         if(this.normalQueue.length == 0)
         {
            return;
         }
         this.normalQueueIndex = (this.normalQueueIndex + 1) % this.normalQueue.length;
         this.currentId = this.normalQueue[this.normalQueueIndex];
      }
      
      public function canReceive(param1:int) : Boolean
      {
         if(this.normalQueue.length <= 1)
         {
            return true;
         }
         return param1 == this.currentId;
      }
      
      public function canSend(param1:int) : Boolean
      {
         if(new Date().getTime() < this.nextActiveTime)
         {
            return false;
         }
         if(this.normalQueue.length <= 1)
         {
            return true;
         }
         return param1 == this.currentId && this.counter < this.sendSlotSize;
      }
   }
}

