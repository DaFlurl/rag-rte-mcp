package org.httpclient
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HttpTimer
   {
      
      private var _onTimeout:Function;
      
      private var _timer:Timer;
      
      private var _timeout:Number = 60000;
      
      private var _lastSeen:Number = -1;
      
      public function HttpTimer(param1:Number, param2:Function)
      {
         super();
         if(param1 <= 0)
         {
            throw new ArgumentError("Timeout should be specified in milliseconds greater than 0");
         }
         if(param1 > 0)
         {
            this._timeout = param1;
         }
         this._onTimeout = param2;
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public function stop() : void
      {
         this._timer.stop();
      }
      
      public function reset() : void
      {
         this._lastSeen = new Date().time;
      }
      
      public function start() : void
      {
         this.reset();
         this._timer.start();
      }
      
      public function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = this.now - this._lastSeen;
         if(_loc2_ > this._timeout)
         {
            this._onTimeout(_loc2_);
            this.reset();
         }
      }
      
      public function get now() : Number
      {
         return new Date().time;
      }
   }
}

