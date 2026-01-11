// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.TimeStay

package view.ui
{
    import mx.controls.Label;
    import flash.utils.Timer;
    import com.evony.Context;

    public class TimeStay extends Label 
    {

        public var callBack:Function;
        private var myTimer:Timer;
        private var time:Number = 0;


        public static function secondToString(_arg_1:Number):String
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_2:* = "";
            var _local_3:int = int((_arg_1 / ((24 * 60) * 60)));
            if (_local_3 > 10)
            {
                _local_2 = (_local_2 + "more than 10 days");
            }
            else
            {
                if (_local_3 > 0)
                {
                    _local_2 = (_local_2 + (_local_3 + "D "));
                };
                _local_4 = int(((_arg_1 / (60 * 60)) % 24));
                if (((_local_2.length > 0) || (_local_4 > 0)))
                {
                    _local_2 = (_local_2 + (_local_4 + "H "));
                };
                _local_5 = int(((_arg_1 / 60) % 60));
                if (((_local_2.length > 0) || (_local_5 > 0)))
                {
                    _local_2 = (_local_2 + (_local_5 + "M "));
                };
                _local_6 = (_arg_1 % 60);
                if (_local_6 < 10)
                {
                    _local_2 = (_local_2 + "0");
                };
                _local_2 = (_local_2 + (_local_6 + "S"));
            };
            return (_local_2);
        }


        override public function initialize():void
        {
            super.initialize();
        }

        public function set timeReach(_arg_1:Number):void
        {
            this.time = _arg_1;
            var _local_2:Number = new Date().valueOf();
            var _local_3:Number = Context.getInstance().getTimeDiff();
            var _local_4:Number = (((_local_2 - time) - _local_3) / 1000);
            if (_local_4 > 0)
            {
                this.text = secondToString(_local_4);
            }
            else
            {
                this.text = "0";
            };
        }


    }
}//package view.ui

