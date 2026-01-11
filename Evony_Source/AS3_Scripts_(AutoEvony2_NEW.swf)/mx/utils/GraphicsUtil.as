// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.GraphicsUtil

package mx.utils
{
    import mx.core.mx_internal;
    import flash.display.Graphics;

    use namespace mx_internal;

    public class GraphicsUtil 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        public static function drawRoundRectComplex(_arg_1:Graphics, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number):void
        {
            var _local_10:Number = (_arg_2 + _arg_4);
            var _local_11:Number = (_arg_3 + _arg_5);
            var _local_12:Number = ((_arg_4 < _arg_5) ? (_arg_4 * 2) : (_arg_5 * 2));
            _arg_6 = ((_arg_6 < _local_12) ? _arg_6 : _local_12);
            _arg_7 = ((_arg_7 < _local_12) ? _arg_7 : _local_12);
            _arg_8 = ((_arg_8 < _local_12) ? _arg_8 : _local_12);
            _arg_9 = ((_arg_9 < _local_12) ? _arg_9 : _local_12);
            var _local_13:Number = (_arg_9 * 0.292893218813453);
            var _local_14:Number = (_arg_9 * 0.585786437626905);
            _arg_1.moveTo(_local_10, (_local_11 - _arg_9));
            _arg_1.curveTo(_local_10, (_local_11 - _local_14), (_local_10 - _local_13), (_local_11 - _local_13));
            _arg_1.curveTo((_local_10 - _local_14), _local_11, (_local_10 - _arg_9), _local_11);
            _local_13 = (_arg_8 * 0.292893218813453);
            _local_14 = (_arg_8 * 0.585786437626905);
            _arg_1.lineTo((_arg_2 + _arg_8), _local_11);
            _arg_1.curveTo((_arg_2 + _local_14), _local_11, (_arg_2 + _local_13), (_local_11 - _local_13));
            _arg_1.curveTo(_arg_2, (_local_11 - _local_14), _arg_2, (_local_11 - _arg_8));
            _local_13 = (_arg_6 * 0.292893218813453);
            _local_14 = (_arg_6 * 0.585786437626905);
            _arg_1.lineTo(_arg_2, (_arg_3 + _arg_6));
            _arg_1.curveTo(_arg_2, (_arg_3 + _local_14), (_arg_2 + _local_13), (_arg_3 + _local_13));
            _arg_1.curveTo((_arg_2 + _local_14), _arg_3, (_arg_2 + _arg_6), _arg_3);
            _local_13 = (_arg_7 * 0.292893218813453);
            _local_14 = (_arg_7 * 0.585786437626905);
            _arg_1.lineTo((_local_10 - _arg_7), _arg_3);
            _arg_1.curveTo((_local_10 - _local_14), _arg_3, (_local_10 - _local_13), (_arg_3 + _local_13));
            _arg_1.curveTo(_local_10, (_arg_3 + _local_14), _local_10, (_arg_3 + _arg_7));
            _arg_1.lineTo(_local_10, (_local_11 - _arg_9));
        }


    }
}//package mx.utils

