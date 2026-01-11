// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BuildingInfoRemainTimeLabel

package view.ui
{
    import mx.controls.Label;
    import flash.utils.Timer;
    import com.evony.Lang;
    import com.evony.Context;
    import com.evony.common.constants.CommonConstants;
    import flash.events.TimerEvent;

    public class BuildingInfoRemainTimeLabel extends Label 
    {

        public var callBack:Function;
        private var myTimer:Timer;
        private var time:Number = 0;


        public static function secondToString(_arg_1:Number):String
        {
            var _local_2:* = "";
            var _local_3:int = int((_arg_1 / ((24 * 60) * 60)));
            var _local_4:int = int(((_arg_1 / (60 * 60)) % 24));
            if ((((_local_2.length > 0) || (_local_4 > 0)) || ((_local_4 == 0) && (!(_local_3 == 0)))))
            {
                _local_2 = (_local_2 + ((((_local_3 * 24) + _local_4) + Lang.msg("时")) + " "));
            };
            var _local_5:int = int(((_arg_1 / 60) % 60));
            if (((_local_2.length > 0) || (_local_5 > 0)))
            {
                _local_2 = (_local_2 + ((_local_5 + Lang.msg("分")) + " "));
            };
            var _local_6:int = (_arg_1 % 60);
            if (_local_6 < 10)
            {
                _local_2 = (_local_2 + "0");
            };
            _local_2 = (_local_2 + (_local_6 + Lang.msg("秒")));
            if (Lang.msg("中文版") == "false")
            {
                _local_2 = (_local_2 + ".");
            };
            if (Lang.msg("中文版") == "true")
            {
                _local_2 = (_local_2 + "。");
            };
            return (_local_2);
        }

        public static function costTime(_arg_1:Number):Boolean
        {
            var _local_2:Number = new Date().valueOf();
            var _local_3:Number = Context.getInstance().getTimeDiff();
            var _local_4:Number = (((_arg_1 + _local_3) - _local_2) / 1000);
            return (((_local_4 - (CommonConstants.FREE_SPEED_TIME_LIMIT / 1000)) > 0) ? true : false);
        }


        override public function initialize():void
        {
            super.initialize();
        }

        public function set remainTime(_arg_1:Number):void
        {
            this.time = _arg_1;
            if (((!(isNaN(_arg_1))) && (time > 0)))
            {
                if (myTimer == null)
                {
                    myTimer = new Timer(1000, 0);
                    myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                };
                if (this.timerHandler())
                {
                    this.myTimer.start();
                };
            }
            else
            {
                this.text = "";
            };
        }

        private function timerHandler(_arg_1:TimerEvent=null):Boolean
        {
            var _local_2:Number = new Date().valueOf();
            var _local_3:Number = Context.getInstance().getTimeDiff();
            var _local_4:Number = (((time + _local_3) - _local_2) / 1000);
            if (_local_4 > 0)
            {
                this.text = secondToString(_local_4);
                return (true);
            };
            trace((((this.className + "remain=") + _local_4) + " timer stop."));
            this.text = "";
            if (((!(this.callBack == null)) && (this.myTimer.running)))
            {
                this.callBack.apply(this);
            };
            this.myTimer.stop();
            return (false);
        }


    }
}//package view.ui

