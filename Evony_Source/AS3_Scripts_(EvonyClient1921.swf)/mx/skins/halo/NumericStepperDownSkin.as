// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.NumericStepperDownSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.utils.ColorUtil;
    import mx.styles.StyleManager;
    import flash.display.Graphics;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NumericStepperDownSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var cache:Object = {};


        private static function calcDerivedStyles(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint):Object
        {
            var _local_6:Object;
            var _local_5:String = HaloColors.getCacheKey(_arg_1, _arg_2, _arg_3, _arg_4);
            if (!cache[_local_5])
            {
                _local_6 = (cache[_local_5] = {});
                HaloColors.addHaloColors(_local_6, _arg_1, _arg_3, _arg_4);
                _local_6.borderColorDrk1 = ColorUtil.adjustBrightness2(_arg_2, -50);
                _local_6.borderColorDrk2 = ColorUtil.adjustBrightness2(_arg_2, -25);
            };
            return (cache[_local_5]);
        }


        override public function get measuredWidth():Number
        {
            return (19);
        }

        override public function get measuredHeight():Number
        {
            return (11);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:Array;
            var _local_16:Array;
            var _local_17:Array;
            var _local_18:Array;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:uint = getStyle("iconColor");
            var _local_4:uint = getStyle("borderColor");
            var _local_5:Number = getStyle("cornerRadius");
            var _local_6:Array = getStyle("fillAlphas");
            var _local_7:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_7);
            var _local_8:uint = getStyle("themeColor");
            var _local_9:Object = calcDerivedStyles(_local_8, _local_4, _local_7[0], _local_7[1]);
            var _local_10:Object = {
                "tl":0,
                "tr":0,
                "bl":0,
                "br":_local_5
            };
            var _local_11:Object = {
                "tl":0,
                "tr":0,
                "bl":0,
                "br":Math.max((_local_5 - 1), 0)
            };
            var _local_12:Graphics = graphics;
            _local_12.clear();
            switch (name)
            {
                case "downArrowUpSkin":
                    _local_13 = [_local_7[0], _local_7[1]];
                    _local_14 = [_local_6[0], _local_6[1]];
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_10, [_local_9.borderColorDrk2, _local_9.borderColorDrk1], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":0,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 1),
                        "r":_local_11
                    });
                    drawRoundRect(1, 0, (_arg_1 - 2), (_arg_2 - 1), _local_11, _local_13, _local_14, verticalGradientMatrix(1, (1 - _arg_2), (_arg_1 - 2), ((2 * _arg_2) - 2)));
                    break;
                case "downArrowOverSkin":
                    if (_local_7.length > 2)
                    {
                        _local_15 = [_local_7[2], _local_7[3]];
                    }
                    else
                    {
                        _local_15 = [_local_7[0], _local_7[1]];
                    };
                    if (_local_6.length > 2)
                    {
                        _local_16 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_16 = [_local_6[0], _local_6[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_10, [_local_9.themeColDrk2, _local_9.themeColDrk1], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":0,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 1),
                        "r":_local_11
                    });
                    drawRoundRect(1, 0, (_arg_1 - 2), (_arg_2 - 1), _local_11, _local_15, _local_16, verticalGradientMatrix(1, (1 - _arg_2), (_arg_1 - 2), ((2 * _arg_2) - 2)));
                    break;
                case "downArrowDownSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_10, [_local_9.themeColDrk2, _local_9.themeColDrk1], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 0, (_arg_1 - 2), (_arg_2 - 1), _local_11, [_local_9.fillColorPress1, _local_9.fillColorPress2], 1, verticalGradientMatrix(1, (1 - _arg_2), (_arg_1 - 2), ((2 * _arg_2) - 2)));
                    break;
                case "downArrowDisabledSkin":
                    _local_17 = [_local_7[0], _local_7[1]];
                    _local_18 = [Math.max(0, (_local_6[0] - 0.15)), Math.max(0, (_local_6[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_10, [_local_9.borderColorDrk2, _local_9.borderColorDrk1], 0.5, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":0,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 1),
                        "r":_local_11
                    });
                    drawRoundRect(1, 0, (_arg_1 - 2), (_arg_2 - 1), _local_11, _local_17, _local_18, verticalGradientMatrix(1, (1 - _arg_2), (_arg_1 - 2), ((2 * _arg_2) - 2)));
                    _local_3 = getStyle("disabledIconColor");
                    break;
            };
            _local_12.beginFill(_local_3);
            _local_12.moveTo((_arg_1 / 2), ((_arg_2 / 2) + 1.5));
            _local_12.lineTo(((_arg_1 / 2) - 3.5), ((_arg_2 / 2) - 2.5));
            _local_12.lineTo(((_arg_1 / 2) + 3.5), ((_arg_2 / 2) - 2.5));
            _local_12.lineTo((_arg_1 / 2), ((_arg_2 / 2) + 1.5));
            _local_12.endFill();
        }


    }
}//package mx.skins.halo

