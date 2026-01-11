// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.TimeLabel

package view.ui
{
    import mx.controls.Label;
    import com.evony.Context;

    public class TimeLabel extends Label 
    {


        public static function getDateStr(_arg_1:Number):String
        {
            var _local_2:Date = new Date((_arg_1 + Context.getInstance().getTimeDiff()));
            var _local_3:Number = _local_2.date;
            var _local_4:Number = _local_2.month;
            var _local_5:Number = _local_2.hours;
            var _local_6:Number = _local_2.minutes;
            var _local_7:Number = _local_2.seconds;
            var _local_8:Number = _local_2.milliseconds;
            var _local_9:String = new String();
            if ((_local_4 + 1) < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + (_local_4 + 1));
            _local_9 = (_local_9 + "/");
            if (_local_3 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_3);
            _local_9 = (_local_9 + " ");
            if (_local_5 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_5);
            _local_9 = (_local_9 + ":");
            if (_local_6 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_6);
            _local_9 = (_local_9 + ":");
            if (_local_7 < 10)
            {
                _local_9 = (_local_9 + "0");
            };
            _local_9 = (_local_9 + _local_7);
            return (_local_9);
        }


        override public function initialize():void
        {
            super.initialize();
        }

        public function set time(_arg_1:Number):void
        {
            if (((isNaN(_arg_1)) || (_arg_1 == 0)))
            {
                this.text = "- -";
            }
            else
            {
                this.text = getDateStr(_arg_1);
            };
        }


    }
}//package view.ui

