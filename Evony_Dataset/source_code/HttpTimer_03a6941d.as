// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.HttpTimer

package org.httpclient
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class HttpTimer 
    {

        private var _onTimeout:Function;
        private var _timer:Timer;
        private var _timeout:Number = 60000;
        private var _lastSeen:Number = -1;

        public function HttpTimer(_arg_1:Number, _arg_2:Function)
        {
            if (_arg_1 <= 0)
            {
                throw (new ArgumentError("Timeout should be specified in milliseconds greater than 0"));
            };
            if (_arg_1 > 0)
            {
                this._timeout = _arg_1;
            };
            this._onTimeout = _arg_2;
            this._timer = new Timer(1000);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        }

        public function stop():void
        {
            this._timer.stop();
        }

        public function reset():void
        {
            this._lastSeen = new Date().time;
        }

        public function start():void
        {
            this.reset();
            this._timer.start();
        }

        public function onTimer(_arg_1:TimerEvent):void
        {
            var _local_2:Number = (this.now - this._lastSeen);
            if (_local_2 > this._timeout)
            {
                this._onTimeout(_local_2);
                this.reset();
            };
        }

        public function get now():Number
        {
            return (new Date().time);
        }


    }
}//package org.httpclient

