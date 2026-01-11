// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.VRule

package mx.controls
{
    import mx.core.UIComponent;
    import flash.display.Graphics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class VRule extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const DEFAULT_PREFERRED_HEIGHT:Number = 100;


        override protected function measure():void
        {
            super.measure();
            measuredWidth = getStyle("strokeWidth");
            measuredHeight = DEFAULT_PREFERRED_HEIGHT;
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Graphics = graphics;
            _local_3.clear();
            var _local_4:Number = getStyle("strokeColor");
            var _local_5:Number = getStyle("shadowColor");
            var _local_6:Number = getStyle("strokeWidth");
            if (_local_6 > _arg_1)
            {
                _local_6 = _arg_1;
            };
            var _local_7:Number = ((_arg_1 - _local_6) / 2);
            var _local_8:Number = 0;
            var _local_9:Number = (_local_7 + _local_6);
            var _local_10:Number = _arg_2;
            if (_local_6 == 1)
            {
                _local_3.beginFill(_local_4);
                _local_3.drawRect(_local_7, _local_8, (_local_9 - _local_7), _arg_2);
                _local_3.endFill();
            }
            else
            {
                if (_local_6 == 2)
                {
                    _local_3.beginFill(_local_4);
                    _local_3.drawRect(_local_7, _local_8, 1, _arg_2);
                    _local_3.endFill();
                    _local_3.beginFill(_local_5);
                    _local_3.drawRect((_local_9 - 1), _local_8, 1, _arg_2);
                    _local_3.endFill();
                }
                else
                {
                    if (_local_6 > 2)
                    {
                        _local_3.beginFill(_local_4);
                        _local_3.drawRect(_local_7, _local_8, ((_local_9 - _local_7) - 1), 1);
                        _local_3.endFill();
                        _local_3.beginFill(_local_5);
                        _local_3.drawRect((_local_9 - 1), _local_8, 1, (_arg_2 - 1));
                        _local_3.drawRect(_local_7, (_local_10 - 1), (_local_9 - _local_7), 1);
                        _local_3.endFill();
                        _local_3.beginFill(_local_4);
                        _local_3.drawRect(_local_7, (_local_8 + 1), 1, (_arg_2 - 2));
                        _local_3.endFill();
                    };
                };
            };
        }


    }
}//package mx.controls

