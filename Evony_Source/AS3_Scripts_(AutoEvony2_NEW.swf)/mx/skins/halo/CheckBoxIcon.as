// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.CheckBoxIcon

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.utils.ColorUtil;
    import mx.styles.StyleManager;
    import flash.display.Graphics;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CheckBoxIcon extends Border 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
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
            };
            return (cache[_local_5]);
        }


        override public function get measuredWidth():Number
        {
            return (14);
        }

        override public function get measuredHeight():Number
        {
            return (14);
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
            var _local_3:uint = getStyle("borderColor");
            var _local_4:uint = getStyle("iconColor");
            var _local_5:Array = getStyle("fillAlphas");
            var _local_6:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_6);
            var _local_7:Array = getStyle("highlightAlphas");
            var _local_8:uint = getStyle("themeColor");
            var _local_9:Object = calcDerivedStyles(_local_8, _local_3, _local_6[0], _local_6[1]);
            var _local_10:Number = ColorUtil.adjustBrightness2(_local_3, -50);
            var _local_11:Number = ColorUtil.adjustBrightness2(_local_8, -25);
            var _local_12:Boolean;
            var _local_19:Graphics = graphics;
            _local_19.clear();
            switch (name)
            {
                case "upIcon":
                    _local_13 = [_local_6[0], _local_6[1]];
                    _local_14 = [_local_5[0], _local_5[1]];
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_3, _local_10], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_13, _local_14, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), 0, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    break;
                case "overIcon":
                    if (_local_6.length > 2)
                    {
                        _local_15 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_15 = [_local_6[0], _local_6[1]];
                    };
                    if (_local_5.length > 2)
                    {
                        _local_16 = [_local_5[2], _local_5[3]];
                    }
                    else
                    {
                        _local_16 = [_local_5[0], _local_5[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_15, _local_16, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), 0, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    break;
                case "downIcon":
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, [_local_9.fillColorPress1, _local_9.fillColorPress2], 1, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), 0, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    break;
                case "disabledIcon":
                    _local_17 = [_local_6[0], _local_6[1]];
                    _local_18 = [Math.max(0, (_local_5[0] - 0.15)), Math.max(0, (_local_5[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_3, _local_10], 0.5, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_17, _local_18, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    break;
                case "selectedUpIcon":
                    _local_12 = true;
                    _local_13 = [_local_6[0], _local_6[1]];
                    _local_14 = [_local_5[0], _local_5[1]];
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_3, _local_10], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_13, _local_14, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), 0, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    break;
                case "selectedOverIcon":
                    _local_12 = true;
                    if (_local_6.length > 2)
                    {
                        _local_15 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_15 = [_local_6[0], _local_6[1]];
                    };
                    if (_local_5.length > 2)
                    {
                        _local_16 = [_local_5[2], _local_5[3]];
                    }
                    else
                    {
                        _local_16 = [_local_5[0], _local_5[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_15, _local_16, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), 0, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    break;
                case "selectedDownIcon":
                    _local_12 = true;
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, [_local_9.fillColorPress1, _local_9.fillColorPress2], 1, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), 0, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    break;
                case "selectedDisabledIcon":
                    _local_12 = true;
                    _local_4 = getStyle("disabledIconColor");
                    _local_17 = [_local_6[0], _local_6[1]];
                    _local_18 = [Math.max(0, (_local_5[0] - 0.15)), Math.max(0, (_local_5[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_3, _local_10], 0.5, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_17, _local_18, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    break;
            };
            if (_local_12)
            {
                _local_19.beginFill(_local_4);
                _local_19.moveTo(3, 5);
                _local_19.lineTo(5, 10);
                _local_19.lineTo(7, 10);
                _local_19.lineTo(12, 2);
                _local_19.lineTo(13, 1);
                _local_19.lineTo(11, 1);
                _local_19.lineTo(6.5, 7);
                _local_19.lineTo(5, 5);
                _local_19.lineTo(3, 5);
                _local_19.endFill();
            };
        }


    }
}//package mx.skins.halo

