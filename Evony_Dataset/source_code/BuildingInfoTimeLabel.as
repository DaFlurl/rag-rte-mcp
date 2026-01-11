// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BuildingInfoTimeLabel

package view.ui
{
    import mx.controls.Label;
    import com.evony.Context;
    import com.evony.Lang;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class BuildingInfoTimeLabel extends Label 
    {

        private static var monthArr:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];


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
            _local_9 = (Lang.msg("在以下时间完成") + " ");
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
            if (Lang.msg("中文版") == "false")
            {
                _local_9 = (_local_9 + " on ");
                if (_local_3 < 10)
                {
                    _local_9 = (_local_9 + "0");
                };
                _local_9 = (_local_9 + ((((_local_3 + " ") + monthArr[_local_4]) + " ") + _local_2.fullYear));
                _local_9 = (_local_9 + ". ");
            };
            if (Lang.msg("中文版") == "true")
            {
                _local_9 = (_local_9 + " ");
                _local_9 = (_local_9 + (((((_local_3 + "/") + (((_local_4 + 1) < 10) ? ("0" + (_local_4 + 1)) : (_local_4 + 1))) + "/") + _local_2.getUTCFullYear()) + "。"));
            };
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
                this.text = "";
            }
            else
            {
                this.text = getDateStr(_arg_1);
            };
        }


    }
}//package view.ui

