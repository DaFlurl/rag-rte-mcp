// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.AsyncDispatcher

package mx.rpc
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class AsyncDispatcher 
    {

        private var _method:Function;
        private var _timer:Timer;
        private var _args:Array;

        public function AsyncDispatcher(_arg_1:Function, _arg_2:Array, _arg_3:Number)
        {
            _method = _arg_1;
            _args = _arg_2;
            _timer = new Timer(_arg_3);
            _timer.addEventListener(TimerEvent.TIMER, timerEventHandler);
            _timer.start();
        }

        private function timerEventHandler(_arg_1:TimerEvent):void
        {
            _timer.stop();
            _timer.removeEventListener(TimerEvent.TIMER, timerEventHandler);
            _method.apply(null, _args);
        }


    }
}//package mx.rpc

